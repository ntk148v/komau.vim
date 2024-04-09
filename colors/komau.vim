" Name:       komau.vim
" Version:    0.1.0
" Maintainer: github.com/ntk148v
" License:    Apache 2
"
" A minimal colorscheme for Vim/Neovim.
"
"""
hi clear

if exists('syntax on')
    syntax reset
endif

let g:colors_name='komau'

let s:black           = {"gui": "#222222", "cterm": "235"}
let s:medium_gray     = {"gui": "#767676", "cterm": "243"}
let s:white           = {"gui": "#F5EEE6", "cterm": "255"}
let s:light_black     = {"gui": "#424242", "cterm": "238"}
let s:lighter_black   = {"gui": "#545454", "cterm": "240"}
let s:subtle_black    = {"gui": "#303030", "cterm": "236"}
let s:light_gray      = {"gui": "#999999", "cterm": "246"}
let s:lighter_gray    = {"gui": "#CCCCCC", "cterm": "252"}
let s:lightest_gray   = {"gui": "#E5E5E5", "cterm": "254"}
let s:yellow          = {"gui": "#FED442", "cterm": "221"}
let s:pink            = {"gui": "#D73A49", "cterm": "167"}
let s:green           = {"gui": "#22863A", "cterm": "29" }
let s:red             = {"gui": "#B31D28", "cterm": "124"}
let s:orange          = {"gui": "#E36209", "cterm": "166"}
let s:blue            = {"gui": "#005CC5", "cterm": "26" }

let s:background = &background

if &background == "dark"
  let s:fg              = s:white
  let s:bg              = s:black
  let s:bg_subtle       = s:lighter_black
  let s:bg_very_subtle  = s:subtle_black
  let s:norm            = s:lighter_gray
  let s:norm_subtle     = s:medium_gray
  let s:cursorlinenr    = s:white
else
  let s:fg              = s:black
  let s:bg              = s:white
  let s:bg_subtle       = s:light_gray
  let s:bg_very_subtle  = s:lightest_gray
  let s:norm            = s:light_black
  let s:norm_subtle     = s:medium_gray
  let s:cursorlinenr    = s:black
endif

if has("gui_running")
    let s:terminal_italic=1 " TODO: could refactor to not require this at all
else
    let s:terminal_italic=0 " terminals will be guilty until proven compatible
endif

let g:komau_bold = get(g:, 'komau_bold', 1)
let g:komau_italic = get(g:, 'komau_italic', 1)
let s:bold = "bold"
let s:italic = "italic"

if (g:komau_bold == 0 || &t_Co == 8 )
  let s:bold = "NONE"
endif

if (g:komau_italic == 0)
  let s:italic = "NONE"
endif

" https://github.com/noahfrederick/vim-hemisu/
function! s:h(group, style)
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
    \ "ctermfg=" (has_key(a:style, "fg")    ? a:style.fg.cterm : "NONE")
    \ "ctermbg=" (has_key(a:style, "bg")    ? a:style.bg.cterm : "NONE")
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

call s:h("Normal",        {"bg": s:bg, "fg": s:norm})

" restore &background's value in case changing Normal changed &background (:help :hi-normal-cterm)
if &background != s:background
   execute "set background=" . s:background
endif

call s:h("Cursor",        {"bg": s:light_black, "fg": s:norm })
call s:h("Comment",       {"fg": s:bg_subtle, "gui": s:italic})

call s:h("Constant",      {"fg": s:norm_subtle})
hi! link Character        Constant
hi! link Number           Constant
hi! link Boolean          Constant
hi! link Float            Constant
hi! link String           Constant

call s:h("Identifier",     {"fg": s:fg, "cterm": s:italic, "gui": s:italic})
hi! link Function         Identifier

call s:h("Statement",     {"fg": s:fg, "cterm": s:bold, "gui": s:bold})
hi! link Conditonal       Statement
hi! link Repeat           Statement
hi! link Label            Statement
hi! link Keyword          Statement
hi! link Exception        Statement

call s:h("Operator",      {"fg": s:norm, "cterm": s:bold, "gui": s:bold})

call s:h("PreProc",       {"fg": s:norm_subtle})
hi! link Include          PreProc
hi! link Define           PreProc
hi! link Macro            PreProc
hi! link PreCondit        PreProc

call s:h("Type",          {"fg": s:norm})
hi! link StorageClass     Type
hi! link Structure        Type
hi! link Typedef          Type

call s:h("Special",       {"fg": s:norm_subtle, "gui": s:italic})
hi! link SpecialChar      Special
hi! link Tag              Special
hi! link Delimiter        Special
hi! link SpecialComment   Special
hi! link Debug            Special

call s:h("Underlined",    {"fg": s:norm, "gui": "underline", "cterm": "underline"})
call s:h("Ignore",        {"fg": s:bg})
call s:h("Error",         {"fg": s:white, "bg": s:red, "cterm": s:bold})
call s:h("Todo",          {"fg": s:pink, "gui": "underline", "cterm": "underline"})
call s:h("SpecialKey",    {"fg": s:green})
call s:h("NonText",       {"fg": s:medium_gray})
call s:h("Directory",     {"fg": s:norm, "gui": s:bold, "cterm": s:bold})
call s:h("ErrorMsg",      {"fg": s:red})
call s:h("IncSearch",     {"bg": s:norm_subtle, "fg": s:bg})
call s:h("Search",        {"bg": s:norm, "fg": s:bg, "cterm": s:bold, "gui": s:bold})
call s:h("MoreMsg",       {"fg": s:medium_gray, "cterm": s:bold, "gui": s:bold})
hi! link ModeMsg MoreMsg
call s:h("LineNr",        {"fg": s:bg_subtle})
call s:h("CursorLineNr",  {"fg": s:cursorlinenr, "bg": s:bg_very_subtle, "cterm": s:bold, "gui": s:bold})
call s:h("Question",      {"fg": s:red})
call s:h("StatusLine",    {"bg": s:bg_very_subtle})
call s:h("StatusLineNC",  {"bg": s:bg_very_subtle, "fg": s:medium_gray})
call s:h("VertSplit",     {"bg": s:bg_very_subtle, "fg": s:bg_very_subtle})
call s:h("Title",         {"fg": s:light_gray})
call s:h("Visual",        {"fg": s:norm, "bg": s:bg_very_subtle})
call s:h("VisualNOS",     {"bg": s:bg_subtle})
call s:h("WarningMsg",    {"fg": s:yellow})
call s:h("WildMenu",      {"fg": s:bg, "bg": s:norm})
call s:h("Folded",        {"fg": s:medium_gray})
call s:h("FoldColumn",    {"fg": s:bg_subtle})
call s:h("DiffAdd",       {"fg": s:green})
call s:h("DiffDelete",    {"fg": s:red})
call s:h("DiffChange",    {"fg": s:yellow})
call s:h("DiffText",      {"fg": s:blue})
call s:h("SignColumn",    {"fg": s:green})


if has("gui_running")
  call s:h("SpellBad",    {"gui": "underline", "sp": s:red})
  call s:h("SpellCap",    {"gui": "underline", "sp": s:green})
  call s:h("SpellRare",   {"gui": "underline", "sp": s:orange})
  call s:h("SpellLocal",  {"gui": "underline", "sp": s:green})
else
  call s:h("SpellBad",    {"cterm": "underline", "fg": s:red})
  call s:h("SpellCap",    {"cterm": "underline", "fg": s:green})
  call s:h("SpellRare",   {"cterm": "underline", "fg": s:orange})
  call s:h("SpellLocal",  {"cterm": "underline", "fg": s:green})
endif

call s:h("Pmenu",         {"fg": s:norm, "bg": s:bg_very_subtle})
call s:h("PmenuSel",      {"fg": s:subtle_black, "bg": s:pink})
call s:h("PmenuSbar",     {"fg": s:norm, "bg": s:bg_subtle})
call s:h("PmenuThumb",    {"fg": s:norm, "bg": s:bg_subtle})
call s:h("TabLine",       {"fg": s:norm, "bg": s:bg_very_subtle})
call s:h("TabLineSel",    {"fg": s:subtle_black, "bg": s:pink, "gui": s:bold, "cterm": s:bold})
call s:h("TabLineFill",   {"fg": s:norm, "bg": s:bg_very_subtle})
call s:h("CursorColumn",  {"bg": s:bg_very_subtle})
call s:h("CursorLine",    {"bg": s:bg_very_subtle})
call s:h("ColorColumn",   {"bg": s:bg_subtle})

call s:h("MatchParen",    {"bg": s:bg_subtle, "fg": s:norm})
call s:h("qfLineNr",      {"fg": s:medium_gray})

call s:h("htmlH1",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH2",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH3",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH4",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH5",        {"bg": s:bg, "fg": s:norm})
call s:h("htmlH6",        {"bg": s:bg, "fg": s:norm})

" Syntastic
call s:h("SyntasticWarningSign",    {"fg": s:yellow})
call s:h("SyntasticWarning",        {"bg": s:yellow, "fg": s:black, "gui": s:bold, "cterm": s:bold})
call s:h("SyntasticErrorSign",      {"fg": s:red})
call s:h("SyntasticError",          {"bg": s:red, "fg": s:white, "gui": s:bold, "cterm": s:bold})

" which-key.nvim
call s:h("WhichKey",                {"bg": s:bg, "fg": s:pink, "gui": s:bold, "cterm": s:bold})
call s:h("WhichKeyDesc",            {"bg": s:bg, "fg": s:norm_subtle, "gui": s:bold, "cterm": s:bold})
call s:h("WhichKeySeparator",       {"bg": s:bg, "fg": s:norm, "gui": s:bold, "cterm": s:bold})
call s:h("WhichKeyFloat",           {"bg": s:bg})

hi link WhichKeyGroup WhichKey

" Neomake
hi link NeomakeWarningSign	SyntasticWarningSign
hi link NeomakeErrorSign	SyntasticErrorSign

" ALE
hi link ALEWarningSign	SyntasticWarningSign
hi link ALEErrorSign	SyntasticErrorSign

" Signify, git-gutter
hi link SignifySignAdd              LineNr
hi link SignifySignDelete           LineNr
hi link SignifySignChange           LineNr
hi link GitGutterAdd                LineNr
hi link GitGutterDelete             LineNr
hi link GitGutterChange             LineNr
hi link GitGutterChangeDelete       LineNr


" Markdown
call s:h("markdownCode", { "fg": s:bg_subtle })
call s:h("markdownLinkReference", { "fg": s:bg_subtle })
call s:h("markdownJekyllFrontMatter", { "fg": s:bg_subtle })
call s:h("markdownCodeBlock", { "fg": s:norm })
call s:h("markdownCodeDelimiter", { "fg": s:norm })
call s:h("markdownHeadingDelimiter", { "fg": s:fg })
call s:h("markdownRule", { "fg": s:bg_subtle })
call s:h("markdownHeadingRule", { "fg": s:bg_subtle })
call s:h("htmlH1", { "fg": s:fg, "gui": s:bold, "cterm": s:bold })
call s:h("htmlH2", { "fg": s:fg, "gui": s:bold, "cterm": s:bold })
call s:h("htmlH3", { "fg": s:fg, "gui": s:bold, "cterm": s:bold })
call s:h("htmlH4", { "fg": s:fg, "gui": s:bold, "cterm": s:bold })
call s:h("htmlH5", { "fg": s:fg, "gui": s:bold, "cterm": s:bold })
call s:h("htmlH6", { "fg": s:fg, "gui": s:bold, "cterm": s:bold })
call s:h("mkdDelimiter", { "fg": s:fg })
call s:h("markdownId", { "fg": s:light_gray })
call s:h("markdownBlockquote", { "fg": s:bg_subtle })
call s:h("markdownItalic", { "fg": s:light_gray, "gui": s:italic, "cterm": s:italic })
call s:h("mkdBold", { "fg": s:fg, "gui": s:bold, "cterm": s:bold })
call s:h("mkdInlineURL", { "fg": s:fg, "gui": s:italic, "cterm": s:italic })
call s:h("mkdListItem", { "fg": s:fg })
call s:h("markdownOrderedListMarker", { "fg": s:fg })
call s:h("mkdLink", { "fg": s:fg, "gui": s:bold, "cterm": s:bold })
call s:h("markdownLinkDelimiter", { "fg": s:fg })
call s:h("mkdURL", { "fg": s:norm_subtle, "gui": s:italic, "cterm": s:italic })
