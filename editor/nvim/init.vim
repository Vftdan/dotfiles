" For classic vim
set encoding=utf-8
set fileencoding=utf-8
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
" Disable removing tabs on skipped empty lines
inoremap <cr> <space><bs><cr>
" Window splitting
nnoremap <C-W>% :vsp<cr>
nnoremap <C-W>" :sp<cr>
nnoremap <C-W>z :res<cr>:vertical res<cr>
nnoremap <C-W><Esc> <Esc>
" Displaying space characters
nnoremap <C-L>n :set listchars=tab:┊\ <cr>
nnoremap <C-L>s :set listchars=tab:\\\|-,eol:$,nbsp:%,space:_,trail:#<cr>
nnoremap <C-L>h :set listchars=<cr>
" Duplicate for input mode
inoremap <C-L>n <esc>:set listchars=tab:┊\ <cr>a
inoremap <C-L>s <esc>:set listchars=tab:\\\|-,eol:$,nbsp:%,space:_,trail:#<cr>a
inoremap <C-L>h <esc>:set listchars=<cr>a
inoremap <C-L><C-L> <C-L>
" Toggle mouse
function! s:togMouse()
	if &mouse == "a"
		set mouse=
	else
		set mouse=a
	endif
endfunction
command! TogMouse call <SID>togMouse()
inoremap <C-L>m <esc>:TogMouse<cr>a
nnoremap <C-L>m :TogMouse<cr>
" Duplicate line
nnoremap <C-D> mzyyp`zj
inoremap <C-D> <esc>mzyyp`zja
" Duplicate selection
vnoremap <C-D> y`>p
" Find selection
vnoremap // y/<C-R>"<CR>
vnoremap /<Right> y/<C-R>"
" Copy between Vim and X clipboards
nnoremap <A-x>p :let @"=@+<CR>
nnoremap <A-x>y :let @+=@"<CR>
" Replace
nnoremap <A-r> :%s///g<Left><Left><Left>
" Replace selection
vnoremap <A-r> y<esc>:%s/<C-R>"//g<Left><Left>
" Remove tabulation
inoremap <S-Tab> <C-D>
" Make <S-Tab> work in Windows
set t_kB=[Z
" Esc alias
imap <A-;><A-;> <esc>
imap <A-;><A-o> <esc>o
vmap <A-;><A-;> <esc>
vmap <A-;><A-o> <esc>o
" Select word
nnoremap <A-'><A-'> viw
" Clear search highlight
nnoremap <A-'>/ :nohlsearch<CR>
" Natural language
set keymap=russian-jcuken
set iminsert=0
set imsearch=0
" Color column
set colorcolumn=81
if &t_Co == 8
	hi ColorColumn guibg=DarkGrey ctermbg=Cyan
else
	hi ColorColumn guibg=DarkGrey ctermbg=DarkGrey
endif
" Characters
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
" C# indentation
au BufNewFile,BufRead,Bufenter *.cs set ts=4 sw=4 et
