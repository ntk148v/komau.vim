local fn = require("komau.fn")
local utils = require("komau.utils")

local builtin = {}

-- Built-in template to ensure Normal and NormalNC follow transparency changes.
builtin.normalized_normal = function(colors, highlights, config)
    if not config.transparent then
        return nil
    end

    return {
        Normal = { fg = highlights.Normal and highlights.Normal.fg or colors.norm, bg = colors.none },
        NormalNC = { fg = highlights.NormalNC and highlights.NormalNC.fg or colors.norm, bg = colors.none },
        EndOfBuffer = { fg = colors.none },
        SignColumn = { bg = colors.none },
    }
end

local function flatten(value, acc)
    acc = acc or {}
    if type(value) == "function" then
        table.insert(acc, value)
        return acc
    end
    if type(value) == "table" then
        if fn.is_list(value) then
            for _, item in ipairs(value) do
                flatten(item, acc)
            end
        else
            for _, item in pairs(value) do
                flatten(item, acc)
            end
        end
    end
    return acc
end

local function collect_templates(config)
    local collected = {}
    for _, template in pairs(builtin) do
        table.insert(collected, template)
    end

    if not config or not config.templates then
        return collected
    end

    for _, template in ipairs(flatten(config.templates)) do
        table.insert(collected, template)
    end

    return collected
end

local M = {}

function M.apply(highlights, colors, config)
    local result = fn.deepcopy(highlights)
    local templates = collect_templates(config)

    for _, template in ipairs(templates) do
        local ok, delta = pcall(template, colors, result, config)
        if ok and type(delta) == "table" then
            result = fn.deep_extend("force", result, delta)
        elseif not ok then
            utils.schedule(function()
                utils.notify(string.format("komau: template error: %s", delta), vim.log.levels.WARN)
            end)
        end
    end

    return result
end

return M
