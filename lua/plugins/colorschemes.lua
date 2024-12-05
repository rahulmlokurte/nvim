return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        transparent_background = true,
        integrations = {
          cmp = true,
          dap = true,
          fzf = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = true,
          harpoon = true,
          noice = true,
          dap_ui = true,
          treesitter_context = true,
          telescope = {
            enabled = true,
            style = 'nvchad',
          },
          lsp_trouble = true,
          which_key = true,
        },
      }
      vim.cmd.colorscheme 'catppuccin-mocha'
    end,
  },
}
