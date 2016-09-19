" vim: ft=vim fdm=marker fdl=0
" Vim color file -- askapachecode
" Maintainer: AskApache <askapache@gmail.com>
" Last Change: Thu Oct 3 06:30:42 2013
" %s/[\t] {1, }/ /g | %s/[\t]*//g



set background=dark
hi clear

if exists("syntax_on")
 syntax reset
endif

let g:colors_name="askapachecode"

hi CursorLine ctermbg=236
hi CursorColumn ctermbg=236
hi MatchParen ctermfg=157 ctermbg=237 cterm=bold
hi Pmenu ctermfg=255 ctermbg=238
hi PmenuSel ctermfg=0 ctermbg=148

" General colors
hi Cursor ctermbg=241
hi Normal ctermfg=253 ctermbg=232
hi NonText ctermfg=244 ctermbg=235
hi LineNr ctermfg=244 ctermbg=232
hi StatusLine ctermfg=253 ctermbg=238 cterm=italic
hi StatusLineNC ctermfg=246 ctermbg=238
hi VertSplit ctermfg=238 ctermbg=238
hi Folded ctermbg=4 ctermfg=248
hi Title ctermfg=254 cterm=bold
hi Visual ctermfg=254 ctermbg=4
hi SpecialKey ctermfg=244 ctermbg=236

hi pythonOperator ctermfg=103

hi Search cterm=NONE	
