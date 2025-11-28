hi clear
if exists('syntax_on')
  syntax reset
endif
let g:colors_name = 'komau'

if has('nvim') || has('lua')
  lua require('komau').load()
else
  echoerr 'komau requires Vim compiled with +lua'
endif
