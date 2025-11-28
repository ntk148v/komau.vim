local M = {}

local function link(name)
    return { link = name }
end

local function merge(target, source)
    for group, opts in pairs(source) do
        target[group] = opts
    end
end

local function telescope(colors)
    local t = {}
    t.TelescopeNormal = { fg = colors.norm, bg = colors.float_bg }
    t.TelescopeBorder = { fg = colors.border, bg = colors.float_bg }
    t.TelescopePromptNormal = { fg = colors.norm, bg = colors.bg_subtle }
    t.TelescopePromptBorder = { fg = colors.border, bg = colors.bg_subtle }
    t.TelescopePromptTitle = { fg = colors.bg, bg = colors.accent, bold = true }
    t.TelescopePreviewTitle = { fg = colors.bg, bg = colors.hint, bold = true }
    t.TelescopeResultsTitle = { fg = colors.bg, bg = colors.info, bold = true }
    t.TelescopeSelection = { fg = colors.accent, bg = colors.bg_very_subtle }
    return t
end

local function cmp(colors)
    local c = {}
    c.CmpItemAbbr = { fg = colors.norm }
    c.CmpItemAbbrMatch = { fg = colors.accent, bold = true }
    c.CmpItemAbbrMatchFuzzy = { fg = colors.accent }
    c.CmpItemMenu = { fg = colors.norm_subtle }
    c.CmpItemKindText = { fg = colors.norm }
    c.CmpItemKindMethod = { fg = colors.info }
    c.CmpItemKindFunction = { fg = colors.info }
    c.CmpItemKindConstructor = { fg = colors.info }
    c.CmpItemKindField = { fg = colors.norm_subtle }
    c.CmpItemKindVariable = { fg = colors.norm }
    c.CmpItemKindClass = { fg = colors.info }
    c.CmpItemKindInterface = { fg = colors.info }
    c.CmpItemKindModule = { fg = colors.info }
    c.CmpItemKindProperty = { fg = colors.norm_subtle }
    c.CmpItemKindUnit = { fg = colors.norm_subtle }
    c.CmpItemKindValue = { fg = colors.norm }
    c.CmpItemKindEnum = { fg = colors.info }
    c.CmpItemKindKeyword = { fg = colors.accent }
    c.CmpItemKindSnippet = { fg = colors.warn }
    c.CmpItemKindColor = { fg = colors.accent }
    c.CmpItemKindFile = { fg = colors.norm }
    c.CmpItemKindReference = { fg = colors.accent }
    c.CmpItemKindFolder = { fg = colors.norm }
    c.CmpItemKindEnumMember = { fg = colors.info }
    c.CmpItemKindConstant = { fg = colors.accent }
    c.CmpItemKindStruct = { fg = colors.info }
    c.CmpItemKindEvent = { fg = colors.warn }
    c.CmpItemKindOperator = { fg = colors.accent }
    c.CmpItemKindTypeParameter = { fg = colors.norm }
    return c
end

local function nvimtree(colors)
    local n = {}
    n.NvimTreeNormal = { fg = colors.norm, bg = colors.bg_very_subtle }
    n.NvimTreeNormalNC = { fg = colors.norm, bg = colors.bg_very_subtle }
    n.NvimTreeRootFolder = { fg = colors.accent, bold = true }
    n.NvimTreeFolderIcon = { fg = colors.info }
    n.NvimTreeFolderName = { fg = colors.norm }
    n.NvimTreeOpenedFolderName = { fg = colors.accent, bold = true }
    n.NvimTreeEmptyFolderName = { fg = colors.norm_subtle }
    n.NvimTreeIndentMarker = { fg = colors.bg_subtle }
    n.NvimTreeGitDirty = { fg = colors.warn }
    n.NvimTreeGitNew = { fg = colors.hint }
    n.NvimTreeGitDeleted = { fg = colors.error }
    n.NvimTreeSpecialFile = { fg = colors.accent, underline = true }
    return n
end

