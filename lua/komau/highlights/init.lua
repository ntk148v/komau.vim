local registry = {
    { name = "core", module = "komau.highlights.core", optional = false },
    { name = "syntax", module = "komau.highlights.syntax", optional = false },
    { name = "treesitter", module = "komau.highlights.treesitter", optional = true },
    { name = "lsp", module = "komau.highlights.lsp", optional = true },
    { name = "plugins", module = "komau.highlights.plugins", optional = true },
}

local modules = {}
for _, entry in ipairs(registry) do
    local ok, mod = pcall(require, entry.module)
    if ok and type(mod) == "table" then
        modules[entry.name] = mod
    elseif not entry.optional then
        error(string.format("komau: failed to load highlight module '%s' (%s)", entry.name, entry.module))
    end
end

local function is_enabled(name, config)
    local integrations = config.integrations or {}
    if name == "treesitter" then
        return integrations.treesitter ~= false
    elseif name == "lsp" then
        return integrations.lsp ~= false or integrations.diagnostics ~= false
    elseif name == "plugins" then
        return true
    end
    return true
end

local function merge_spec(target, additions)
    if not additions then
        return
    end
    for group, opts in pairs(additions) do
        target[group] = opts
    end
end

local function merge_meta(target, additions)
    if not additions then
        return
    end
    for key, value in pairs(additions) do
        target[key] = value
    end
end

local order = {}
for _, entry in ipairs(registry) do
    if modules[entry.name] then
        table.insert(order, entry.name)
    end
end

local M = {}

function M.collect(colors, config)
    local spec = {}
    local meta = {}

    for _, name in ipairs(order) do
        if is_enabled(name, config) then
            local mod = modules[name]
            local ok, chunk = pcall(mod.get, colors, config)
            if ok and type(chunk) == "table" then
                local highlights = chunk.highlights or chunk
                merge_spec(spec, highlights)
                if chunk.meta then
                    merge_meta(meta, chunk.meta)
                end
            else
                vim.schedule(function()
                    vim.notify(
                        string.format("komau: failed to compute %s highlights: %s", name, chunk),
                        vim.log.levels.WARN
                    )
                end)
            end
        end
    end

    return spec, meta
end

return M
