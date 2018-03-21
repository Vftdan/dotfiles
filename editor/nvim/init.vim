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
nnoremap <C-W>% :vsp<cr>
nnoremap <C-W>" :sp<cr>
nnoremap <C-W>z :res<cr>:vertical res<cr>
nnoremap <C-W><Esc> <Esc>
nnoremap <C-L>n :set listchars=tab:┊\ <cr>
nnoremap <C-L>s :set listchars=tab:\\\|-,eol:$,nbsp:%,space:_,trail:#<cr>
nnoremap <C-L>h :set listchars=<cr>
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
