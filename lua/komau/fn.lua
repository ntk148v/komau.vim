local M = {}

function M.is_list(tbl)
    if type(tbl) ~= "table" then
        return false
    end

    local count = 0
    for k in pairs(tbl) do
        if type(k) ~= "number" then
            return false
        end
        count = count + 1
    end

    for i = 1, count do
        if tbl[i] == nil then
            return false
        end
    end

    return true
end

function M.is_empty(tbl)
    return type(tbl) ~= "table" or next(tbl) == nil
end

local function deepcopy(value, visited)
    if type(value) ~= "table" then
        return value
    end

    if visited and visited[value] then
        return visited[value]
    end

    local copy = {}
    visited = visited or {}
    visited[value] = copy

    for k, v in pairs(value) do
        copy[deepcopy(k, visited)] = deepcopy(v, visited)
    end
    return setmetatable(copy, getmetatable(value))
end

M.deepcopy = deepcopy

local function extend(dst, src)
    for k, v in pairs(src) do
        if type(v) == "table" and type(dst[k]) == "table" then
            extend(dst[k], v)
        else
            dst[k] = deepcopy(v)
        end
    end
end

function M.deep_extend(_, ...)
    local result = {}
    local args = { ... }
    for _, tbl in ipairs(args) do
        if type(tbl) == "table" then
            extend(result, tbl)
        end
    end
    return result
end

return M
