let s:p = {"normal": {}, "inactive": {}, "insert": {}, "replace": {}, "visual": {}, "tabline": {} }

let s:p.normal.left = [[["#f0f0f0", 153], ["#222222", 66]], [["#f0f0f0", 235], ["#222222", 81]]]
let s:p.normal.middle = [[["#f0f0f0", 66], ["#222222", 153]]]
let s:p.normal.right = [[["#f0f0f0", 153], ["#222222", 66]], [["#f0f0f0", 235], ["#222222", 81]]]
let s:p.normal.error = [[["#f0f0f0", 235], ["#d73a49", 203]]]
let s:p.normal.warning = [[["#f0f0f0", 235], ["#fed442", 215]]]

let s:p.inactive.left = [[["#767676", 250], ["#222222", 238]], [["#767676", 250], ["#222222", 238]]]
let s:p.inactive.middle = [[["#767676", 250], ["#222222", 242]]]
let s:p.inactive.right = [[["#767676", 250], ["#222222", 238]], [["#767676", 250], ["#222222", 238]]]

let s:p.insert.left = [[["#22863a", 185], ["#222222", 242]], [["#f0f0f0", 235], ["#222222", 142]]]
let s:p.insert.middle = [[["#f0f0f0", 242], ["#222222", 185]]]
let s:p.insert.right = [[["#f0f0f0", 185], ["#222222", 242]], [["#f0f0f0", 235], ["#222222", 142]]]

let s:p.replace.left = [[["#d73a49", 203], ["#222222", 237]], [["#f0f0f0", 235], ["#222222", 160]]]
let s:p.replace.middle = [[["#f0f0f0", 235], ["#222222", 203]]]
let s:p.replace.right = [[["#f0f0f0", 203], ["#222222", 237]], [["#f0f0f0", 235], ["#222222", 160]]]

let s:p.visual.left = [[["#005cc5", 180], ["#222222", 58]], [["#f0f0f0", 235], ["#222222", 215]]]
let s:p.visual.middle = [[["#f0f0f0", 235], ["#222222", 180]]]
let s:p.visual.right = [[["#f0f0f0", 180], ["#222222", 58]], [["#f0f0f0", 235], ["#222222", 215]]]

let s:p.tabline.left = [[["#f0f0f0", 250], ["#222222", 242]]]
let s:p.tabline.tabsel = [[["#cccccc", 235], ["#767676", 250]]]
let s:p.tabline.middle = [[["#f0f0f0", 242], ["#222222", 238]]]
let s:p.tabline.right = [[["#f0f0f0", 250], ["#222222", 242]]]

let g:lightline#colorscheme#atlas#palette = lightline#colorscheme#flatten(s:p)