<h1 align="center">
  komau.vim
</h1>

<p align="center">
  Yet another minimal colorscheme for Vim/Neovim.<br/>
  <strong>komau</strong> → <strong>không màu</strong> (Vietnamese) → <strong>no color</strong> (English)
</p>

| Dark                                                                                                                                      | Light                                                                                                                                       |
| ----------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- |
| <img src="https://raw.githubusercontent.com/ntk148v/komau.vim/master/screenshots/golang-dark.png" alt="dark" style="border-radius:1%" /> | <img src="https://raw.githubusercontent.com/ntk148v/komau.vim/master/screenshots/golang-light.png" alt="light" style="border-radius:1%" /> |

## Highlights

- Fully Lua-driven palette + highlight pipeline with Vim fallback (requires `+lua`).
- Automatic dark/light detection (`style = "auto"`) with palette overrides and blending helpers.
- Large plugin surface: Treesitter, LSP/diagnostics, telescope, cmp, gitsigns, nvim-tree, trouble, which-key, hop, mini.nvim, dashboard, notify, statuslines (lightline + lualine) and more.
- Terminal ANSI color export for both Vim and Neovim.
- Highly configurable via setup options, per-group overrides, and template functions so you can reshape the highlight table before it is applied.

## Installation

Any manager that respects the `runtimepath` works:

```vim
" Vim-plug
Plug 'ntk148v/komau.vim'
```

```lua
-- lazy.nvim / packer / etc.
{ 'ntk148v/komau.vim' }
```

## Usage

### Neovim (Lua)

```lua
require('komau').setup({
  style = 'auto', -- "dark" | "light" | "auto" (uses &background)
  transparent = false,
  dim_inactive = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { bold = true },
  },
  integrations = {
    treesitter = true,
    lsp = true,
    telescope = true,
    cmp = true,
    gitsigns = true,
    which_key = true,
    indent_blankline = true,
    mini = true,
    statusline = { lightline = true, lualine = true },
  },
  overrides = {
    Normal = { fg = '#f5eee6', bg = '#222222' },
    TelescopeTitle = function(colors)
      return { fg = colors.bg, bg = colors.accent, bold = true }
    end,
  },
  templates = {
    function(colors, highlights)
      return {
        FloatBorder = { fg = colors.accent, bg = colors.float_bg },
      }
    end,
  },
})

vim.cmd.colorscheme('komau')
```

### Vim (with `+lua`)

```vim
let g:komau_config = {
      \ 'style': 'dark',
      \ 'transparent': v:true,
      \ 'integrations': { 'treesitter': v:false }
      \ }
lua require('komau').setup(vim.g.komau_config)
colorscheme komau
```

> **Note**: Classic Vim must be compiled with `+lua` support. Without it the colorscheme cannot run.

## Templates & Overrides

- **`overrides`**: map of `HighlightGroup -> table|function`. Functions receive `(colors, current_spec)` and must return a table that will be merged.
- **`templates`**: list/nested list of functions `(colors, highlights, config)` returning tables. Use this for reusable presets (e.g., transparency, high-contrast floats).

Templates run after all built-in highlights are assembled, giving you complete control over the final spec.

## Supported plugins

Treesitter · built-in LSP (semantic tokens, diagnostics, inlay hints) · telescope · nvim-cmp · gitsigns · nvim-tree · trouble · hop · which-key · indent-blankline/Ibl · dashboard/alpha · mini.nvim (statusline, indentscope, etc.) · notify · terminal ANSI colors · statuslines (lightline + lualine palettes exposed via Lua).

If something you rely on is missing, PRs are welcome!

## Credits

Inspired by [pbrisbin/vim-colors-off](https://github.com/pbrisbin/vim-colors-off) and many modern Lua-first themes.

## Contributing

Bug reports, feature requests, and PRs are appreciated. Please describe your environment (Neovim/Vim version, terminal, plugin list) and include screenshots when possible.
