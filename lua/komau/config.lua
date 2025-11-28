local fn = require("komau.fn")

local defaults = {
    style = "auto", -- "dark", "light", or "auto"
    transparent = false,
    dim_inactive = false,
    terminal_colors = true,
    palette_overrides = {},
    overrides = {},
    templates = {},
    styles = {
        comments = { italic = true },
        keywords = { bold = true },
        functions = {},
        strings = {},
        variables = {},
    },
    integrations = {
        treesitter = true,
        lsp = true,
        diagnostics = true,
        cmp = true,
        telescope = true,
        gitsigns = true,
        nvimtree = true,
        trouble = true,
        hop = true,
        which_key = true,
        indent_blankline = true,
        notify = true,
        mini = true,
        dashboard = true,
        statusline = {
            lightline = true,
            lualine = true,
        },
    },
}

local M = { _values = fn.deepcopy(defaults) }

function M.set(opts)
    if not opts or fn.is_empty(opts) then
        M._values = fn.deepcopy(defaults)
        return M._values
    end

    M._values = fn.deep_extend("force", fn.deepcopy(defaults), opts)
    return M._values
end

function M.extend(opts)
    if not opts or fn.is_empty(opts) then
        return M._values
    end

    M._values = fn.deep_extend("force", fn.deepcopy(M._values), opts)
    return M._values
end

function M.get()
    return M._values
end

function M.defaults()
    return fn.deepcopy(defaults)
end

return M
