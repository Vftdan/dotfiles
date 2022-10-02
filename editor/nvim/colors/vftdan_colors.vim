set background=dark
if version > 580
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name = "vftdan_colors"

hi Normal       guibg=#002b36 guifg=#dedede
hi Comment      ctermfg=4 guifg=#21bdde
hi Identifier   cterm=bold ctermfg=14 guifg=#72dfcf
hi Type         ctermfg=77 gui=bold guifg=#42de21
hi Constant     ctermfg=13 guifg=#ff42bd
hi String       ctermfg=211 guifg=#fa80aa
hi Special      ctermfg=215 guifg=#ffa021
hi Statement    ctermfg=11 gui=bold guifg=#ffff42
hi PreProc      ctermfg=163 guifg=#de21bd
hi Constant     ctermfg=13 guifg=#ff42bd
hi Underlined   cterm=underline ctermfg=81 gui=underline guifg=#80a0ff
hi SpecialKey   ctermfg=117 guifg=#87dae8
hi NonText      ctermfg=12 guifg=#42bdff

hi CursorLine   cterm=NONE ctermbg=239 guibg=#364b51
hi CursorColumn ctermbg=240 guibg=#1b3b43
hi ColorColumn  ctermbg=DarkGrey guibg=#a58888
hi Visual       ctermbg=242 guibg=#6c6c6c
if !($TERM =~ '-256color|-24bit')
    hi Visual   ctermbg=0 ctermfg=242 cterm=reverse
endif

hi MatchParen   cterm=bold gui=bold ctermbg=6 guibg=#217ca0
hi TabLine      cterm=underline ctermfg=15 ctermbg=237 gui=underline guibg=#383838
hi TabLineSel   cterm=bold gui=bold
hi TabLineFill  cterm=reverse gui=reverse
hi Conceal      ctermfg=158 ctermbg=66 guifg=#a0e8df guibg=#558695
hi Folded       ctermfg=14 ctermbg=246 guifg=#63efdf guibg=#909090
hi FoldColumn   ctermfg=14 ctermbg=244 guifg=#63efdf guibg=#7e7e7e
hi SignColumn   ctermfg=14 ctermbg=241 guifg=#63efdf guibg=#616969
hi LineNr       ctermfg=11 guifg=#ffd031 guibg=#214c57
hi CursorLineNr ctermfg=11 gui=bold guifg=#ffff42 guibg=#183c47
hi StatusLine   cterm=bold,reverse ctermbg=0 ctermfg=10 gui=bold,reverse guibg=#002b36 guifg=#42bd00
hi StatusLineNC cterm=reverse gui=reverse guibg=#424242
hi VertSplit    cterm=bold,reverse ctermbg=238 gui=bold,reverse guibg=#424242
hi Todo         cterm=bold ctermfg=0 ctermbg=11 gui=bold guifg=#000042 guibg=#ffff42
hi IncSearch    cterm=reverse gui=reverse guibg=#00152b
hi Search       ctermfg=0 ctermbg=11 guifg=#000021 guibg=#efff7b
hi Error        ctermfg=15 ctermbg=1 guifg=#bdffff guibg=#ce003b
hi DiffAdd      ctermbg=4 guibg=#214e9a
hi DiffChange   ctermbg=5 guibg=#76598a
hi DiffDelete   ctermfg=12 ctermbg=1 gui=bold guifg=#90cdee guibg=#9a7539
hi DiffText     cterm=bold ctermbg=9 gui=bold guibg=#cc5b1c
hi Title        ctermfg=217 gui=bold guifg=#efbda0

hi Pmenu        ctermfg=188 ctermbg=5 guifg=#dedede guibg=#3b3c66
hi PmenuSel     ctermfg=195 ctermbg=2 guifg=#bdffff guibg=#42bd00
hi PmenuSbar    ctermbg=237 guibg=#383838
hi PmenuThumb   ctermbg=15 guibg=#bdbdbd

hi MsgArea      ctermbg=237 guibg=#383838
hi ErrorMsg     cterm=bold gui=bold ctermfg=15 ctermbg=1 guifg=#bdffff guibg=#ce003b
hi WarningMsg   cterm=bold gui=bold ctermfg=208 guifg=#ef8842
hi MoreMsg      ctermfg=77 gui=bold guifg=#64ef68
hi Question     ctermfg=83 gui=bold guifg=#53ff55
hi ModeMsg      cterm=bold gui=bold ctermfg=15 guifg=#deffff

hi Noise        ctermfg=109 guifg=#859794
hi Strike       cterm=underline gui=underline ctermfg=249 guifg=#b1bab9

hi link htmlStrike Strike

let g:terminal_color_0  = '#000042'
let g:terminal_color_1  = '#bd0000'
let g:terminal_color_2  = '#42bd00'
let g:terminal_color_3  = '#bdbd42'
let g:terminal_color_4  = '#4272ff'
let g:terminal_color_5  = '#bd00bd'
let g:terminal_color_6  = '#00bdbd'
let g:terminal_color_7  = '#bdbdbd'
let g:terminal_color_8  = '#424242'
let g:terminal_color_9  = '#ff4200'
let g:terminal_color_10 = '#42ff42'
let g:terminal_color_11 = '#ffff42'
let g:terminal_color_12 = '#42bdff'
let g:terminal_color_13 = '#ff42bd'
let g:terminal_color_14 = '#72dfcf'
let g:terminal_color_15 = '#bdffff'
