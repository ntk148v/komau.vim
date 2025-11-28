local utils = require("komau.utils")

local function with_style(spec, style_opts)
    return utils.apply_style(spec, style_opts)
end

local function link(target)
    return { link = target }
end

local M = {}

function M.get(colors, config)
    local styles = config.styles or {}
    local highlights = {}

    highlights.Comment = with_style({ fg = colors.comment }, styles.comments)
    highlights.Constant = { fg = colors.norm_subtle }
    highlights.String = with_style({ fg = colors.norm }, styles.strings)
    highlights.Character = link("Constant")
    highlights.Number = link("Constant")
    highlights.Boolean = link("Constant")
    highlights.Float = link("Constant")

    highlights.Identifier = with_style({ fg = colors.fg }, styles.variables)
    highlights.Function = with_style({ fg = colors.fg }, styles.functions)

    highlights.Statement = with_style({ fg = colors.fg }, styles.keywords)
    highlights.Conditional = link("Statement")
    highlights.Repeat = link("Statement")
    highlights.Label = link("Statement")
    highlights.Operator = { fg = colors.norm }
    highlights.Keyword = link("Statement")
    highlights.Exception = link("Statement")

    highlights.PreProc = { fg = colors.norm_subtle }
    highlights.Include = link("PreProc")
    highlights.Define = link("PreProc")
    highlights.Macro = link("PreProc")
    highlights.PreCondit = link("PreProc")

    highlights.Type = { fg = colors.norm }
    highlights.StorageClass = link("Type")
    highlights.Structure = link("Type")
    highlights.Typedef = link("Type")

    highlights.Special = with_style({ fg = colors.norm_subtle }, styles.keywords)
    highlights.SpecialChar = link("Special")
    highlights.Tag = link("Special")
    highlights.Delimiter = link("Special")
    highlights.SpecialComment = link("Special")
    highlights.Debug = link("Special")

    highlights.Underlined = { fg = colors.norm, underline = true }
    highlights.Ignore = { fg = colors.bg }
    highlights.Error = { fg = colors.white, bg = colors.error, bold = true }
    highlights.Todo = { fg = colors.accent, underline = true }
    highlights.SpecialKey = { fg = colors.green }
    highlights.NonText = { fg = colors.medium_gray }
    highlights.Directory = { fg = colors.norm, bold = true }

    highlights.MarkdownCode = { fg = colors.bg_subtle }
    highlights.MarkdownLinkReference = { fg = colors.bg_subtle }
    highlights.MarkdownJekyllFrontMatter = { fg = colors.bg_subtle }
    highlights.MarkdownCodeBlock = { fg = colors.norm }
    highlights.MarkdownCodeDelimiter = { fg = colors.norm }
    highlights.MarkdownHeadingDelimiter = { fg = colors.fg }
    highlights.MarkdownRule = { fg = colors.bg_subtle }
    highlights.MarkdownHeadingRule = { fg = colors.bg_subtle }
    highlights.MarkdownId = { fg = colors.light_gray }
    highlights.MarkdownBlockquote = { fg = colors.bg_subtle }
    highlights.MarkdownItalic = with_style({ fg = colors.light_gray }, { italic = true })
    highlights.MarkdownBold = with_style({ fg = colors.fg }, { bold = true })
    highlights.MarkdownInlineURL = with_style({ fg = colors.fg }, { italic = true })
    highlights.MarkdownListItem = { fg = colors.fg }
    highlights.MarkdownOrderedListMarker = { fg = colors.fg }
    highlights.MarkdownLinkText = with_style({ fg = colors.fg }, { bold = true })
    highlights.MarkdownLinkDelimiter = { fg = colors.fg }
    highlights.MarkdownUrl = with_style({ fg = colors.norm_subtle }, { italic = true })

    highlights.htmlH1 = { fg = colors.fg, bold = true }
    highlights.htmlH2 = link("htmlH1")
    highlights.htmlH3 = link("htmlH1")
    highlights.htmlH4 = link("htmlH1")
    highlights.htmlH5 = link("htmlH1")
    highlights.htmlH6 = link("htmlH1")
    highlights.mkdDelimiter = { fg = colors.fg }
    highlights.mkdBold = link("MarkdownBold")
    highlights.mkdInlineURL = link("MarkdownInlineURL")
    highlights.mkdListItem = link("MarkdownListItem")
    highlights.mkdLink = link("MarkdownLinkText")
    highlights.mkdURL = link("MarkdownUrl")

    return highlights
end

return M
