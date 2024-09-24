return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      local theme_colors = require 'config.colors'
      require('catppuccin').setup {
        transparent_background = true,
        color_overrides = { all = theme_colors },
        custom_highlights = function(colors)
          return {
            CurSearch = { bg = colors.green },
            GitSignsChange = { fg = colors.blue },
          }
        end,
        integrations = {
          cmp = true,
          gitsigns = true,
          neotree = true,
          treesitter = true,
          dap_ui = true,
          noice = true,
          lsp_trouble = true,
          lsp_saga = true,
          native_lsp = {
            enabled = true,
            virtual_text = {
              errors = { 'italic' },
              hints = { 'italic' },
              warnings = { 'italic' },
              information = { 'italic' },
            },
            underlines = {
              errors = { 'underline' },
              hints = { 'underline' },
              warnings = { 'underline' },
              information = { 'underline' },
            },
            inlay_hints = {
              background = true,
            },
          },
          notify = true,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
          telescope = {
            enabled = true,
          },
        },
      }
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
}
