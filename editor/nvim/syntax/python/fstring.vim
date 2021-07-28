syn region pythonFString matchgroup=pythonQuotes start=/\vf\z(['"])/ end=/\z1/  skip="\\\\\|\\\z1" contains=pythonEscape,@Spell,@pythonFStringContent
syn match pythonFStringUnmatchedBrace "\V}" contained
syn match pythonFStringEscapeBrace "\V{{\|}}" contained
syn region pythonFStringCode matchgroup=pythonFStringBrace start=/\v\{\ze[^\{]/ end="\V}" contained contains=TOP
syn cluster pythonFStringContent contains=pythonFStringUnmatchedBrace,pythonFStringEscapeBrace,pythonFStringCode
syn region pythonSet start="{" end="}"

hi def link pythonFString	pythonString
hi def link pythonFStringEscapeBrace	pythonEscape
hi def link pythonFStringUnmatchedBrace Error
