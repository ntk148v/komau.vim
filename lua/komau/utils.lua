local fn = require("komau.fn")

local M = {}

local has_nvim = vim.api ~= nil and vim.api.nvim_set_hl ~= nil

local style_keys = {
    bold = "bold",
    italic = "italic",
    underline = "underline",
    undercurl = "undercurl",
    underdouble = "underdouble",
    underdotted = "underdotted",
    underdashed = "underdashed",
    strikethrough = "strikethrough",
    reverse = "reverse",
    standout = "standout",
    nocombine = "nocombine",
}

local function normalize_color(color)
    if type(color) == "table" then
        return color
    end
    return { gui = color, cterm = color }
end

local function normalize_opts(opts)
    if not opts then
        return {}
    end

    local normalized = {}
    for key, value in pairs(opts) do
        if key == "fg" or key == "bg" or key == "sp" then
            normalized[key] = normalize_color(value)
        else
            normalized[key] = value
        end
    end
    return normalized
end

function M.set_highlight(group, opts)
    if not opts then
        return
    end

    if opts.link then
        vim.cmd(string.format("highlight! link %s %s", group, opts.link))
        return
    end

    local normalized = normalize_opts(opts)

    if has_nvim then
        local gui_opts = {}
        for key, value in pairs(normalized) do
            if key == "fg" or key == "bg" or key == "sp" then
                gui_opts[key] = value.gui or value
            elseif key ~= "ctermfg" and key ~= "ctermbg" then
                gui_opts[key] = value
            end
        end
        vim.api.nvim_set_hl(0, group, gui_opts)
        return
    end

    local parts = { "highlight", group }
    if normalized.fg then
        table.insert(parts, string.format("guifg=%s", normalized.fg.gui or "NONE"))
        table.insert(parts, string.format("ctermfg=%s", normalized.fg.cterm or "NONE"))
    end
    if normalized.bg then
        table.insert(parts, string.format("guibg=%s", normalized.bg.gui or "NONE"))
        table.insert(parts, string.format("ctermbg=%s", normalized.bg.cterm or "NONE"))
    end
    if normalized.sp then
        table.insert(parts, string.format("guisp=%s", normalized.sp.gui or "NONE"))
    end

    local styles = {}
    for key, style_name in pairs(style_keys) do
        if normalized[key] then
            table.insert(styles, style_name)
        end
    end

    if normalized.style then
        table.insert(styles, normalized.style)
    end

    local style_value = next(styles) and table.concat(styles, ",") or "NONE"
    table.insert(parts, string.format("gui=%s", style_value))
    table.insert(parts, string.format("cterm=%s", style_value))

    vim.cmd(table.concat(parts, " "))
end

function M.apply_terminal(colors)
    if not colors or not colors.terminal then
        return
    end

    for index, value in ipairs(colors.terminal) do
        local hex = type(value) == "table" and value.gui or value
        if has_nvim then
            vim.g["terminal_color_" .. (index - 1)] = hex
        end
    end

    if not has_nvim then
        local ansi = {}
        for _, value in ipairs(colors.terminal) do
            table.insert(ansi, type(value) == "table" and value.gui or value)
        end
        vim.g.terminal_ansi_colors = ansi
    end
end

function M.merge_tables(target, ...)
    for _, source in ipairs({ ... }) do
        if type(source) == "table" then
            for key, value in pairs(source) do
                if type(value) == "table" and not fn.is_list(value) then
                    target[key] = target[key] or {}
                    M.merge_tables(target[key], value)
                else
                    target[key] = value
                end
            end
        end
    end
    return target
end

function M.apply_highlights(spec)
    for group, opts in pairs(spec) do
        M.set_highlight(group, opts)
    end
end

function M.copy(value)
    return fn.deepcopy(value)
end

function M.apply_style(spec, style_opts)
    if not style_opts or fn.is_empty(style_opts) then
        return spec
    end

    local result = fn.deepcopy(spec or {})
    for key, value in pairs(style_opts) do
        result[key] = value
    end
    return result
end

return M
