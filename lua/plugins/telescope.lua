return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.8',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-dap.nvim',
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
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
        prompt_prefix = '🔍 ',
        selection_caret = ' ',
        layout_strategy = 'vertical',
        layout_config = {
          vertical = { width = 0.5, height = 0.8, prompt_position = 'top' },
        },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = 'smart_case',
        },
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
      pickers = {
        find_files = {
          theme = 'dropdown',
          previwer = false,
        },
        live_grep = {
          theme = 'ivy',
          layout_config = {
            height = 0.5,
            prompt_position = 'top',
          },
        },
        buffers = {
          theme = 'dropdown',
          previwer = false,
        },
        help_tags = {
          theme = 'cursor',
        },
      },
    }
    telescope.load_extension 'dap'
    telescope.load_extension 'ui-select'
    telescope.load_extension 'noice'
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
