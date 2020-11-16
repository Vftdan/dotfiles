function! s:setlnnum(lnnum, After)
	let l:pos=getcurpos()
	let l:pos[1]=a:lnnum
	call setpos('.', l:pos)
	if a:After != v:null
		call a:After()
	endif
endfunction

function! s:color_to_ansi(cstr, is_bg)
	let l:car=a:is_bg ? 40 : 30
	let l:cdr=[]
	if a:cstr[0] == '#'
		let l:car+=8
		let l:cdr=[2] + map(split(a:cstr[1:], '\v..\zs'), 'str2nr(v:val, 16)')
	elseif a:cstr > 15
		let l:car+=8
		let l:cdr=[2, a:cstr]
	else
		let l:cstr = a:cstr
		if l:cstr > 7
			let l:cstr-=8
			let l:car+=60
		endif
		let l:car+=l:cstr
	endif
	return [printf("\x1b[%sm", join([l:car] + l:cdr, ';')), "\x1b[m"]
endfunction

function! s:is_number(s)
	return str2nr(a:s) . '' == a:s
endfunction

function! s:synID_to_ansi(synID)
	let l:bga=''
	let l:fga=''
	let l:a=''
	let l:bgs=synIDattr(a:synID, 'bg')
	if !s:is_number(l:bgs)
		let l:bgs=synIDattr(a:synID, 'bg#')
	endif
	let l:fgs=synIDattr(a:synID, 'fg')
	if !s:is_number(l:fgs)
		let l:fgs=synIDattr(a:synID, 'fg#')
	endif
	if strchars(l:bgs)
		let l:bga=s:color_to_ansi(l:bgs, 1)[0]
	endif
	if strchars(l:fgs)
		let l:fga=s:color_to_ansi(l:fgs, 0)[0]
	endif
	return [l:bga . l:fga . l:a,  "\x1b[m"]
endfunction

function! s:linenumber(ln, cnt)
	return printf(' %' . strchars(a:cnt) . 'd ', a:ln)
endfunction

function! s:linenumber_ansi(ln, cnt)
	return join(s:color_to_ansi(3, 0), s:linenumber(a:ln, a:cnt))
endfunction

function! s:buffer_to_ansi()
	let l:lncnt=line('$')
	let l:synreg={}
	let l:alines=[]
	let l:back={}
	for l:i in range(1, l:lncnt)
		let l:ln=getline(l:i)
		let l:lnchars=split(l:ln, '\zs')
		let l:lastsi=-1
		let l:styleend=''
		let l:aln=''
		if &number
			let l:aln=s:linenumber_ansi(l:i, l:lncnt)
		endif
		for l:j in range(1, strlen(l:ln))
			let l:si=synIDtrans(synID(l:i, l:j, 1))
			if l:si != l:lastsi
				let l:style=[]
				if !has_key(l:synreg, l:si)
					let l:style=s:synID_to_ansi(l:si)
					let l:synreg[l:si]=l:style
				else
					let l:style=l:synreg[l:si]
				endif
				let l:aln.=l:styleend . l:style[0] . l:ln[l:j - 1]
				let l:styleend=l:style[1]
				let l:lastsi=l:si
			else
				let l:aln.=l:ln[l:j - 1]
			endif
		endfor
		let l:aln.=l:styleend
		call insert(l:alines, l:aln)
		if &number
			let l:ln=s:linenumber(l:i, l:lncnt) . l:ln
		endif
		let l:back[l:ln]=l:i
	endfor
	call reverse(l:alines)
	return [l:alines, l:back]
endfunction

function! ColoredBLines(...)
	let l:conv=s:buffer_to_ansi()
	let l:optstr=''
	let l:After=v:null
	if a:0
		let l:opts=a:1
		if has_key(l:opts, 'options')
			let l:optstr = ' ' . l:opts['options']
		endif
		if has_key(l:opts, 'after')
			let l:After = l:opts['after']
		endif
	endif
	call fzf#run(fzf#wrap({'source': l:conv[0], 'sink': {aln -> s:setlnnum(l:conv[1][aln], l:After)}, 'options': '--ansi --layout=reverse-list --tabstop=' . &ts . l:optstr}))
endfunction