local function gitsigns(colors)
    local g = {}
    g.GitSignsAdd = { fg = colors.hint }
    g.GitSignsAddNr = g.GitSignsAdd
    g.GitSignsAddLn = { fg = colors.bg, bg = colors.hint }
    g.GitSignsChange = { fg = colors.warn }
    g.GitSignsChangeNr = g.GitSignsChange
    g.GitSignsChangeLn = { fg = colors.bg, bg = colors.warn }
    g.GitSignsDelete = { fg = colors.error }
    g.GitSignsDeleteNr = g.GitSignsDelete
    g.GitSignsDeleteLn = { fg = colors.bg, bg = colors.error }
    return g
end

local function which_key(colors)
    local wk = {}
    wk.WhichKey = { fg = colors.accent, bold = true }
    wk.WhichKeyGroup = wk.WhichKey
    wk.WhichKeyDesc = { fg = colors.norm_subtle }
    wk.WhichKeySeparator = { fg = colors.norm }
    wk.WhichKeyValue = { fg = colors.norm_subtle }
    wk.WhichKeyFloat = { bg = colors.bg }
    return wk
end

local function hop(colors)
    local h = {}
    h.HopNextKey = { fg = colors.accent, bold = true }
    h.HopNextKey1 = { fg = colors.hint, bold = true }
    h.HopNextKey2 = { fg = colors.norm_subtle }
    h.HopUnmatched = { fg = colors.bg_subtle }
    return h
end

local function indent_blankline(colors)
    local i = {}
    i.IblIndent = { fg = colors.bg_subtle }
    i.IblScope = { fg = colors.accent }
    return i
end

local function dashboard(colors)
    local d = {}
    d.DashboardHeader = { fg = colors.accent }
    d.DashboardCenter = { fg = colors.norm }
    d.DashboardShortcut = { fg = colors.hint }
    d.DashboardFooter = { fg = colors.norm_subtle }
    return d
end

local function mini(colors)
    local m = {}
    m.MiniStatuslineModeNormal = { fg = colors.bg, bg = colors.norm }
    m.MiniStatuslineModeInsert = { fg = colors.bg, bg = colors.hint }
    m.MiniStatuslineModeVisual = { fg = colors.bg, bg = colors.accent }
    m.MiniStatuslineModeReplace = { fg = colors.bg, bg = colors.error }
    m.MiniStatuslineModeCommand = { fg = colors.bg, bg = colors.warn }
    m.MiniStatuslineModeOther = { fg = colors.bg, bg = colors.info }
    m.MiniStatuslineDevinfo = { fg = colors.norm, bg = colors.bg_very_subtle }
    m.MiniStatuslineFileinfo = { fg = colors.norm, bg = colors.bg_very_subtle }
    m.MiniCompletionActiveParameter = { fg = colors.accent }
    m.MiniIndentscopeSymbol = { fg = colors.accent }
    m.MiniJump = { fg = colors.bg, bg = colors.accent }
    m.MiniJump2dSpot = { fg = colors.bg, bg = colors.accent }
    m.MiniTablineCurrent = { fg = colors.bg, bg = colors.accent }
    m.MiniTablineVisible = { fg = colors.norm, bg = colors.bg_very_subtle }
    m.MiniTablineHidden = { fg = colors.norm_subtle, bg = colors.bg_very_subtle }
    return m
end

local function trouble(colors)
    local t = {}
    t.TroubleText = { fg = colors.norm }
    t.TroubleCount = { fg = colors.bg, bg = colors.accent }
    t.TroubleNormal = { fg = colors.norm, bg = colors.float_bg }
    return t
end

local function notify(colors)
    local n = {}
    n.NotifyERRORTitle = { fg = colors.error, bold = true }
    n.NotifyERRORBody = { fg = colors.error }
    n.NotifyWARNTitle = { fg = colors.warn, bold = true }
    n.NotifyWARNBody = { fg = colors.warn }
    n.NotifyINFOTitle = { fg = colors.info, bold = true }
    n.NotifyINFOBody = { fg = colors.info }
    n.NotifyDEBUGTitle = { fg = colors.medium_gray, bold = true }
    n.NotifyDEBUGBody = { fg = colors.medium_gray }
    n.NotifyTRACETitle = { fg = colors.purple, bold = true }
    n.NotifyTRACEBody = { fg = colors.purple }
    return n
