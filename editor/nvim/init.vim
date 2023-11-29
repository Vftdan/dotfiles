" For classic vim
set encoding=utf-8
set fileencoding=utf-8
set nocompatible
set number
" set relativenumber
set autoindent
set incsearch
set laststatus=2
set ruler
set showcmd
set wildmenu
set wildoptions+=tagfile
if has("patch-8.2.4325") || has("nvim-0.4.0")
	set wildoptions+=pum
endif
set switchbuf=useopen,usetab,vsplit
set scrolloff=4
set sidescrolloff=4
set sidescroll=1
set shiftwidth=0
set smarttab
set cinoptions=:0t0+10
" Even without 't' it is broken when inserting at window border
set formatoptions=jroqn
set nrformats=bin,hex
set hlsearch
set splitbelow
set splitright
set tabpagemax=50
" For urls
set isfname+=:,;,?,&
" Force recompilation
" set makeprg=make\ -B
" Make sure that live logs are the same inode after writing!
set backupskip=/tmp/*,/home/vftdan/.xsession-errors,*.log,system.journal,user-????.journal
set backupcopy=yes
" For gvim
if has("gui_running")
	if has("win32")
		lang en
		set bo=all
		set guifont=Courier_New:h18:cANSI:qDRAFT
	else
		set guifont=Nimbus\ Mono\ L\ Bold\ 18
	endif
endif
" Enable 16M colors
if $TERM =~ '-256color' || $TERM =~ '-24bit'
	set tgc
endif
colorscheme vftdan_colors
" Settings for diff mode
if &diff
	set diffopt+=iwhiteeol
endif

" Plug
" Run only if installed
runtime autoload/plug.vim
if g:loaded_plug
	call plug#begin()
		if !has('nvim')
			Plug 'roxma/vim-hug-neovim-rpc'
		endif

		Plug 'vftdan/vim-hexbuffer'
		Plug 'vftdan/vim-source-buffer'
		Plug 'idris-hackers/idris-vim', { 'for': 'idris' } 
		Plug 'tpope/vim-fugitive'
		Plug 'tpope/vim-rhubarb'
		Plug 'tpope/vim-commentary'
		Plug 'tpope/vim-surround'
		Plug 'tpope/vim-repeat'
		Plug 'andymass/vim-matchup'
		Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
		Plug 'vim-scripts/synmark.vim'
		Plug 'autozimu/LanguageClient-neovim', { 'do': 'bash install.sh' }
		Plug 'roxma/nvim-yarp'
		Plug 'ncm2/ncm2'
		Plug 'ionide/Ionide-vim', { 'for': 'fsharp', 'do': 'make' }
		Plug 'easymotion/vim-easymotion'
		Plug 'mattn/calendar-vim', { 'for': 'org' }
		Plug 'jceb/vim-orgmode', { 'for': 'org' }
		Plug 'suliveevil/utl.vim'
		Plug 'Vftdan/vim-translator'
		Plug 'baskerville/vim-sxhkdrc'
		Plug 'cespare/vim-toml'
		Plug 'vftdan/vim-mcfunction', { 'branch': 'custom-highlight' }
		Plug 'vftdan/vim-synstackwin'
		Plug 'yuratomo/w3m.vim'

		Plug 'https://gitlab.com/HiPhish/info.vim'
		Plug 'Vftdan/vim-hcl'
		Plug 'jidn/vim-dbml'
		Plug 'hjson/vim-hjson'
		Plug 'aklt/plantuml-syntax'
		Plug 'tikhomirov/vim-glsl'

		Plug 'kana/vim-textobj-user'
		Plug 'kana/vim-operator-user'
		Plug 'kana/vim-textobj-entire'
		Plug 'coderifous/textobj-word-column.vim'
		Plug 'Julian/vim-textobj-variable-segment'
		Plug 'lucapette/vim-textobj-underscore'
		Plug 'kana/vim-textobj-indent'
		Plug 'sgur/vim-textobj-parameter'
		Plug 'johntyree/vim-textobj-comment'
		Plug 'kana/vim-textobj-fold'
		Plug 'thinca/vim-textobj-between'
		Plug 'gilligan/vim-textobj-haskell', { 'for': 'haskell' }
		Plug 'saaguero/vim-textobj-pastedtext'
		Plug 'machakann/vim-textobj-delimited'
		Plug 'mattn/vim-textobj-url'
		Plug 'rbonvall/vim-textobj-latex'
		Plug 'junegunn/vim-easy-align'
		Plug 'kana/vim-submode'
		Plug 'dyng/ctrlsf.vim'
		Plug 'rgrinberg/vim-operator-gsearch'
		Plug 'mg979/vim-visual-multi'
		Plug 'mbbill/undotree'
		let g:undotree_DiffpanelHeight = min([10, &lines / 2 - 2])
		let g:undotree_SplitWidth = min([30, float2nr(round(0.27 * &columns))])
		Plug 'tomtom/quickfixsigns_vim'
		Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
		Plug 'junegunn/fzf.vim'
		let g:fzf_layout = { 'window': 'tabnew' }
		Plug 'junegunn/gv.vim'
		Plug 'airblade/vim-gitgutter'
		Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
		Plug 'Xuyuanp/nerdtree-git-plugin'
		Plug 'neoclide/vim-easygit'

		Plug 'rrethy/vim-hexokinase', { 'do': 'make hexokinase' }
		let g:Hexokinase_optInPatterns = [
					\     'full_hex',
					\     'triple_hex',
					\     'rgb',
					\     'rgba',
					\     'hsl',
					\     'hsla',
					\     'colour_names'
					\ ]
		let g:Hexokinase_highlighters = [ 'background' ]

		Plug 'Shougo/denite.nvim'
		Plug 'Vftdan/denite-command-args'
		Plug 'neoclide/denite-git'
		Plug 'Shougo/neoyank.vim'
		Plug 'delphinus/vim-denite-window'
		Plug 'w1mvy/vim-denite-tab'
		Plug 'iamcco/file-manager.vim', { 'do': 'sed -i s/file_rec/file.rec/ rplugin/python3/denite/source/file_manager.py' }
		Plug 'N0nki/denite-markdown'
		Plug 'deresmos/denite-gitdiff'
		Plug 'eikendev/denite-man'
		Plug 'iamcco/gitignore.vim'
		Plug 'hsawaji/denite-ctags'
		Plug 'Vftdan/denite-fzf'
		Plug 'igrep/denite-mapping'
		Plug 'vftdan/denite-hoogle.nvim'
		Plug 'iamcco/fzf-source.vim'

		Plug 'flazz/vim-colorschemes'
		Plug 'catppuccin/vim', { 'as': 'catppuccin' }
		Plug 'https://tildegit.org/sloum/gemini-vim-syntax'
		Plug 'vftdan/vim-gemini-protocol', { 'do': 'make' }
		Plug 'vftdan/vim-netfind'
		Plug 'vftdan/vim-termescape'

		Plug 'lifepillar/pgsql.vim'
		let g:sql_type_default = 'pgsql'

		" For doc
		Plug 'junegunn/vim-plug'
	call plug#end()
endif
" END

hi def link Quote Delimiter
hi     link w3mUrl Comment
hi     link w3mLink Comment
hi     link w3mLinkHover Underlined
hi     link plantumlColonLine String
hi     link plantumlSequenceDivider Title
" Highlight current line
set cursorline

" Scroll only one line for mouse wheel events to get smooth scrolling on touch screens
set mouse=a
map <ScrollWheelUp> <C-Y>
imap <ScrollWheelUp> <C-X><C-Y>
map <ScrollWheelDown> <C-E>
imap <ScrollWheelDown> <C-X><C-E>
set number
set title
set list
set listchars=tab:┊\ 
set timeoutlen=2500
set ttimeout
set ttimeoutlen=50
if !empty(globpath(&rtp, 'autoload/fugitive.vim'))
	set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P
endif
" Command mode aliases
function! SetupCommandAlias(from, to)
	exec 'cnoreabbrev <expr> ' . a:from
	\ . ' ((getcmdtype() is# ":" && getcmdline() is# "' . a:from . '")'
	\ . '? ("' . a:to . '") : ("' . a:from . '"))'
endfunction
command! -nargs=* Calias call SetupCommandAlias([<f-args>][0], join([<f-args>][1:]))
Calias calias Calias
Calias nvim visual
Calias W! w!
Calias Q! q!
Calias Qall! qall!
Calias Wq wq
Calias Wa wa
Calias wQ wq
Calias WQ wq
Calias W w
Calias Q q
Calias Qall qall
Calias tsp tab sp
Calias tsplit tab split
Calias open view
" Override shortest version of :oldfiles
Calias o view
" Make parent directories for the current file
command! -bar Mkdirs call mkdir(expand('%:h'), 'p')
Calias mkdirs Mkdirs
command! -bar TcdHere exe 'tcd ' . expand('%:h')
command! -bar LcdHere exe 'lcd ' . expand('%:h')
command! -bar GcdHere exe 'cd ' . expand('%:h')
Calias wcd lcd
Calias WcdHere LcdHere
" Rename current buffer in vim and filesystem (PROBLEM: '-n' flag for mv(1) doesn't add non-zero exit conditions)
command! -nargs=? -bar -complete=file RenameBuf if len(<q-args>) | exe '!mv -n ' . shellescape(@%) . ' ' . shellescape(<q-args>) | file <args> | e | else | call feedkeys(":RenameBuf \<C-r>%", 'ni') | endif
" Disable removing tabs on skipped empty lines
inoremap <cr> <space><bs><cr>
" Home/End
inoremap <C-G><C-A> <Home>
inoremap <C-G><C-B> <Home>
inoremap <C-G><C-E> <End>
" Diff
function! DiffFiles(file1, ...)
	execute 'e ' . a:file1
	diffthis
	for l:f in a:000
		execute 'vertical diffsplit ' . l:f
		wincmd l
	endfor
endfunction
command! -nargs=+ -bar -complete=file TabDiff tabnew | call DiffFiles(<f-args>)
" Buffers
nnoremap g<C-I>   @=":setlocal bl <bar> bn\r"<cr>
nnoremap g<C-O>   @=":setlocal bl <bar> bp\r"<cr>
nnoremap g<S-TAB> @=":setlocal bl <bar> bp\r"<cr>
" Window (command) mode
let g:wincmdmode_prefix_pattern = '\v^[1-9]?[0-9]*[gG\x17m]?$'
let g:wincmdmode_split_number_pattern = '\v^[0-9]*\zs'
let s:wincmdmode_running = v:false

function! s:wincmdmode_wrapper(sid)
	" This function exists in case if sommebody remaps <C-W> to <Plug>(wincmdmode-loop)
	if s:wincmdmode_running
		return "\<C-W>"
	endif
	return "\<C-\>\<C-N>:call " . a:sid . "wincmdmode_loop()\<cr>"
endfunction

function! s:wincmdmode_loop()
	let l:chord = ''
	let s:wincmdmode_running = v:true
	let l:vimsize = [&lines, &columns]
	let l:saved_cursor = &guicursor
	hi def link CursorWincmdMode StatusLine
	try
		while s:wincmdmode_running
			set guicursor=a:hor80-CursorWincmdMode
			mode
			echo '-- WINDOW --'
			while getchar(1) == 0
				if l:vimsize != [&lines, &columns] || !has('nvim')
					redraw
					echo '-- WINDOW --'
					let l:vimsize = [&lines, &columns]
				endif
				sleep 20m
			endwhile
			let l:key = getchar()
			if type(l:key) == 0
				let l:key = nr2char(l:key)
			endif
			let l:chord .= l:key
			if match(l:chord, g:wincmdmode_prefix_pattern) > -1
				continue
			endif
			call inputsave()
			try
				let &guicursor = l:saved_cursor
				call feedkeys(substitute(l:chord, g:wincmdmode_split_number_pattern, "\<C-W>", ''), 'x')
				let l:saved_cursor = &guicursor
				redraw
			finally
				call inputrestore()
				let l:chord = ''
			endtry
		endwhile
	finally
		let s:wincmdmode_running = v:false
		let &guicursor = l:saved_cursor
	endtry
	mode
	return ''
endfunction

function! s:wincmdmode_break_loop()
	let s:wincmdmode_running = v:false
	return ''
endfunction

function! s:wincmdmode_is_running()
	return s:wincmdmode_running
endfunction

nnoremap <expr> <Plug>(wincmdmode-loop) <SID>wincmdmode_wrapper('<SID>')
nnoremap <expr> <Plug>(wincmdmode-break) <SID>wincmdmode_break_loop()
nmap     g<C-W> <Plug>(wincmdmode-loop)
nmap     <C-W><ESC> <Plug>(wincmdmode-break)
nmap     <C-W><CR> <Plug>(noremap-colon)exe "wincmd \<lt>cr>"<cr><Plug>(wincmdmode-break)
" "<LF>" = "<C-J>"!
nmap     <C-W><space> <Plug>(wincmdmode-break)

" Last focused tab page
let s:last_focused_tab_page = get(s:, 'last_focused_tab_page', tabpagenr())
aug LastFocusedTabPage
	au!
	au TabLeave * let s:last_focused_tab_page = tabpagenr()
aug END
function! s:last_focused_tab_page_get()
	return s:last_focused_tab_page
endfunction
nnoremap <expr> <Plug>(last-focused-tab-page-switch) <SID>last_focused_tab_page_get() . 'gt'
nmap     <C-W>gp <Plug>(last-focused-tab-page-switch)

" Window splitting
nnoremap <Plug>(noremap-colon) :
nnoremap <C-W>% :vsp<cr>
nnoremap <C-W>" :sp<cr>
nmap     <C-W><bar> <Plug>(noremap-colon)wincmd <bar><cr><Plug>(wincmdmode-break)
nmap     <C-W>_ <Plug>(noremap-colon)wincmd _<cr><Plug>(wincmdmode-break)
nmap     <C-W>z <C-W><bar><C-W>_
nmap     <C-W>gd <Plug>(noremap-colon)sp<cr>gd
nmap     <C-W>GD <Plug>(noremap-colon)wincmd z \| sp \| set previewwindow<cr>gd
nmap     <C-W>g<C-D> <Plug>(noremap-colon)tab sp<cr>gd
nmap     <C-W><C-G><C-D> <Plug>(noremap-colon)tab sp<cr>gd
nnoremap <C-W>` <C-W>p
nnoremap <C-W><C-Space> <C-W>p
" Why doesn't it work without filenames by default?
nnoremap <C-W>^ :sp <cr><C-^>
nnoremap <C-W><C-^> :vsp <cr><C-^>
" Move window (it seems impossible to use it in mixed split directions)
" Expr-ception
nnoremap <C-W>mh @="@=winnr('h')\r\<lt>c-w>x\<lt><Plug>(noremap-colon)call win_gotoid(" . win_getid() . ")\r"<cr><Plug>(noremap-colon)mode<cr>
nnoremap <C-W>mj @="@=winnr('j')\r\<lt>c-w>x\<lt><Plug>(noremap-colon)call win_gotoid(" . win_getid() . ")\r"<cr><Plug>(noremap-colon)mode<cr>
nnoremap <C-W>mk @="@=winnr('k')\r\<lt>c-w>x\<lt><Plug>(noremap-colon)call win_gotoid(" . win_getid() . ")\r"<cr><Plug>(noremap-colon)mode<cr>
nnoremap <C-W>ml @="@=winnr('l')\r\<lt>c-w>x\<lt><Plug>(noremap-colon)call win_gotoid(" . win_getid() . ")\r"<cr><Plug>(noremap-colon)mode<cr>
" Tabs
nnoremap <C-W><C-T> :tabnew<cr>
" This should exist, but doesn't
nnoremap <C-W>gt gt
nnoremap <C-W>gT gT
nnoremap <C-W>g<C-T> :tab split<cr>
nmap     <C-W><C-G><C-T> <C-W>g<C-T>
nnoremap <C-W>g<C-^> :tab sp <cr><C-^>
nmap     <C-W><C-G><C-^> <C-W>g<C-^>
nnoremap <C-W>m> @=":tabmove +\r"<cr>
nnoremap <C-W>m< @=":tabmove -\r"<cr>
nnoremap <C-W>m^ :tabmove 0<cr>
nnoremap <C-W>m$ :tabmove $<cr>
nnoremap <C-W>mm @=":tabmove " . v:count . "\r"<cr>
" Throws E474 instead of wrapping!
nnoremap <C-W>g> :<C-U>exe "tabnext +" . v:count1<cr>
nnoremap <C-W>g< :<C-U>exe "tabnext -" . v:count1<cr>
nnoremap <C-W>g^ :tabrewind<cr>
nnoremap <C-W>g$ :tablast<cr>
nnoremap <C-W>gg @=":tabnext " . v:count1 . "\r"<cr>
" Use <A-C-{i,o}> to switch tabs
noremap  <A-Tab> <C-PageDown>
noremap  <C-W><A-Tab> <C-PageDown>
noremap! <A-Tab> <C-PageDown>
noremap  <A-C-O> <C-PageUp>
noremap  <C-W><A-C-O> <C-PageUp>
noremap! <A-C-O> <C-PageUp>
if has("gui_running")
	noremap  <89> <C-PageDown>
	noremap  <C-W><89> <C-PageDown>
	noremap! <89> <C-PageDown>
	noremap  <8f> <C-PageUp>
	noremap  <C-W><8f> <C-PageUp>
	noremap! <8f> <C-PageUp>
endif
" Tmux integration
if $TMUX != '' && $TMUX_PANE != ''
	if has('nvim')
		" We can avoid launching shell in nvim
		nnoremap <silent> <C-W>h @=winnr() == winnr('h') ? [system(['tmux', 'select-pane', '-L'] + (<sid>wincmdmode_is_running() ? [ ';', 'switch-client', '-Tprefix'] : [])), ''][1] : "\<lt>C-W>h"<CR>
		nnoremap <silent> <C-W>j @=winnr() == winnr('j') ? [system(['tmux', 'select-pane', '-D'] + (<sid>wincmdmode_is_running() ? [ ';', 'switch-client', '-Tprefix'] : [])), ''][1] : "\<lt>C-W>j"<CR>
		nnoremap <silent> <C-W>k @=winnr() == winnr('k') ? [system(['tmux', 'select-pane', '-U'] + (<sid>wincmdmode_is_running() ? [ ';', 'switch-client', '-Tprefix'] : [])), ''][1] : "\<lt>C-W>k"<CR>
		nnoremap <silent> <C-W>l @=winnr() == winnr('l') ? [system(['tmux', 'select-pane', '-R'] + (<sid>wincmdmode_is_running() ? [ ';', 'switch-client', '-Tprefix'] : [])), ''][1] : "\<lt>C-W>l"<CR>
	else
		nnoremap <silent> <C-W>h @=winnr() == winnr('h') ? [system('tmux select-pane -L' . (<sid>wincmdmode_is_running() ? ' \; switch-client -Tprefix' : '')), ''][1] : "\<lt>C-W>h"<CR>
		nnoremap <silent> <C-W>j @=winnr() == winnr('j') ? [system('tmux select-pane -D' . (<sid>wincmdmode_is_running() ? ' \; switch-client -Tprefix' : '')), ''][1] : "\<lt>C-W>j"<CR>
		nnoremap <silent> <C-W>k @=winnr() == winnr('k') ? [system('tmux select-pane -U' . (<sid>wincmdmode_is_running() ? ' \; switch-client -Tprefix' : '')), ''][1] : "\<lt>C-W>k"<CR>
		nnoremap <silent> <C-W>l @=winnr() == winnr('l') ? [system('tmux select-pane -R' . (<sid>wincmdmode_is_running() ? ' \; switch-client -Tprefix' : '')), ''][1] : "\<lt>C-W>l"<CR>
	endif
endif
" Org
let g:org_agenda_files = ["~/org/todo.org", "~/org/schedules.org", "~/org/projects.org", "~/org/resources.org"]
let g:org_todo_keywords = ["TODO", "FGND", "PROJ", "LOOP", "ITER", "STRT", "WAIT", "HOLD", "IDEA", "|", "DONE", "KILL", "HIDE"]
" Displaying space characters
nnoremap <C-L>n :set listchars=tab:┊\ <cr>
nnoremap <C-L>s :set listchars=tab:\\\|-,eol:$,nbsp:%,space:_,trail:#<cr>
nnoremap <C-L>h :set listchars=<cr>
" Duplicate for input mode
imap <expr> <C-L> pumvisible() ? '<C-L>' : '<Plug>(ctrl-l-prefix)'
inoremap <Plug>(ctrl-l-prefix) <C-L>
inoremap <Plug>(ctrl-l-prefix)n <esc>:set listchars=tab:┊\ <cr>a
inoremap <Plug>(ctrl-l-prefix)s <esc>:set listchars=tab:\\\|-,eol:$,nbsp:%,space:_,trail:#<cr>a
inoremap <Plug>(ctrl-l-prefix)h <esc>:set listchars=<cr>a
inoremap <Plug>(ctrl-l-prefix)<C-L> <C-L>
" Toggle mouse
function! s:togMouse()
	if &mouse == "a"
		set mouse=
	else
		set mouse=a
	endif
endfunction
command! -bar TogMouse call <SID>togMouse()
inoremap <Plug>(ctrl-l-prefix)m <esc>:TogMouse<cr>a
nnoremap <C-L>m :TogMouse<cr>
" Paste from tmux
noremap "<C-T> "=system('tmux show-buffer')<cr>
sunmap "<C-T>
map! <C-R><C-T> <C-R>=system('tmux show-buffer')<cr>
map! <C-R><C-R><C-T> <C-R><C-R>=system('tmux show-buffer')<cr>
" Word count
command! -bar Wc w !wc
" Tabs <-> spaces (only at the start of each line)
command! -range=% -nargs=? -bar ExpandTabs <line1>,<line2>s/\v%(^\t*)@<=\t/\=repeat(' ', str2nr([&ts, <f-args>][-1]))/g
command! -range=% -nargs=? -bar UnexpandTabs exe '<line1>,<line2>s/\v%(^ *)@<= {' . [&ts, <f-args>][-1] . '}/\t/g'
Calias UnExpandTabs UnexpandTabs
" ASCII art helpers
command! -range -bar AARev <line1>,<line2>!rev | tr '`./(qd<\[{'"'"',\\)pb>\]}' ''"'"',\\)pb>\]}`./(qd<\[{'
command! -range -bar AATac <line1>,<line2>!tac | tr '`'"'"'/^qpwWn\!,.\\vdbmMui' ',.\\vdbmMui`'"'"'/^qpwWn\!'
" New column
function! s:newcol(cmd)
	if a:cmd == ''
		vertical bo new
	else
		exe 'vertical bo ' . a:cmd
	endif
endfunction
command! -nargs=* -bar Newcol call <SID>newcol(<q-args>)
" Preview window
function! s:preview(cmd)
	try
		aug PreviewWindow
			au!
			au WinNew * set previewwindow
		aug END 
		exe a:cmd
	finally
		aug PreviewWindow
			au!
		aug END
	endtry
endfunction
command! -nargs=* -complete=command Preview call s:preview(<q-args>)
" Force syntax
function! s:forceSyntax(lang)
	unlet! b:current_syntax
	execute "runtime syntax/" . a:lang . ".vim"
endfunction
command! -nargs=1 -bar ForceSyntax call <SID>forceSyntax("<args>")
" Markdown <url:https://github.com/mathdown/mathdown>
let g:markdown_folding = v:true
" TODO: mathup
let g:markdown_fenced_languages = [
			\ 'c',
			\ 'sh',
			\ 'function-plot=yaml',
			\ 'math=tex',
			\ 'dot',
			\ 'lambda',
			\ 'hs=haskell',
			\ 'haskell',
			\ 'xml',
			\ 'csharp=cs',
			\ 'cs',
			\ 'yaml',
			\ 'sql',
			\ 'json',
			\ ]
if !empty(globpath(&rtp, 'syntax/lambda.vim'))
	call insert(g:markdown_fenced_languages, 'lambda')
endif
if !empty(globpath(&rtp, 'syntax/pseudocode.vim'))
	call insert(g:markdown_fenced_languages, 'pseudocode')
endif
function! MarkdownMatchMore()
	unlet b:current_syntax
	syn include @Tex syntax/tex.vim
	let b:current_syntax="markdown"
	syn match markdownTableHbar "\v-+" contained
	syn match markdownTableVbar "\v\|+" contained
	syn match markdownTable "\v^\s*\|.*[^\s\|-].*\|\s*$" contains=markdownTableVbar
	syn match markdownTableHline "\v^\s*\|[\s\|-]*-[\s\|-]*\|\s*$" contains=markdownTableVbar,markdownTableHbar
	syn region markdownTexMath start=/\v\ze\$/ end=// contains=texMathZoneX,texMathZoneY transparent
	syn cluster TOP add=texMathZoneX,texMathZoneY 
	let l:concealends = has('conceal') ? ' concealends' : ''
	exe 'syn region markdownStrike matchgroup=markdownStrikeDelimiter start="\S\@<=\~\~\|\~\~\S\@=" end="\S\@<=\~\~\|\~\~\S\@=" keepend contains=markdownLineStart' . l:concealends
	syn region markdownPandocHeader matchgroup=markdownCodeDelimiter start=/\v%^---$/ end=/\v^---$/ contains=@markdownHighlightyaml
	syn spell toplevel

	hi def link markdownTableHbar PreProc
	hi def link markdownTableVbar PreProc 
	hi def link markdownStrike htmlStrike
endfunction
aug MarkdownMatchMore
	au!
	au Syntax markdown call MarkdownMatchMore()
aug END
" Utl
function! GetSelectedText()
	let l:preserve = @a
	silent normal! gv"ay
	let l:text = @a
	let @a = l:preserve
	return l:text
endfunction
if !empty(globpath(&rtp, 'plugin/utl.vim'))
	nnoremap gl :Utl<cr>
	xnoremap gl :<C-u>call Utl('openLink', GetSelectedText())<cr>
endif 
" gemini
if !empty(globpath(&rtp, 'plugin/gemini_protocol.vim'))
	if !empty(globpath(&rtp, 'plugin/netfind.vim'))
		let g:gemini_follow_redirects = v:false
		let g:gemini_connect_with = 'ncat'
		let g:Gemini_redirect_function = function('netfind#resolve')
	endif 
endif 
" Snippets key
let g:snippetsEmu_key = "<A-space>"
" Language client and ncm2
set completeopt=menuone,noselect
" I actually don't want noselect
inoremap <expr> <C-N> pumvisible() ? "\<C-N>" : "\<C-N>\<C-N>"
inoremap <expr> <C-P> pumvisible() ? "\<C-P>" : "\<C-P>\<C-P>"
imap <expr> <C-space> pumvisible() ? "\<c-n>" : "\<c-x>\<c-o>"
if !empty(globpath(&rtp, 'autoload/LanguageClient.vim'))
	let g:LanguageClient_hoverPreview = 'Always'
	let g:LanguageClient_useFloatingHover = 0
	let g:LanguageClient_serverCommands = {
		\ 'c': ['clangd'],
		\ 'cpp': ['clangd'],
		\ 'python': ['pyls'],
		\ 'haskell': ['haskell-language-server-wrapper', '--lsp'],
	\ }
	if system('which rls') != ''
		let g:LanguageClient_serverCommands['rust'] = ['rls']
	endif
	if system('which pyright-langserver') != ''
		let g:LanguageClient_serverCommands['python'] = ['node', '--experimental-worker', split(system('which pyright-langserver'), '\n')[0], '--stdio']
	endif
	if system('which typescript-language-server') != ''
		let g:LanguageClient_serverCommands['typescript'] = ['typescript-language-server', '--stdio']
		let g:LanguageClient_serverCommands['javascript'] = ['typescript-language-server', '--stdio']
		let g:LanguageClient_serverCommands['html'] = ['typescript-language-server', '--stdio']
	endif
	if system('which jdtls') != ''
		let s:jdt_workspace = system('get-java-workspace.sh')
		if s:jdt_workspace == ''
			let s:jdt_workspace = getcwd() . '/../workspace'
		endif
		if s:jdt_workspace[-1:] == "\n"
			let s:jdt_workspace = s:jdt_workspace[:-2]
		endif
		let g:LanguageClient_serverCommands['java'] = ['jdtls', '-data', s:jdt_workspace]
		unlet s:jdt_workspace
	endif
	nnoremap <expr> gd LanguageClient_isServerRunning() ? ':call LanguageClient_textDocument_definition()<CR>' : 'gd'
	nnoremap <A-u>f :call LanguageClient_textDocument_references()<CR>
	nnoremap <F2> :call LanguageClient_textDocument_rename()<CR>
	nmap gK <plug>(lcn-hover)
	nmap g<A-CR> <plug>(lcn-menu)
	aug LCNfex
		au!
		au User LanguageClientTextDocumentDidOpenPost setlocal formatexpr=LanguageClient#textDocument_rangeFormatting_sync()
	aug END
	" For some reason gq doesn't work properly with pyls
	command! -range LSPFormat call LanguageClient#textDocument_formatting_sync({'range_start_line': <line1> - 1, 'range_end_line': <line2>})
	command! -range LSPFormatAsync call LanguageClient#textDocument_formatting({'range_start_line': <line1> - 1, 'range_end_line': <line2>})
endif
" Translator
if !empty(globpath(&rtp, 'autoload/translator.vim'))
	let g:translator_target_lang = "ru"
	let g:translator_history_enable = v:true
	let g:translator_window_type = "preview"
	nnoremap <A-t> <C-w>z:TranslateW<CR>
	vnoremap <A-t> <Esc><C-w>z:'<,'>TranslateW<CR>
endif
" Surround
if !empty(globpath(&rtp, 'plugin/surround.vim'))
	nmap <A-u><A-u> viw<Plug>VSurround_
	let g:surround_{char2nr('e')} = "\\begin{\1environment: \1}\r\\end{\1\r}.*\r\1}"
endif
" Visual multi
if !empty(globpath(&rtp, 'plugin/visual-multi.vim'))
	function! s:visual_to_vm_sequence()
		let l:seq = "`<"
				\ . ":call vm#commands#add_cursor_down(0, getpos(\"'>\")[1] - getpos(\"'<\")[1])\<cr>"
		let l:cnt = getpos("'>")[2] - getpos("'<")[2]
		if l:cnt >= 0
			let l:seq .= ":call vm#commands#motion('l', " . l:cnt . ", 1, 0)\<cr>"
		else
			let l:seq .= ":call vm#commands#motion('h', " . (-l:cnt) . ", 1, 0)\<cr>"
		endif
		return l:seq
	endfunction
	function! s:visual_to_vm_insert_sequence(ins, block_default)
		if a:block_default && visualmode() == "\<C-v>"
			return 'gv' . toupper(a:ins)
		endif
		let l:seq = s:visual_to_vm_sequence()
		let l:seq .= ":call b:VM_Selection.Insert.key('" . a:ins . "')\<cr>"
		return l:seq
	endfunction
	function! VisualToVM()
		call feedkeys(s:visual_to_vm_sequence(), 'm')
	endfunction
	nnoremap <expr> <Plug>(vftdan-visual-to-VM) <SID>visual_to_vm_sequence()
	vmap <Plug>(vftdan-visual-to-VM) <esc><Plug>(vftdan-visual-to-VM)
	nnoremap <expr> <Plug>(vftdan-visual-to-VM-insert-i) <SID>visual_to_vm_insert_sequence('i', 1)
	nnoremap <expr> <Plug>(vftdan-visual-to-VM-insert-a) <SID>visual_to_vm_insert_sequence('a', 1)
	vmap <Plug>(vftdan-visual-to-VM-insert-i) <esc><Plug>(vftdan-visual-to-VM-insert-i)
	vmap <Plug>(vftdan-visual-to-VM-insert-a) <esc><Plug>(vftdan-visual-to-VM-insert-a)
	xmap I <Plug>(vftdan-visual-to-VM-insert-i)
	xmap A <Plug>(vftdan-visual-to-VM-insert-a)
	inoremap <Plug>(VM-Hls) <C-O>:set hls<CR>
endif
" EasyMotion
if !empty(globpath(&rtp, 'autoload/EasyMotion.vim'))
	let g:EasyMotion_use_upper = 1
	let g:EasyMotion_keys = 'ASDFGHJKL;ZXCVBNQWERTYUIOP'
	map '; <Plug>(easymotion-prefix)
	map ';; <Plug>(easymotion-next)
	sunmap ';
	sunmap ';;
endif
" Duplicate line
" NOTE: repeatable with @@ , not with .
nnoremap g<C-D> @="m':t.\<lt>cr>\<lt>c-o>j"<cr>
inoremap <C-D> <esc>m':t.<cr><c-o>ja
" Duplicate selection
xnoremap g<C-D> yg`<Pg`>@={'V':'','v':(count(@","\n")?'':len(@").'l'),"\<lt>c-v>":len(split(@","\n")[-1]).'l'}[visualmode()]<cr>m`
" Find selection
xnoremap // y/\V<C-R>=escape(@", '/\')<CR><CR>
xnoremap /<Right> y/\V<C-R>=escape(@", '/\')<CR>
" Same for very magic
xnoremap /? y/\v<C-R>"<CR>
xnoremap /<S-Right> y/\v<C-R>"
" Atomatic very magic
nnoremap / /\v
xnoremap /g /\v
onoremap /g /\v
" FZF
if !empty(globpath(&rtp, 'autoload/fzf/vim.vim'))
	nmap <silent> <A-/><A-/> :call ColoredBLines({'options': '+s -e'})<CR>
	nmap <silent> <A-/><A-q> :call ColoredBLines({'options': '+s -e -m', 'after': {-> setqflist([{'bufnr': bufnr(), 'lnum': getcurpos()[1]}], 'a')}})<CR>
	command! -bar -bang MapsV  call fzf#vim#maps("v", <bang>0)
	command! -bar -bang MapsX  call fzf#vim#maps("x", <bang>0)
	command! -bar -bang MapsO  call fzf#vim#maps("o", <bang>0)
	command! -bar -bang MapsI  call fzf#vim#maps("i", <bang>0)
	command! -bar -bang MapsC  call fzf#vim#maps("c", <bang>0)
	command! -bar -bang MapsII call fzf#vim#maps("!", <bang>0)
	command! -bar -bang MapsNN call fzf#vim#maps("", <bang>0)
endif
" Easy Align
if !empty(globpath(&rtp, 'autoload/easy_align.vim'))
	xmap g=a <Plug>(EasyAlign)
endif
" Denite
if !empty(globpath(&rtp, 'autoload/denite.vim'))
	nnoremap <A-x><A-x> :Denite source<cr>
	nnoremap <A-x><C-^> :Denite buffer<cr>
	cmap <A-x> <Plug>(denite-command-args to-denite)
	autocmd FileType denite nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	autocmd FileType denite nnoremap <silent><buffer><expr> l denite#do_map('do_action', 'narrow')
	autocmd FileType denite nnoremap <silent><buffer><expr> e denite#do_map('do_action', 'edit')
	autocmd FileType denite nnoremap <silent><buffer><expr> gl denite#do_map('do_action', 'open_link')
	autocmd FileType denite nnoremap <silent><buffer><expr> <Right> denite#do_map('do_action', 'narrow')
	autocmd FileType denite nnoremap <silent><buffer><expr> <Tab> denite#do_map('toggle_select') . 'j'
	autocmd FileType denite nnoremap <silent><buffer><expr> <C-c> denite#do_map('quit')
	autocmd FileType denite nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')
	autocmd FileType denite-filter imap <silent><buffer><expr> <C-l> denite#do_map('do_action', 'narrow')
	autocmd FileType denite-filter imap <silent><buffer><expr> <C-right> denite#do_map('do_action', 'narrow')
	autocmd FileType denite-filter imap <silent><buffer><expr> <C-e> denite#do_map('do_action', 'edit')
	autocmd FileType denite-filter imap <silent><buffer> <C-c> <C-u><esc><Plug>(denite_filter_quit)
	autocmd FileType denite-filter imap <silent><buffer><expr> <Tab> denite#do_map('toggle_select') . '<Down>'
	autocmd FileType denite-filter nnoremap <silent><buffer> j :call denite#move_to_parent()<cr>:try<bar>+<bar>catch<bar>endtry<cr>:call denite#move_to_filter()<cr>
	autocmd FileType denite-filter nnoremap <silent><buffer> k :call denite#move_to_parent()<cr>:try<bar>-<bar>catch<bar>endtry<cr>:call denite#move_to_filter()<cr>

	autocmd FileType denite-filter nmap <silent><buffer> <Down> j
	autocmd FileType denite-filter nmap <silent><buffer> <Up>   k
	autocmd FileType denite-filter imap <silent><buffer> <Down> <Esc>jgi
	autocmd FileType denite-filter imap <silent><buffer> <Up>   <Esc>kgi
	autocmd FileType denite-filter imap <silent><buffer> <ScrollWheelDown> <Esc>jgi
	autocmd FileType denite-filter imap <silent><buffer> <ScrollWheelUp>   <Esc>kgi
	autocmd FileType denite-filter imap <silent><buffer><nowait> <C-j> <Esc>jgi
	autocmd FileType denite-filter imap <silent><buffer><nowait> <C-k> <Esc>kgi
	call denite#custom#option('_', {
	      \ 'start_filter': 1,
	      \ 'match_highlight': 1,
	      \ 'smartcase': 1,
	      \ 'auto_resize': 1,
	      \ })
	call denite#custom#source('_', 'matchers', ['matcher/fzf'])
	call denite#custom#source('_', 'sorters', ['sorter/fzf'])
	call denite#custom#source('hoogle', 'matchers', [])
	if system('which rg') != ''
		call denite#custom#var('grep', 'command', ['rg'])
		call denite#custom#var('grep', 'default_opts', ['-i', '--vimgrep', '--no-heading'])
		call denite#custom#var('grep', 'recursive_opts', [])
		call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
		call denite#custom#var('grep', 'separator', ['--'])
		call denite#custom#var('grep', 'final_opts', [])
	endif
endif
" Make line erasing undoable even during current insert
inoremap <C-U> <C-G>u<C-U>
" Copy between Vim and X clipboards
nnoremap <A-x>p :let @"=@+<CR>
nnoremap <A-x>y :let @+=@"<CR>
" Copy buffer file to X clipboard
function! GetBufferFileUrl(...)
	let l:bnr = 0
	if a:0
		let l:bnr = a:1
	endif
	if type(l:bnr) != 0
		let l:bnr = bufnr(l:bnr)
	endif
	let l:fname = expand((l:bnr ? '#' . l:bnr : '%') . ':p')
	let l:urlencoded = substitute(l:fname, '[^[:alnum:]\/_-]', {->join(map(range(len(submatch(0))), {->printf('%%%02x', char2nr(strpart(submatch(0), v:val, 1)))}), '')}, 'g')
	return 'file://' . l:urlencoded
endfunction
command! -nargs=0 -bar CopyClipBufferFile call system('xclip -i -selection clipboard -t text/uri-list', GetBufferFileUrl())
" Replace
nnoremap <A-r> :%s///g<Left><Left><Left>
" Replace selection
vnoremap <A-r> y<esc>:%s/\V<C-R>=join(map(getreg('"', 1, 1), {i,x->escape(x, '/\')}), '\n')<CR>//g<Left><Left>
" Remove tabulation
inoremap <S-Tab> <C-D>
snoremap <S-Tab> <C-O><lt>gv<C-G>
snoremap <C-T> <C-O>>gv<C-G>
" Make <S-Tab> work in Windows
set t_kB=[Z
" Esc alias
imap <A-;><A-;> <esc>
imap <A-;><A-o> <esc>o
vmap <A-;><A-;> <esc>
vmap <A-;><A-o> <esc>o
inoremap jkk <Esc>
inoremap jkj jk
" Select word
nnoremap <A-'><A-'> viw
" Clear search highlight
nnoremap <A-'>/ :nohlsearch<CR>
" Automatically wake up if there is no shell
nnoremap <C-z> :call system('( sleep .5; kill -CONT ' . getpid() . ';) &') <bar> suspend<cr>
" Select line without <EOL>
onoremap il :<C-U>normal! 0v$h<CR>
xnoremap il 0o$h
" Delete/yank line without <EOL>
nnoremap dD d:<C-U>normal! 0v$h<CR>
nnoremap yY y:<C-U>normal! 0v$h<CR>
" Delete/yank till <EOL>
nnoremap D d$
nnoremap Y y$
" i_CTRL-W but forward
" Warning: deletes immediately following punctuation
inoremap <C-Del> <Right><C-O>"_d:<C-U>normal! vwgeoh<CR>
" Extract to variable
vnoremap <expr> <Plug>(vftdan-extract) <sid>extract_var_sequence(v:register)
xmap g<A-e> <Plug>(vftdan-extract)
function! s:extract_var_sequence(reg)
	let l:prefix = get(b:, 'lang_var_decl_prefix', '')
	let l:equals = get(b:, 'lang_var_decl_assign_infix', ' = ')
	let l:var_prefix = get(b:, 'lang_var_prefix', '')
	let l:var_postfix = get(b:, 'lang_var_postfix', '')
	let l:postfix = get(b:, 'lang_statement_postfix', ';')
	call inputsave()
	let l:varname = input('Variable name: ')
	call inputrestore()
	return '"' . a:reg . 'c' . l:var_prefix . l:varname . l:var_postfix . "\<ESC>O" . l:prefix . l:varname
			\ . l:equals . "\<C-R>\<C-R>" . a:reg . l:postfix
			\ . "\<ESC>:let @" . a:reg . ' = "'
			\ . escape(l:varname, '"\') . "\"\<CR>"
endfunction
aug ExtractToVarLangs
	au!
	au Filetype javascript let [b:lang_var_decl_prefix, b:lang_statement_postfix] = ['var ', ';']
	au Filetype typescript let [b:lang_var_decl_prefix, b:lang_statement_postfix] = ['const ', ';']
	au Filetype python let [b:lang_var_decl_prefix, b:lang_statement_postfix] = ['', '']
	au Filetype c let [b:lang_var_decl_prefix, b:lang_statement_postfix] = ['int ', ';']
	au Filetype cpp let [b:lang_var_decl_prefix, b:lang_statement_postfix] = ['auto ', ';']
	au Filetype java let [b:lang_var_decl_prefix, b:lang_statement_postfix] = ['var ', ';']
	au Filetype vim let [b:lang_var_decl_prefix, b:lang_statement_postfix] = ['let ', '']
	au Filetype sh let [b:lang_var_decl_prefix, b:lang_statement_postfix, b:lang_var_prefix, b:lang_var_decl_assign_infix] = ['', '', '$', '=']
	au Filetype make let [b:lang_var_decl_prefix, b:lang_statement_postfix, b:lang_var_prefix, b:lang_var_postfix, b:lang_var_decl_assign_infix] = ['', '', '${', '}', '=']
	au Filetype tex let [b:lang_var_decl_prefix, b:lang_statement_postfix, b:lang_var_prefix, b:lang_var_decl_assign_infix] = ['\def\', '}', '\', '{']
	au Filetype lua let [b:lang_var_decl_prefix, b:lang_statement_postfix] = ['local ', '']
	au Filetype haskell let [b:lang_var_decl_prefix, b:lang_statement_postfix] = ['', '']
aug END
" Natural language
set keymap=russian-jcukenwin
lmap \| /
lmap <A-\> \|
lmap ḃ і
lmap Ḃ І
" " Cannot use unicode in lhs
" dig ьи 1110
" dig Ьи 1030
" dig ЬИ 1030
lmap <C-k>mb і
lmap <C-k>Mb І
lmap <C-k>MB І
lmap q̈ ї
lmap Q̈ Ї
" dig йи 1111
" dig Йи 1031
" dig ЙИ 1031
lmap <C-k>qb ї
lmap <C-k>Qb Ї
lmap <C-k>QB Ї
" dig йе 1108
" dig Йе 1028
" dig ЙЕ 1028
lmap <C-k>qt є
lmap <C-k>Qt Є
lmap <C-k>QT Є
lmap ù ґ
lmap Ù Ґ
" dig ёг 1169
" dig Ёг 1168
" dig ЁГ 1168
lmap <C-k>`u ґ
lmap <C-k>~u Ґ
lmap <C-k>~U Ґ
" lmap <C-k>qt є
" lmap <C-k>Qt Є
" lmap <C-k>QT Є
lmap ʉ ғ
lmap Ʉ Ғ
" dig гх 1171
" dig Гх 1170
" dig ГХ 1170
lmap <C-k>u[ ғ
lmap <C-k>U[ Ғ
lmap <C-k>U{ Ғ
set iminsert=0
set imsearch=0
set nolangremap
set spelllang=en,ru
" Color column
set colorcolumn=81
if &t_Co == 8
	hi ColorColumn guibg=Grey42 ctermbg=Cyan
endif
" Populate :edit with the current file path/url
nnoremap <F6> :e <C-R>=@%<CR>
" Shortcut for make
function! s:get_last_from_dict_chain(chain, key, default)
	let l:res = a:default
	for l:d in a:chain
		let l:res = get(l:d, a:key, l:res)
	endfor
	return l:res
endfunction
function! s:run_make(cmd, ...)
	let l:layout = winrestcmd()
	let l:prevwin = win_getid()
	let l:new = 'new'
	if a:0
		let l:new = a:1
	endif
	let l:inherit_vars = {}
	for l:i in ['&makeprg', '&errorformat']
		let l:var_value = getbufvar(bufnr(), l:i, v:null)
		if l:var_value != v:null
			let l:inherit_vars[l:i] = l:var_value
		else
			echoerr l:i . ' is not set'
		endif
	endfor
	exe l:new
	let l:buf = bufnr()
	let l:newwin = win_getid()
	for l:i in keys(l:inherit_vars)
		call setbufvar(bufnr(), l:i, l:inherit_vars[l:i])
	endfor
	let &l:makeprg = substitute(&makeprg, '%', '#', 'g')
	exe 'lcd ' . fnameescape(s:get_last_from_dict_chain([g:, t:, b:, w:], 'makefile_dir', '.'))
	exe a:cmd
	if bufexists(l:buf) && getbufvar(l:buf, '&buflisted') && getbufvar(l:buf, '&buftype') == '' && !getbufvar(l:buf, '&modified')
		if bufnr() == l:buf
			q
		else
			exe l:buf . 'bd'
		endif
	endif
	if l:prevwin == win_getid()
		exe l:layout
	elseif l:newwin == win_getid()
		function! s:run_make_delayed_teardown_handler(...) closure
			aug run_make_delayed_teardown | au! | aug END
			noau if win_gotoid(l:newwin)
				noau wincmd p
				if a:0 == 0
					call timer_start(0, funcref("s:run_make_delayed_teardown_handler"))
				endif
				return
			endif
			if win_gotoid(l:prevwin)
				exe l:layout
			endif
		endfunction
		aug run_make_delayed_teardown
			au!
			au WinLeave * call <sid>run_make_delayed_teardown_handler() | call timer_start(0, {-> execute('delfunction! <sid>run_make_delayed_teardown_handler')})
		aug END
	endif
endfunction
function! ListToStringShellescape(arr)
	if type(a:arr) != type([])
		return a:arr
	endif
	return join(map(a:arr, {el -> shellescape(el)}))
endfunction
nmap <F10> :update \| call <sid>run_make(<sid>get_last_from_dict_chain([g:, t:, b:, w:], 'make_current_window', v:false) ? 'ExecuteNoSwitchbuf lmake' : 'make')<CR>
map <S-F10> <F22>
" Sometimes nvim breaks with 'E317: pointer block id wrong' when running Maven from Makefile
nmap <silent> <F22> :update \| wincmd z \| call <sid>run_make('term ' . &makeprg . ' ' . ListToStringShellescape(<sid>get_last_from_dict_chain([g:, t:, b:, w:], 'make_run_target', 'run')), 'noswapfile bo new \| set previewwindow')<CR>
command! -nargs=0 -bar WindowMakeLocal let w:make_current_window = v:true | let w:list_is_location = v:true
command! -nargs=0 -bar SetMakefileHere    let g:makefile_dir = getcwd()
command! -nargs=0 -bar SetMakefileHereTab let t:makefile_dir = getcwd()
" Insert current date with seconds
map! <expr> <A-d>s system("date -Iseconds")[:-2]
function! s:format_date(fmt, descr)
	if a:descr == v:null
		return ''
	endif
	return system("date +" . shellescape(a:fmt) . " -d " . shellescape(a:descr))[:-2]
endfunction
map! <expr> <A-d>o <SID>format_date('%Y-%m-%d %a', input({'prompt': 'Which date: ', 'cancelreturn': v:null}))
" Lorem ipsum
command! -nargs=* -bar LipsumParagraph :python3 (lambda current: current.buffer.append(__import__('lipsum').generate_paragraphs((1, <args>)[-1]).split('\n'), current.window.cursor[0]))(__import__('vim').current)
" Matchup
if !empty(globpath(&rtp, 'autoload/matchup.vim'))
	let g:matchup_matchparen_offscreen = {'method': 'popup'}
endif
" Commentary
if !empty(globpath(&rtp, 'plugin/commentary.vim'))
	xmap <C-_>  <Plug>Commentary
	nmap <C-_>  <Plug>Commentary
	omap <C-_>  <Plug>Commentary
	nmap <C-_>u <Plug>Commentary<Plug>Commentary
endif
set commentstring=//%s
aug filetypecommentstring
	au!
	au Filetype debsources set commentstring=#%s
aug END
" Text objects
if !empty(globpath(&rtp, 'autoload/textobj/comment.vim'))
	let g:textobj_comment_no_default_key_mappings = 1
	xmap a<C-_> <Plug>(textobj-comment-a)
	omap a<C-_> <Plug>(textobj-comment-a)
endif
if !empty(globpath(&rtp, 'autoload/textobj/pastedtext.vim'))
	let g:pastedtext_select_key = 'iP'
endif
if !empty(globpath(&rtp, 'autoload/textobj/entire.vim'))
	let g:textobj_entire_no_default_key_mappings = 1
	xmap aE <Plug>(textobj-entire-a)
	omap aE <Plug>(textobj-entire-a)
	xmap iE <Plug>(textobj-entire-i)
	omap iE <Plug>(textobj-entire-i)
endif
" Execute macro
nmap <A-.> @q
imap <A-.> <esc>@q
" Characters
dig ~= 8776
dig jS 690
dig `: 776
dig sH 643
inoremap <C-K><space>  
inoremap <C-K>+- ±
inoremap <C-K>-+ ∓
inoremap <C-K>^ ⊕
inoremap <C-K>&<space> ∩
inoremap <C-K>\|<space> ∪
inoremap <C-K>&& ∧
inoremap <C-K>\|\| ∨
inoremap <C-K>\\ ∖
inoremap <C-K>in ∈
inoremap <C-K>!in ∉
inoremap <C-K>has ∋
inoremap <C-K>!has ∌
inoremap <C-K>each ∀
inoremap <C-K>ex ∃
inoremap <C-K>!ex ∄
inoremap <C-K>d ∆
inoremap <C-K>sub ⊂
inoremap <C-K>!sub ⊄
inoremap <C-K>ssub ⊊
inoremap <C-K>sup ⊃
inoremap <C-K>!sup ⊅
inoremap <C-K>ssup ⊋
inoremap <C-K>~> ≳
inoremap <C-K>~< ≲
inoremap <C-K>sum ∑
inoremap <C-K>prod ∏
inoremap <C-K>setN ℕ
inoremap <C-K>setZ ℤ
inoremap <C-K>setQ ℚ
inoremap <C-K>setR ℝ
inoremap <C-K>setC ℂ
" Fix collisions with digraphs
inoremap <C-K><C-K> <C-K>
" Disable some keys
nnoremap <A-'> <Nop>
nnoremap <A-x> <Nop>
imap <A-;> <Nop>
vmap <A-;> <Nop>
aug vftdan_custom
	" C# indentation
	au BufNewFile,BufRead,Bufenter *.cs set ts=4 sw=4 et
	" Open help about selection in VimScript
	au BufNewFile,BufRead,Bufenter *.vim vmap <F1> y:help <C-R>"<CR>
	" (La)TeX shortcuts
	au BufNewFile,BufRead,Bufenter *.tex vnoremap <buffer> <A-l>tt <esc>`>a}<esc>`<i\texttt{<esc>
	au BufNewFile,BufRead,Bufenter *.tex vnoremap <buffer> <A-l>bf <esc>`>a}<esc>`<i\textbf{<esc>
	au BufNewFile,BufRead,Bufenter *.tex vnoremap <buffer> <A-l>sl <esc>`>a}<esc>`<i\textsl{<esc>
	au BufNewFile,BufRead,Bufenter *.tex vnoremap <buffer> <A-l>sc <esc>`>a}<esc>`<i\textsc{<esc>
	au BufNewFile,BufRead,Bufenter *.tex inoremap <buffer> <A-l>#<space> \section{}<Left>
	au BufNewFile,BufRead,Bufenter *.tex inoremap <buffer> <A-l>##<space> \subsection{}<Left>
	au BufNewFile,BufRead,Bufenter *.tex inoremap <buffer> <A-l>###<space> \subsubsection{}<Left>
	au BufNewFile,BufRead,Bufenter *.tex inoremap <buffer> <A-l>ul<space> \begin{enumerate}<CR>\end{enumerate}<esc>O
	au BufNewFile,BufRead,Bufenter *.tex inoremap <buffer> <A-l>li<space> \item<space>
	" Jumping to form feed
	au BufNewFile,BufRead,Bufenter *.txt noremap <buffer> ]] ]]zt | sunmap <buffer> ]]
	au BufNewFile,BufRead,Bufenter *.txt noremap <buffer> [[ [[zt | sunmap <buffer> [[

	au BufNewFile,BufRead,Bufenter *.hs setlocal ts=4 sw=4 et makeprg=stack\ build
	au BufNewFile,BufRead,Bufenter *.ass setlocal commentstring=;%s
	au BufNewFile,BufRead,Bufenter yggdrasil.conf setlocal ft=hjson
	au BufNewFile,BufRead *.mcmeta setlocal ft=json
	au FileType sh call setbufvar('', '&path', execute('setg path?')[8:] . ',' . substitute(escape($PATH, ' ,\'), '[:;]', ',', 'g'))
aug END
aug modpacker
	au!
	au BufNewFile,BufRead *.pack setlocal ft=modpacker
	au Filetype modpacker let b:hcl_no_root_keywords=v:true
	au Filetype modpacker let b:hcl_no_aws_resource_keywords=v:true
	au Filetype modpacker let b:hcl_custom_keywords={'type': ['mod']}
	au Filetype modpacker runtime! syntax/hcl.vim
aug END
function! ExecuteNoSwitchbuf(cmd)
	let l:swb = &switchbuf
	try
		set switchbuf=
		execute a:cmd
	finally
		let &switchbuf = l:swb
	endtry
endfunction
command! -nargs=* -complete=command ExecuteNoSwitchbuf call ExecuteNoSwitchbuf(<q-args>)
Calias lgrep ExecuteNoSwitchbuf lgrep
Calias lvimgrep ExecuteNoSwitchbuf lvimgrep
function! TogListQL()
	let w:list_is_location = !get(w:, 'list_is_location', v:false)
	echo w:list_is_location ? 'Location' : 'QuickFix'
endfunction
command! -nargs=0 -bar TogListQL call TogListQL()
nnoremap <silent> [n :if get(w:, 'list_is_location', v:false) <bar> call ExecuteNoSwitchbuf('lnext') <bar> else <bar> cn <bar> endif<CR>
nnoremap <silent> [N :if get(w:, 'list_is_location', v:false) <bar> call ExecuteNoSwitchbuf('lNext') <bar> else <bar> cN <bar> endif<CR>
aug loclistnoswb
	au!
	au BufReadPost quickfix if getwininfo(win_getid())[0]['loclist']
	au BufReadPost quickfix 	nnoremap <silent> <buffer> <CR> :call ExecuteNoSwitchbuf("normal! \<lt>cr>")<CR>
	au BufReadPost quickfix 	nnoremap <silent> <buffer> <C-W><CR> :call ExecuteNoSwitchbuf("normal! \<lt>c-w>\<lt>cr>")<CR>
	au BufReadPost quickfix endif
aug END
" Populating quickfix and loclist with files
" ':enew | ClearLlist | PopulateLlist pattern' can be used as window-local ':args pattern'
command! -nargs=* -bar -complete=file PopulateQlist  vimgrepadd /\v%^/ <args>
command! -nargs=* -bar -complete=file PopulateLlist lvimgrepadd /\v%^/ <args>
command! -nargs=0 -bar MarkQlist call  setqflist(   [{'bufnr': bufnr(), 'lnum': line('.'), 'col': col('.'), 'text': getline('.')}], 'a')
command! -nargs=0 -bar MarkLlist call setloclist(0, [{'bufnr': bufnr(), 'lnum': line('.'), 'col': col('.'), 'text': getline('.')}], 'a')
command! -nargs=0 -bar ClearQlist call  setqflist(   [])
command! -nargs=0 -bar ClearLlist call setloclist(0, [])
command! -nargs=0 -bar CopyQlistToLlist call setloclist(0, getqflist( ))
command! -nargs=0 -bar CopyLlistToQlist call  setqflist(  getloclist(0))
command! -nargs=0 -bar OnlyCurbufQlist call  setqflist(   filter( getqflist( ), 'v:val.bufnr == bufnr()'))
command! -nargs=0 -bar OnlyCurbufLlist call setloclist(0, filter(getloclist(0), 'v:val.bufnr == bufnr()'))
Calias wargs enew \| ClearLlist \| PopulateLlist
" Fix vulnerability
if !has("patch-8.1.1365") && !has("nvim-0.3.8")
	set nomodeline
endif
