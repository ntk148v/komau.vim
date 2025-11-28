local M = { _state = {} }

function M.set(state)
    M._state = state or {}
end

function M.get()
    return M._state
end

function M.colors()
    return M._state.colors
end

function M.config()
    return M._state.config
end

function M.palettes()
    return M._state.palettes or {}
end

return M
