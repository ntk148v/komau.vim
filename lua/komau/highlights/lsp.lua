local M = {}

local severity = {
    Error = "error",
    Warn = "warn",
    Warning = "warn",
    Info = "info",
    Information = "info",
    Hint = "hint",
}

local function diag_groups(colors)
    local spec = {}
    for name, key in pairs(severity) do
        local color = colors[key]
        local vt_bg = colors.bg_very_subtle
        spec["Diagnostic" .. name] = { fg = color }
        spec["DiagnosticSign" .. name] = { fg = color, bg = colors.none }
        spec["DiagnosticFloating" .. name] = { fg = color }
        spec["DiagnosticVirtualText" .. name] = { fg = color, bg = vt_bg }
        spec["DiagnosticUnderline" .. name] = { sp = color, undercurl = true }
    end
    return spec
end

function M.get(colors, config)
    local integrations = config.integrations or {}
    local spec = {}

    if integrations.diagnostics ~= false then
        local diags = diag_groups(colors)
        for group, opts in pairs(diags) do
            spec[group] = opts
        end
    end

    if integrations.lsp == false then
        return spec
    end

    spec.LspReferenceText = { bg = colors.bg_subtle }
    spec.LspReferenceRead = { bg = colors.bg_subtle }
    spec.LspReferenceWrite = { bg = colors.bg_subtle }
    spec.LspCodeLens = { fg = colors.norm_subtle, italic = true }
    spec.LspCodeLensSeparator = { fg = colors.bg_subtle }
    spec.LspSignatureActiveParameter = { fg = colors.bg, bg = colors.accent, bold = true }
    spec.LspInlayHint = { fg = colors.medium_gray, bg = colors.bg_very_subtle, italic = true }

    return spec
end

return M
