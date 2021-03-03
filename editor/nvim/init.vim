" For classic vim
set encoding=utf-8
set fileencoding=utf-8
set number
set relativenumber
set autoindent
set incsearch
set laststatus=2
set ruler
set switchbuf=useopen,usetab,vsplit
set scrolloff=4
set sidescrolloff=4
set shiftwidth=0
" Force recompilation
" set makeprg=make\ -B
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
if $TERM =~ '-256color'
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

		Plug 'idris-hackers/idris-vim', { 'for': 'idris' } 
		Plug 'tpope/vim-fugitive'
		Plug 'tpope/vim-commentary'
		Plug 'tpope/vim-surround'
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

		Plug 'https://gitlab.com/HiPhish/info.vim'

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
		Plug 'Dridus/denite-hoogle.nvim'
		Plug 'iamcco/fzf-source.vim'

		" For doc
		Plug 'junegunn/vim-plug'
	call plug#end()
endif
" END

hi def link Quote Delimiter
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
" Disable removing tabs on skipped empty lines
inoremap <cr> <space><bs><cr>
" Diff
function! DiffFiles(file1, ...)
	execute 'e ' . a:file1
	diffthis
	for l:f in a:000
		execute 'vertical diffsplit ' . l:f
		wincmd l
	endfor
endfunction
command! -nargs=+ -complete=file TabDiff tabnew | call DiffFiles(<f-args>)
" Buffers
nnoremap g<C-I>   @=":setlocal bl <bar> bn\r"<cr>
nnoremap g<C-O>   @=":setlocal bl <bar> bp\r"<cr>
nnoremap g<S-TAB> @=":setlocal bl <bar> bp\r"<cr>
" Window splitting
nnoremap <C-W>% :vsp<cr>
nnoremap <C-W>" :sp<cr>
nnoremap <C-W>z :res<cr>:vertical res<cr>
nmap     <C-W>gd <cmd>sp<cr>gd
nmap     <C-W>GD <cmd>wincmd z \| sp \| set previewwindow<cr>gd
" Why doesn't it work without filenames by default?
nnoremap <C-W>^ :sp <cr><C-^>
nnoremap <C-W><C-^> :vsp <cr><C-^>
" Tabs
nnoremap <C-W><C-T> :tabnew<cr>
nnoremap <C-W>gt :sp<cr><C-W>T
nnoremap <C-W>g<C-^> :tab sp <cr><C-^>
nmap     <C-W><C-G><C-^> <C-W>g<C-^>
nnoremap <C-W>m> @=":tabmove +\r"<cr>
nnoremap <C-W>m< @=":tabmove -\r"<cr>
nnoremap <C-W>m^ :tabmove 0<cr>
nnoremap <C-W>m$ :tabmove $<cr>
nnoremap <C-W>mm @=":tabmove " . v:count . "\r"<cr>
nnoremap <C-W>g> gt
nnoremap <C-W>g< gT
nnoremap <C-W>g^ :tabrewind<cr>
nnoremap <C-W>g$ :tablast<cr>
nnoremap <C-W>gg @=":tabnext " . v:count1 . "\r"<cr>
nnoremap <C-W><Esc> <Nop>
" Submode
if !empty(globpath(&rtp, 'autoload/submode.vim'))
	call submode#enter_with('WINDOW', 'n', '', '<C-w>+', '<C-w>+')
	call submode#enter_with('WINDOW', 'n', '', '<C-w>-', '<C-w>-')
	call submode#enter_with('WINDOW', 'n', '', '<C-w><lt>', '<C-w><lt>')
	call submode#enter_with('WINDOW', 'n', '', '<C-w>>', '<C-w>>')
	call submode#enter_with('WINDOW', 'n', '', '<C-w>h', '<C-w>h')
	call submode#enter_with('WINDOW', 'n', '', '<C-w>j', '<C-w>j')
	call submode#enter_with('WINDOW', 'n', '', '<C-w>k', '<C-w>k')
	call submode#enter_with('WINDOW', 'n', '', '<C-w>l', '<C-w>l')
	call submode#enter_with('WINDOW', 'n', '', '<C-w><left>', '<C-w>h')
	call submode#enter_with('WINDOW', 'n', '', '<C-w><down>', '<C-w>j')
	call submode#enter_with('WINDOW', 'n', '', '<C-w><up>', '<C-w>k')
	call submode#enter_with('WINDOW', 'n', '', '<C-w><right>', '<C-w>l')
	call submode#leave_with('WINDOW', 'n', '', '<Esc>')
	call submode#map('WINDOW', 'n', '', '+', '<C-w>+')
	call submode#map('WINDOW', 'n', '', '-', '<C-w>-')
	call submode#map('WINDOW', 'n', '', '<lt>', '<C-w><lt>')
	call submode#map('WINDOW', 'n', '', '>', '<C-w>>')
	call submode#map('WINDOW', 'n', '', 'h', '<C-w>h')
	call submode#map('WINDOW', 'n', '', 'j', '<C-w>j')
	call submode#map('WINDOW', 'n', '', 'k', '<C-w>k')
	call submode#map('WINDOW', 'n', '', 'l', '<C-w>l')
	call submode#map('WINDOW', 'n', '', '<left>', '<C-w>h')
	call submode#map('WINDOW', 'n', '', '<down>', '<C-w>j')
	call submode#map('WINDOW', 'n', '', '<up>', '<C-w>k')
	call submode#map('WINDOW', 'n', '', '<right>', '<C-w>l')
	call submode#map('WINDOW', 'n', 'x', '<bar>', '<C-w><bar>')
	call submode#map('WINDOW', 'n', 'x', '_', '<C-w>_')
	call submode#map('WINDOW', 'n', 'x', 'z', '<C-w>_<C-w><bar>')
	let g:submode_timeoutlen=10000
endif
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
" Language client and ncm2
set completeopt=menuone,noselect
inoremap <expr> <C-N> pumvisible() ? "\<C-N>" : "\<C-N>\<C-N>"
imap <expr> <C-space> pumvisible() ? "\<c-n>" : "\<c-x>\<c-o>"
if !empty(globpath(&rtp, 'autoload/LanguageClient.vim'))
	let g:LanguageClient_serverCommands = {
		\ 'c': ['clangd'],
		\ 'cpp': ['clangd'],
		\ 'python': ['pyls'],
	\ }
	nnoremap <expr> gd LanguageClient_isServerRunning() ? ':call LanguageClient_textDocument_definition()<CR>' : 'gd'
	nnoremap <A-u>f :call LanguageClient_textDocument_references()<CR>
	nnoremap <F2> :call LanguageClient_textDocument_rename()<CR>
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
" FZF
if !empty(globpath(&rtp, 'autoload/fzf/vim.vim'))
	nmap <silent> <A-/><A-/> :call ColoredBLines({'options': '+s -e'})<CR>
	nmap <silent> <A-/><A-q> :call ColoredBLines({'options': '+s -e -m', 'after': {-> setqflist([{'bufnr': bufnr(), 'lnum': getcurpos()[1]}], 'a')}})<CR>
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
" Text objects
if !empty(globpath(&rtp, 'autoload/textobj/comment.vim'))
	let g:textobj_comment_no_default_key_mappings = 1
	xmap a<C-_> <Plug>(textobj-comment-a)
	omap a<C-_> <Plug>(textobj-comment-a)
endif
if !empty(globpath(&rtp, 'autoload/textobj/pastedtext.vim'))
	let g:pastedtext_select_key = 'iP'
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
