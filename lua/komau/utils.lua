local fn = require("komau.fn")
local compat = require("komau.compat")

local M = {}

function M.set_highlight(group, opts)
    compat.set_hl(group, opts)
end

function M.apply_terminal(colors)
    if not colors or not colors.terminal then
        return
    end

    compat.set_terminal_colors(colors.terminal)
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

function M.notify(msg, level)
    compat.notify(msg, level)
end

function M.schedule(fn_)
    compat.schedule(fn_)
end

return M
