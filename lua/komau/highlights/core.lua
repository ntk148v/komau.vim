local M = {}

local function transparency_bg(colors, transparent)
    if transparent then
        return colors.none
    end
    return colors.bg
end

function M.get(colors, config)
    local highlights = {}
    local normal_bg = transparency_bg(colors, config.transparent)

    highlights.Normal = { fg = colors.norm, bg = normal_bg }
    highlights.NormalNC = {
        fg = config.dim_inactive and colors.norm_subtle or colors.norm,
        bg = config.dim_inactive and colors.bg_very_subtle or normal_bg,
    }
    highlights.NormalFloat = { fg = colors.norm, bg = colors.float_bg }
    highlights.FloatBorder = { fg = colors.border, bg = colors.float_bg }
    highlights.FloatTitle = { fg = colors.accent, bg = colors.float_bg, bold = true }
    highlights.EndOfBuffer = { fg = config.transparent and colors.bg_very_subtle or colors.bg }
    highlights.SignColumn = { fg = colors.hint, bg = normal_bg }
    highlights.CursorLine = { bg = colors.bg_very_subtle }
    highlights.CursorColumn = { bg = colors.bg_very_subtle }
    highlights.Cursor = { fg = colors.norm, bg = colors.light_black }
    highlights.CursorLineNr = { fg = colors.cursorline_nr, bg = colors.bg_very_subtle, bold = true }
    highlights.LineNr = { fg = colors.bg_subtle }
    highlights.MatchParen = { fg = colors.accent, bg = colors.bg_very_subtle, bold = true }
    highlights.ColorColumn = { bg = colors.bg_subtle }
    highlights.Conceal = { fg = colors.bg_subtle }
    highlights.Visual = { fg = colors.norm, bg = colors.selection }
    highlights.VisualNOS = { bg = colors.bg_subtle }
    highlights.Search = { fg = colors.bg, bg = colors.norm, bold = true }
    highlights.IncSearch = { fg = colors.bg, bg = colors.norm_subtle }
    highlights.VertSplit = { fg = colors.border, bg = colors.border }
    highlights.WinSeparator = { fg = colors.border, bg = colors.border }
    highlights.StatusLine = { fg = colors.norm, bg = colors.bg_very_subtle }
    highlights.StatusLineNC = { fg = colors.norm_subtle, bg = colors.bg_very_subtle }
    highlights.TabLine = { fg = colors.norm, bg = colors.bg_very_subtle }
    highlights.TabLineSel = { fg = colors.bg, bg = colors.accent, bold = true }
    highlights.TabLineFill = { fg = colors.norm, bg = colors.bg_very_subtle }
    highlights.Title = { fg = colors.light_gray }
    highlights.Pmenu = { fg = colors.norm, bg = colors.float_bg }
    highlights.PmenuSel = { fg = colors.bg, bg = colors.accent }
    highlights.PmenuSbar = { bg = colors.bg_subtle }
    highlights.PmenuThumb = { bg = colors.norm }
    highlights.QuickFixLine = { bg = colors.bg_very_subtle }
    highlights.qfLineNr = { fg = colors.medium_gray }
    highlights.DiffAdd = { fg = colors.hint }
    highlights.DiffDelete = { fg = colors.error }
    highlights.DiffChange = { fg = colors.warn }
    highlights.DiffText = { fg = colors.info }
    highlights.Folded = { fg = colors.bg_subtle, bg = colors.bg }
    highlights.FoldColumn = { fg = colors.bg_subtle, bg = normal_bg }
    highlights.Terminal = { fg = colors.norm, bg = normal_bg }
    highlights.ErrorMsg = { fg = colors.error }
    highlights.WarningMsg = { fg = colors.warn }
    highlights.MoreMsg = { fg = colors.medium_gray, bold = true }
    highlights.ModeMsg = { fg = colors.medium_gray }
    highlights.Question = { fg = colors.error }
    highlights.SpellBad = { sp = colors.error, undercurl = true }
    highlights.SpellCap = { sp = colors.hint, undercurl = true }
    highlights.SpellLocal = { sp = colors.hint, undercurl = true }
    highlights.SpellRare = { sp = colors.warn, undercurl = true }
    highlights.WildMenu = { fg = colors.bg, bg = colors.norm }

    return highlights
end

return M
