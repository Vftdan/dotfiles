" Vim syntax file
if !exists("main_syntax")
	if version < 600
		syntax clear
	elseif exists("b:current_syntax")
		finish
	endif
	let main_syntax = 'pseudocode'
endif

if version < 508
	command! -nargs=+ PseudocodeHiLink highlight link <args>
else
	command! -nargs=+ PseudocodeHiLink highlight default link <args>
endif

syn cluster pseudocodeCommentContent contains=NONE
syn region pseudocodeLineComment start='//' skip=/\\\n/ end=/\ze$/ contains=pseudocodeCommentContent
syn region pseudocodeBlockComment start='\V/*' end='\V*/' contains=pseudocodeCommentContent
PseudocodeHiLink pseudocodeLineComment pseudocodeComment
PseudocodeHiLink pseudocodeBlockComment pseudocodeComment

syn match pseudocodePunctuation "\V\[.,!?]"
syn region pseudocodeParenthesized matchgroup=pseudocodeBrackets start='(' end=')' transparent contains=TOP
syn region pseudocodeBracketed matchgroup=pseudocodeBrackets start='\V[' end='\V]' transparent contains=TOP
syn region pseudocodeBraced matchgroup=pseudocodeBrackets start='\V{' end='\V}' transparent contains=TOP

syn match pseudocodeFunctionName /\v<%([A-Za-z_]|[^\u0000-\u007F])%([A-Za-z0-9_]|[^\u0000-\u007F])*\ze\(/ nextgroup=pseudocodeFunctionArguments
syn region pseudocodeFunctionArguments matchgroup=pseudocodeFunctionBrackets start='\V(' end='\V)' contained transparent contains=TOP

syn cluster pseudocodeLogicOp contains=pseudocodeImplies,pseudocodeIff,pseudocodeAnd,pseudocodeOr,pseudocodeNot 
syn match pseudocodeImplies "\V=>"
syn match pseudocodeIff "\V<=>"
syn match pseudocodeAnd "\V&\|∧"
syn match pseudocodeOr "\V||\|∨"
syn match pseudocodeNot /\v\!\ze\S*[A-Za-z0-9_\(\"\']|¬/
for s:name in ['pseudocodeImplies', 'pseudocodeIff', 'pseudocodeAnd', 'pseudocodeOr', 'pseudocodeNot']
	exe 'PseudocodeHiLink ' . s:name . ' pseudocodeLogicOp'
endfor

syn match pseudocodeCmpOp "\V<\|==\|>\|≤\|≥"

syn cluster pseudocodeStringContent contains=@pseudocodeStringEscape 
syn region pseudocodeString matchgroup=pseudocodeQuotation start="'" end="'" contains=@pseudocodeStringContent
syn region pseudocodeString matchgroup=pseudocodeQuotation start='"' end='"' contains=@pseudocodeStringContent

let s:pseudocodeStringEscape_elements = ['pseudocodeStringInvalidEscape']
syn match pseudocodeStringInvalidEscape /\v\\[A-Za-z0-9_]/ contained
for [s:name, s:ptn] in [
		\ ['pseudocodeStringSpecialEscape', '/\v\\[^A-Za-z0-9_]/'],
		\ ['pseudocodeString8bitOctEscape', '/\v\\o[0-3][0-7]{2}/'],
		\ ['pseudocodeString16bitOctEscape', '/\v\\O[01][0-7]{5}/'],
		\ ['pseudocodeString8bitHexEscape', '/\v\\x[0-9A-Fa-f]{2}/'],
		\ ['pseudocodeString16bitHexEscape', '/\v\\u[0-9A-Fa-f]{4}/'],
		\ ['pseudocodeString32bitHexEscape', '/\v\\U[0-9A-Fa-f]{8}/'],
		\ ['pseudocodeStringNonprintEscape', '/\v\\[ernts]/'],
	\]
	exe 'syn match ' . s:name . ' ' . s:ptn . ' contained contains=pseudocodeStringEscapeBackslash'
	exe 'PseudocodeHiLink ' . s:name . ' pseudocodeStringEscape'
	call insert(s:pseudocodeStringEscape_elements, s:name)
endfor
exe 'syn cluster pseudocodeStringEscape contains=' . join(s:pseudocodeStringEscape_elements, ',')
syn match pseudocodeStringEscapeBackslash '\\' contained nextgroup=pseudocodeStringEscapeBackslashAfter
syn match pseudocodeStringEscapeBackslashAfter /\v./ contained transparent contains=NONE

syn cluster pseudocodeREQuantifier contains=pseudocodeREQuantifierStar,pseudocodeREQuantifierPlus,pseudocodeREQuantifierQuestion,pseudocodeREQuantifierExplicit
syn match pseudocodeREQuantifierStar /\V*?\?/ contained
syn match pseudocodeREQuantifierPlus /\V+?\?/ contained
syn match pseudocodeREQuantifierQuestion /\V??\?/ contained
syn match pseudocodeREQuantifierExplicit /\v\{\}/ contained

PseudocodeHiLink pseudocodeLogicOp Operator
PseudocodeHiLink pseudocodeCmpOp Operator
PseudocodeHiLink pseudocodeString String
PseudocodeHiLink pseudocodeQuotation Quote
PseudocodeHiLink pseudocodeStringInvalidEscape Error
PseudocodeHiLink pseudocodeStringEscape Special
PseudocodeHiLink pseudocodeStringEscapeBackslash Noise
PseudocodeHiLink pseudocodePunctuation Delimiter
PseudocodeHiLink pseudocodeBrackets Delimiter
PseudocodeHiLink pseudocodeFunctionName Identifier
PseudocodeHiLink pseudocodeFunctionBrackets PreProc
PseudocodeHiLink pseudocodeComment Comment

delcommand PseudocodeHiLink

setlocal matchpairs=(:),{:},[:]
setlocal commentstring=//%s

let b:current_syntax = "pseudocode"
if main_syntax ==# 'pseudocode'
	unlet main_syntax
endif