end

local function statusline(colors)
    local s = {}
    s.StatusLine = { fg = colors.norm, bg = colors.bg_very_subtle }
    s.StatusLineNC = { fg = colors.norm_subtle, bg = colors.bg_very_subtle }
    return s
end

local function lualine(colors)
    return {
        normal = {
            a = { fg = colors.bg, bg = colors.accent, gui = "bold" },
            b = { fg = colors.norm, bg = colors.bg_subtle },
            c = { fg = colors.norm, bg = colors.bg_very_subtle },
        },
        insert = {
            a = { fg = colors.bg, bg = colors.hint, gui = "bold" },
            b = { fg = colors.norm, bg = colors.bg_subtle },
            c = { fg = colors.norm, bg = colors.bg_very_subtle },
        },
        visual = {
            a = { fg = colors.bg, bg = colors.accent, gui = "bold" },
        },
        replace = {
            a = { fg = colors.bg, bg = colors.error, gui = "bold" },
        },
        command = {
            a = { fg = colors.bg, bg = colors.warn, gui = "bold" },
        },
        inactive = {
            a = { fg = colors.norm_subtle, bg = colors.bg_very_subtle, gui = "bold" },
            b = { fg = colors.norm_subtle, bg = colors.bg_very_subtle },
            c = { fg = colors.norm_subtle, bg = colors.bg_very_subtle },
        },
    }
end

local function lightline(colors)
    return {
        normal = {
            left = { { colors.medium_gray, colors.white }, { colors.white, colors.medium_gray } },
            right = { { colors.white, colors.medium_gray }, { colors.white, colors.medium_gray } },
            middle = { { colors.lightest_gray, colors.medium_gray } },
        },
        insert = {
            left = { { colors.medium_gray, colors.white }, { colors.white, colors.medium_gray } },
        },
        visual = {
            left = { { colors.medium_gray, colors.white }, { colors.white, colors.medium_gray } },
        },
        replace = {
            left = { { colors.medium_gray, colors.white }, { colors.white, colors.medium_gray } },
        },
        inactive = {
            left = { { colors.lightest_gray, colors.medium_gray }, { colors.medium_gray, colors.medium_gray } },
            middle = { { colors.lightest_gray, colors.medium_gray } },
            right = { { colors.lightest_gray, colors.medium_gray }, { colors.medium_gray, colors.medium_gray } },
        },
        tabline = {
            left = { { colors.lightest_gray, colors.medium_gray } },
            tabsel = { { colors.medium_gray, colors.yellow } },
            middle = { { colors.yellow, colors.medium_gray } },
        },
    }
end

function M.get(colors, config)
    local integrations = config.integrations or {}
    local spec = {}

    if integrations.telescope ~= false then
        merge(spec, telescope(colors))
    end
    if integrations.cmp ~= false then
        merge(spec, cmp(colors))
    end
    if integrations.nvimtree ~= false then
        merge(spec, nvimtree(colors))
    end
    if integrations.gitsigns ~= false then
        merge(spec, gitsigns(colors))
    end
    if integrations.which_key ~= false then
        merge(spec, which_key(colors))
    end
    if integrations.hop ~= false then
        merge(spec, hop(colors))
    end
    if integrations.indent_blankline ~= false then
        merge(spec, indent_blankline(colors))
    end
    if integrations.dashboard ~= false then
        merge(spec, dashboard(colors))
    end
    if integrations.mini ~= false then
        merge(spec, mini(colors))
    end
    if integrations.trouble ~= false then
        merge(spec, trouble(colors))
    end
    if integrations.notify ~= false then
        merge(spec, notify(colors))
    end

    local meta = {
        statusline = statusline(colors),
        lualine = lualine(colors),
        lightline = lightline(colors),
    }

    return { highlights = spec, meta = meta }
end

return M
