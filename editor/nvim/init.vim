" For classic vim
set encoding=utf-8
set fileencoding=utf-8
set number
set autoindent
set incsearch
set laststatus=2
set ruler
" Force recompilation
" set makeprg=make\ -B
" For gvim
if has("gui_running")
	colorscheme desert
	if has("win32")
		lang en
		set bo=all
		set guifont=Courier_New:h18:cANSI:qDRAFT
	else
		set guifont=Nimbus\ Mono\ L\ Bold\ 18
	endif
endif
" Enable 16M colors
if $TERM =~ '-256color'
	set tgc
endif
" Settings for diff mode
if &diff
	set diffopt+=iwhiteeol
endif

" Plug
" Run only if installed
runtime autoload/plug.vim
if g:loaded_plug
	call plug#begin()
		Plug 'idris-hackers/idris-vim', { 'for': 'idris' } 
		Plug 'tpope/vim-fugitive'
		Plug 'tpope/vim-commentary'
		Plug 'tpope/vim-surround'
		Plug 'neovimhaskell/haskell-vim', { 'for': 'haskell' }
		Plug 'vim-scripts/synmark.vim'
		Plug 'vim-scripts/browser.vim'
		Plug 'autozimu/LanguageClient-neovim', { 'do': 'bash install.sh' }
		Plug 'roxma/nvim-yarp'
		Plug 'ncm2/ncm2'
		Plug 'ionide/Ionide-vim', { 'for': 'fsharp', 'do': 'make' }
		Plug 'easymotion/vim-easymotion'
		Plug 'mattn/calendar-vim', { 'for': 'org' }
		Plug 'jceb/vim-orgmode', { 'for': 'org' }
		Plug 'suliveevil/utl.vim'
		Plug 'Vftdan/vim-translator'
	call plug#end()
endif
" END

hi Comment ctermfg=4 guifg=#21bdde
" Highlight current line
set cursorline
hi CursorLine cterm=NONE ctermbg=239 guibg=#364b51

hi NonText guifg=#42bdff
hi TabLine cterm=underline ctermfg=15 ctermbg=242 gui=underline guibg=Grey42
hi Visual ctermbg=242 guibg=Grey42
hi CursorColumn ctermbg=0 guibg=#1b3b43
hi Constant ctermfg=13 guifg=#ff42bd
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
" Disable removing tabs on skipped empty lines
inoremap <cr> <space><bs><cr>
" Window splitting
nnoremap <C-W>% :vsp<cr>
nnoremap <C-W>" :sp<cr>
nnoremap <C-W>z :res<cr>:vertical res<cr>
nmap     <C-W>gd :sp<cr>gd
nmap     <C-W>GD :wincmd z \| sp \| set previewwindow<cr>gd
" Tabs
nnoremap <C-W><C-T> :tabnew<cr>
nnoremap <C-W>gt :sp<cr><C-W>T
nnoremap <C-W><Esc> <Esc>
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
command! TogMouse call <SID>togMouse()
inoremap <Plug>(ctrl-l-prefix)m <esc>:TogMouse<cr>a
nnoremap <C-L>m :TogMouse<cr>
" Word count
command! Wc w !wc
" New column
function! s:newcol()
	new
	wincmd L
endfunction
command! Newcol call <SID>newcol()
" Force syntax
function! s:forceSyntax(lang)
	unlet! b:current_syntax
	execute "runtime syntax/" . a:lang . ".vim"
endfunction
command! -nargs=1 ForceSyntax call <SID>forceSyntax("<args>")
" Snippets key
let g:snippetsEmu_key = "<A-space>"
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
	nmap <A-u> viwS_
endif
" EasyMotion
if !empty(globpath(&rtp, 'autoload/EasyMotion.vim'))
	let g:EasyMotion_use_upper = 1
	let g:EasyMotion_keys = 'ASDFGHJKL;ZXCVBNQWERTYUIOP'
	map '; <Plug>(easymotion-prefix)
	map ';; <Plug>(easymotion-next)
