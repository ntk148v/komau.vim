-- Editor compatibility helpers.
--
-- The colorscheme targets both Neovim and Vim 9 built with +lua, which only
-- partially overlap: `vim.cmd`, `vim.o` and Neovim's `nvim_set_hl` argument
-- shape do not exist in Vim. Everything editor specific lives here so the
-- rest of the plugin stays free of feature checks.

local M = {}

-- Attributes accepted by Neovim's nvim_set_hl() and by `:highlight` in a
-- gui= argument.
local style_attrs = {
    bold = true,
    italic = true,
    underline = true,
    undercurl = true,
    underdouble = true,
    underdotted = true,
    underdashed = true,
    strikethrough = true,
    reverse = true,
    standout = true,
    nocombine = true,
}

-- Same list for a cterm= argument, where "reverse" is spelled "inverse".
local cterm_attrs = {
    bold = "bold",
    italic = "italic",
    underline = "underline",
    undercurl = "undercurl",
    underdouble = "underdouble",
    underdotted = "underdotted",
    underdashed = "underdashed",
    strikethrough = "strikethrough",
    reverse = "inverse",
    standout = "standout",
    nocombine = "nocombine",
}

M.levels = (vim.log and vim.log.levels) or { ERROR = 1, WARN = 2, INFO = 3 }

local function exec(cmd)
    if vim.cmd then
        return vim.cmd(cmd)
    end
    -- Vim: a `silent!` prefix does NOT suppress W18. syn_add_group() in
    -- src/highlight.c reports the offending character with msg() and then
    -- breaks out of its check loop, so `@`-prefixed treesitter group names warn
    -- on first creation regardless of :silent, and the load additionally
    -- reports "Error detected while processing". execute() captures the
    -- message instead of displaying it and still applies the command, so the
    -- group is defined either way.
    if vim.fn and vim.fn.execute then
        pcall(vim.fn.execute, cmd)
        return
    end
    if vim.command then
        pcall(vim.command, cmd)
    end
end

M.exec = exec

function M.is_nvim()
    if vim.fn and vim.fn.has then
        local ok, value = pcall(vim.fn.has, "nvim")
        if ok then
            return value == 1
        end
    end
    return vim.api ~= nil and vim.api.nvim_set_hl ~= nil
end

-- &background, read lazily so a later `:set background=light` is honoured.
-- Neovim exposes it as `vim.o`/`vim.opt`; Vim has neither, so fall back to
-- evaluating the option directly. Without this the light variant silently
-- renders with the dark palette on Vim.
function M.background()
    if vim.o and vim.o.background then
        return vim.o.background
    end
    if vim.opt then
        local ok, value = pcall(function()
            return vim.opt.background:get()
        end)
        if ok and value then
            return value
        end
    end
    if vim.fn and vim.fn.eval then
        local ok, value = pcall(vim.fn.eval, "&background")
        if ok and (value == "light" or value == "dark") then
            return value
        end
    end
    return "dark"
end

function M.notify(msg, level)
    if vim.notify then
        return vim.notify(msg, level)
    end
    if vim.api and vim.api.nvim_echo then
        return pcall(vim.api.nvim_echo, { { msg } }, true, {})
    end
    if vim.fn and vim.fn.echoerr then
        return pcall(vim.fn.echoerr, msg)
    end
    print(msg)
end

function M.schedule(fn)
    if vim.schedule then
        local ok = pcall(vim.schedule, fn)
        if ok then
            return
        end
    end
    fn()
end

local function normalize_color(value)
    if type(value) == "table" then
        return value
    end
    return { gui = value, cterm = value }
end

function M.set_hl(group, opts)
    if not opts then
        return
    end

    if opts.link then
        exec(string.format("silent! highlight! link %s %s", group, opts.link))
        return
    end

    if M.is_nvim() and vim.api and vim.api.nvim_set_hl then
        local args = {}
        for _, key in ipairs({ "fg", "bg", "sp" }) do
            if opts[key] then
                args[key] = normalize_color(opts[key]).gui
            end
        end
        for key in pairs(style_attrs) do
            if opts[key] then
                args[key] = true
            end
        end
        if opts.style then
            args[opts.style] = true
        end
        vim.api.nvim_set_hl(0, group, args)
        return
    end

    local parts = { "silent! highlight", group }
    for _, key in ipairs({ "fg", "bg", "sp" }) do
        if opts[key] then
            local color = normalize_color(opts[key])
            if key == "fg" then
                table.insert(parts, string.format("guifg=%s", color.gui or "NONE"))
                table.insert(parts, string.format("ctermfg=%s", color.cterm or "NONE"))
            elseif key == "bg" then
                table.insert(parts, string.format("guibg=%s", color.gui or "NONE"))
                table.insert(parts, string.format("ctermbg=%s", color.cterm or "NONE"))
            else
                table.insert(parts, string.format("guisp=%s", color.gui or "NONE"))
            end
        end
    end

    local gui, cterm = {}, {}
    for key, cterm_name in pairs(cterm_attrs) do
        if opts[key] then
            table.insert(gui, key)
            table.insert(cterm, cterm_name)
        end
    end
    if opts.style then
        table.insert(gui, opts.style)
        table.insert(cterm, opts.style)
    end

    table.insert(parts, string.format("gui=%s", #gui > 0 and table.concat(gui, ",") or "NONE"))
    table.insert(parts, string.format("cterm=%s", #cterm > 0 and table.concat(cterm, ",") or "NONE"))

    exec(table.concat(parts, " "))
end

local function quote(value)
    return "'" .. tostring(value):gsub("'", "''") .. "'"
end

function M.set_terminal_colors(colors)
    if not colors then
        return
    end

    local ansi = {}
    for _, value in ipairs(colors) do
        table.insert(ansi, normalize_color(value).gui)
    end

    if M.is_nvim() then
        for index, hex in ipairs(ansi) do
            vim.g["terminal_color_" .. (index - 1)] = hex
        end
        return
    end

    local items = {}
    for _, hex in ipairs(ansi) do
        table.insert(items, quote(hex))
    end
    exec("let g:terminal_ansi_colors = [" .. table.concat(items, ",") .. "]")
end

return M
