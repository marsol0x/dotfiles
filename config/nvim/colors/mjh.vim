set background=dark
highlight clear
if exists("syntax_on")
    syntax reset
endif
let g:colors_name = "MJH"
" Interface
highlight   Normal         guifg=#a08563   guibg=#161616   gui=NONE
highlight   Visual         guifg=NONE      guibg=#3d3a3a   gui=NONE
highlight   StatusLine     guifg=#161616   guibg=#a08563   gui=NONE
highlight   StatusLineNC   guifg=#161616   guibg=#826b4f   gui=NONE

highlight   Cursor         guifg=#000000   guibg=#40ff40   gui=NONE
highlight   CursorColumn   guifg=NONE      guibg=#3d3a3a   gui=NONE
highlight   CursorLine     guifg=NONE      guibg=#3d3d3d   gui=NONE
highlight   CursorLineNr   guifg=NONE      guibg=NONE      gui=NONE
highlight   Directory      guifg=NONE      guibg=NONE      gui=NONE
highlight   Folded         guifg=#161616   guibg=#a08563   gui=NONE
highlight   LineNr         guifg=NONE      guibg=NONE      gui=NONE
highlight   MatchParen     guifg=#000000   guibg=#ffffff   gui=NONE
highlight   NonText        guifg=#ffffff   guibg=NONE      gui=NONE
highlight   Pmenu          guifg=NONE      guibg=#303030   gui=NONE
highlight   PmenuSel       guifg=NONE      guibg=#202020   gui=NONE
highlight   VertSplit      guifg=#a08563   guibg=#a08563   gui=NONE
"highlight   VertSplit      guifg=#161616   guibg=#161616   gui=NONE

" Syntax
highlight   Comment        guifg=#7f7f7f   guibg=NONE      gui=NONE
highlight   Constant       guifg=NONE      guibg=NONE      gui=NONE
highlight   Identifier     guifg=NONE      guibg=NONE      gui=NONE
highlight   Statement      guifg=NONE      guibg=NONE      gui=NONE
highlight   PreProc        guifg=NONE      guibg=NONE      gui=NONE
highlight   Type           guifg=NONE      guibg=NONE      gui=NONE
highlight   Special        guifg=NONE      guibg=NONE      gui=NONE
highlight   Underlined     guifg=NONE      guibg=NONE      gui=underline
highlight   Ignore         guifg=NONE      guibg=NONE      gui=NONE
highlight   Error          guifg=#ff0000   guibg=NONE      gui=NONE
highlight   Todo           guifg=#ff0000   guibg=NONE      gui=NONE