endif
" Duplicate line
nnoremap <C-D> mzyyp`zj
inoremap <C-D> <esc>mzyyp`zja
" Duplicate selection
vnoremap <C-D> y`>p
" Find selection
vnoremap // y/\V<C-R>"<CR>
vnoremap /<Right> y/\V<C-R>"
" Same for very magic
vnoremap /v/ y/\v<C-R>"<CR>
vnoremap /v<Right> y/\v<C-R>"
" Atomatic very magic
nnoremap / /\v
" Make line erasing undoable even during current insert
inoremap <C-U> <C-G>u<C-U>
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
" Select line without <EOL>
onoremap il :<C-U>normal! 0v$h<CR>
vnoremap il 0o$h
" Delete/yank line without <EOL>
nnoremap dD d:<C-U>normal! 0v$h<CR>
nnoremap yY y:<C-U>normal! 0v$h<CR>
" Delete/yank till <EOL>
nnoremap D d$
nnoremap Y y$
" Natural language
set keymap=russian-jcukenwin
lmap \| /
lmap <A-\> \|
set iminsert=0
set imsearch=0
set spelllang=en,ru
" Color column
set colorcolumn=81
if &t_Co == 8
	hi ColorColumn guibg=Grey42 ctermbg=Cyan
else
	hi ColorColumn guibg=Grey42 ctermbg=DarkGrey
endif
" Shortcut for make
nmap <F10> :w \| make<CR>
map <S-F10> <F22>
nmap <silent> <F22> :w \| wincmd z \| noswapfile bo new \| set previewwindow \| term make run<CR>
" Insert current date with seconds
map! <expr> <A-d>s system("date -Iseconds")[:-2]
" Commentary
if !empty(globpath(&rtp, 'plugin/commentary.vim'))
	xmap <C-_>  <Plug>Commentary
	nmap <C-_>  <Plug>Commentary
	omap <C-_>  <Plug>Commentary
	nmap <C-_>u <Plug>Commentary<Plug>Commentary
endif
set commentstring=//%s
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
" C# indentation
au BufNewFile,BufRead,Bufenter *.cs set ts=4 sw=4 et
" Open help about selection in VimScript
au BufNewFile,BufRead,Bufenter *.vim vmap <F1> y:help <C-R>"<CR>
" (La)TeX shortcuts
au BufNewFile,BufRead,Bufenter *.tex vnoremap <A-l>tt <esc>`>a}<esc>`<i\texttt{<esc>
au BufNewFile,BufRead,Bufenter *.tex vnoremap <A-l>bf <esc>`>a}<esc>`<i\textbf{<esc>
au BufNewFile,BufRead,Bufenter *.tex vnoremap <A-l>sl <esc>`>a}<esc>`<i\textsl{<esc>
au BufNewFile,BufRead,Bufenter *.tex vnoremap <A-l>sc <esc>`>a}<esc>`<i\textsc{<esc>
au BufNewFile,BufRead,Bufenter *.tex inoremap <A-l>#<space> \section{}<Left>
au BufNewFile,BufRead,Bufenter *.tex inoremap <A-l>##<space> \subsection{}<Left>
au BufNewFile,BufRead,Bufenter *.tex inoremap <A-l>###<space> \subsubsection{}<Left>
au BufNewFile,BufRead,Bufenter *.tex inoremap <A-l>ul<space> \begin{enumerate}<CR>\end{enumerate}<esc>O
au BufNewFile,BufRead,Bufenter *.tex inoremap <A-l>li<space> \item<space>

au BufNewFile,BufRead,Bufenter *.hs set ts=4 sw=4 et makeprg=stack\ build
map [n :cn<CR>
map [N :cN<CR>
" Fix vulnerability
if !has("patch-8.1.1365") && !has("patch8.1.1365")
	set nomodeline
endif
