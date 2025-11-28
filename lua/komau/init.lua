local config = require("komau.config")
local highlights = require("komau.highlights")
local palette = require("komau.palette")
local templates = require("komau.templates")
local utils = require("komau.utils")

local M = {}

function M.setup(opts)
    config.set(opts)
end

function M.load(opts)
    local cfg = config.extend(opts or {})
    local colors = palette.build(cfg.style, cfg.palette_overrides)
    local spec, meta = highlights.collect(colors, cfg)
    spec = templates.apply(spec, colors, cfg)
    utils.apply_highlights(spec)
    if cfg.terminal_colors then
        utils.apply_terminal(colors)
    end
    -- expose statusline/lightline tables via meta when needed
end

return M
