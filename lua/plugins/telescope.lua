return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-dap.nvim',
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'nvim-tree/nvim-web-devicons' },
  },
  config = function()
    local telescope = require 'telescope'
    local colors = require('catppuccin.palettes').get_palette()
    local TelescopeColor = {
      TelescopeMatching = { fg = colors.flamingo },
      TelescopeSelection = { fg = colors.text, bg = colors.surface0, bold = true },

      TelescopePromptPrefix = { bg = colors.surface0 },
      TelescopePromptNormal = { bg = colors.surface0 },
      TelescopeResultsNormal = { bg = colors.mantle },
      TelescopePreviewNormal = { bg = colors.mantle },
      TelescopePromptBorder = { bg = colors.surface0, fg = colors.surface0 },
      TelescopeResultsBorder = { bg = colors.mantle, fg = colors.mantle },
      TelescopePreviewBorder = { bg = colors.mantle, fg = colors.mantle },
      TelescopePromptTitle = { bg = colors.pink, fg = colors.mantle },
      TelescopeResultsTitle = { fg = colors.mantle },
      TelescopePreviewTitle = { bg = colors.green, fg = colors.mantle },
      TelescopeBorder = { bg = colors.pink },
    }
    for hl, col in pairs(TelescopeColor) do
      vim.api.nvim_set_hl(0, hl, col)
    end
    telescope.setup {
      defaults = {
        layout_config = {
          height = 0.90,
          width = 0.90,
          preview_cutoff = 0,
          horizontal = { preview_width = 0.60 },
          vertical = { width = 0.55, height = 0.9, preview_cutoff = 0 },
          prompt_position = 'top',
        },
        path_display = { 'smart' },
        prompt_prefix = ' ',
        selection_caret = ' ',
        entry_prefix = ' ',
      },
      pickers = {
        find_files = {
          theme = 'dropdown',
        },
        live_grep = {
          prompt_prefix = '󰱽 ',
          theme = 'dropdown',
        },
        buffers = {
          prompt_prefix = '󰸩 ',
          theme = 'dropdown',
        },
        help_tags = {
          theme = 'dropdown',
        },
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown {
            initial_mode = 'normal',
            sorting_strategy = 'ascending',
            layout_strategy = 'horizontal',
            layout_config = {
              horizontal = {
                width = 0.5,
                height = 0.4,
                preview_width = 0.6,
              },
            },
          },
        },
      },
    }
    telescope.load_extension 'dap'
    telescope.load_extension 'ui-select'
    telescope.load_extension 'noice'
    telescope.load_extension 'fzf'
    local wk = require 'which-key'
    wk.add {
      { '<leader>f', group = 'file' },
      { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find in Buffers' },
      { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find Files' },
      { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
      { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help Tags' },
    }
  end,
}
