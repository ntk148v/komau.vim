local fn = require("komau.fn")

local M = {}

local base = {
    black = { gui = "#222222", cterm = 235 },
    medium_gray = { gui = "#767676", cterm = 243 },
    white = { gui = "#F5EEE6", cterm = 255 },
    light_black = { gui = "#424242", cterm = 238 },
    lighter_black = { gui = "#545454", cterm = 240 },
    subtle_black = { gui = "#303030", cterm = 236 },
    light_gray = { gui = "#999999", cterm = 246 },
    lighter_gray = { gui = "#CCCCCC", cterm = 252 },
    lightest_gray = { gui = "#E5E5E5", cterm = 254 },
    yellow = { gui = "#FED442", cterm = 221 },
    pink = { gui = "#D73A49", cterm = 167 },
    green = { gui = "#22863A", cterm = 29 },
    red = { gui = "#B31D28", cterm = 124 },
    orange = { gui = "#E36209", cterm = 166 },
    blue = { gui = "#005CC5", cterm = 26 },
    purple = { gui = "#6F42C1", cterm = 96 },
}

local function hex_to_rgb(hex)
    local value = hex:gsub("#", "")
    return tonumber(value:sub(1, 2), 16), tonumber(value:sub(3, 4), 16), tonumber(value:sub(5, 6), 16)
end

local function rgb_to_hex(r, g, b)
    return string.format("#%02x%02x%02x", r, g, b)
end

local function blend_channel(a, b, alpha)
    return math.floor((alpha * a) + ((1 - alpha) * b) + 0.5)
end

local function normalize_hex(color)
    if type(color) == "table" then
        return color.gui
    end
    return color
end

function M.blend(foreground, background, alpha)
    local fg = normalize_hex(foreground)
    local bg = normalize_hex(background)
    local fr, fg_c, fb = hex_to_rgb(fg)
    local br, bg_c, bb = hex_to_rgb(bg)
    return rgb_to_hex(blend_channel(fr, br, alpha), blend_channel(fg_c, bg_c, alpha), blend_channel(fb, bb, alpha))
end

function M.darken(color, amount)
    return M.blend(color, "#000000", amount)
end

function M.lighten(color, amount)
    return M.blend(color, "#ffffff", amount)
end

local variants = {
    dark = function()
        return {
            fg = base.white,
            bg = base.black,
            bg_subtle = base.lighter_black,
            bg_very_subtle = base.subtle_black,
            norm = base.lighter_gray,
            norm_subtle = base.medium_gray,
            cursorline_nr = base.white,
            accent = base.pink,
            warn = base.yellow,
            info = base.blue,
            hint = base.green,
            error = base.red,
            selection = base.lighter_black,
            border = base.lighter_black,
            float_bg = base.subtle_black,
            comment = base.lighter_black,
            terminal = {
                base.black.gui,
                base.red.gui,
                base.green.gui,
                base.yellow.gui,
                base.blue.gui,
                base.pink.gui,
                base.blue.gui,
                base.white.gui,
                base.light_black.gui,
                base.red.gui,
                base.green.gui,
                base.yellow.gui,
                base.blue.gui,
                base.pink.gui,
                base.blue.gui,
                base.white.gui,
            },
        }
    end,
    light = function()
        return {
            fg = base.black,
            bg = base.white,
            bg_subtle = base.light_gray,
            bg_very_subtle = base.lightest_gray,
            norm = base.light_black,
            norm_subtle = base.medium_gray,
            cursorline_nr = base.black,
            accent = base.pink,
            warn = base.orange,
            info = base.blue,
            hint = base.green,
            error = base.red,
            selection = base.light_gray,
            border = base.light_gray,
            float_bg = base.lightest_gray,
            comment = base.medium_gray,
            terminal = {
                base.white.gui,
                base.red.gui,
                base.green.gui,
                base.yellow.gui,
                base.blue.gui,
                base.pink.gui,
                base.blue.gui,
                base.black.gui,
                base.lightest_gray.gui,
                base.red.gui,
                base.green.gui,
                base.yellow.gui,
                base.blue.gui,
                base.pink.gui,
                base.blue.gui,
                base.black.gui,
            },
        }
    end,
}

local function resolve_style(style)
    if style == "auto" then
        return (vim.o.background == "light" and "light") or "dark"
    end
    return variants[style] and style or "dark"
end

local function extend_with_base(colors)
    for name, value in pairs(base) do
        colors[name] = value
    end
    colors.none = { gui = "NONE", cterm = "NONE" }
    colors.palette = fn.deepcopy(base)
    return colors
end

function M.build(style, overrides)
    local chosen = resolve_style(style)
    local colors = variants[chosen]()
    colors._style = chosen
    extend_with_base(colors)

    if overrides and next(overrides) then
        colors = fn.deep_extend("force", colors, overrides)
    end

    return colors
end

return M
