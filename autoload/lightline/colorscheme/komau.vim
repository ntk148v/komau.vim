let s:white        = [ '#F5EEE6' , 255 ]
let s:medium_gray         = [ '#767676' , 243 ]
let s:lightest_gray   = [ '#E5E5E5' , 254 ]
let s:yellow       = [ '#FED442' , 221 ]
let s:red          = [ '#B31D28' , 124 ]
let s:orange       = [ '#E36209' , 166 ]

let s:p = {
    \ 'normal': {},
    \ 'inactive': {},
    \ 'insert': {},
    \ 'replace': {},
    \ 'visual': {},
    \ 'tabline': {}
    \ }

let s:p.normal.left     = [[ s:medium_gray, s:white ], [ s:white, s:medium_gray ]]
let s:p.normal.right    = [[ s:white, s:medium_gray ], [ s:white, s:medium_gray ]]
let s:p.insert.left     = [[ s:medium_gray, s:white ], [ s:white, s:medium_gray ]]
let s:p.visual.left     = [[ s:medium_gray, s:white ], [ s:white, s:medium_gray ]]
let s:p.replace.left    = [[ s:medium_gray, s:white ], [ s:white, s:medium_gray ]]

let s:p.inactive.right  = [[ s:lightest_gray, s:medium_gray ], [ s:medium_gray, s:medium_gray ]]
let s:p.inactive.left   = [[ s:lightest_gray, s:medium_gray ], [ s:medium_gray, s:medium_gray ]]
let s:p.inactive.middle = [[ s:lightest_gray, s:medium_gray ]]

let s:p.normal.middle   = [[ s:lightest_gray,  s:medium_gray  ]]
let s:p.normal.error    = [[ s:red,    s:medium_gray  ]]
let s:p.normal.warning  = [[ s:orange, s:medium_gray  ]]

let s:p.tabline.left    = [[ s:lightest_gray, s:medium_gray ]]
let s:p.tabline.tabsel  = [[ s:medium_gray, s:yellow    ]]
let s:p.tabline.middle  = [[ s:yellow, s:medium_gray    ]]


let g:lightline#colorscheme#komau#palette = lightline#colorscheme#flatten(s:p)