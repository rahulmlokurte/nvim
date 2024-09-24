return {
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = function()
      local icons = require 'config.icons'
      require('gitsigns').setup {
        signs = {
          add = { text = icons.git.added },
          change = { text = icons.git.changed },
          delete = { text = icons.git.deleted },
          topdelete = { text = icons.git.deleted },
          changedelete = { text = icons.git.changed },
          untracked = { text = icons.git.added },
        },
      }
      vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>')
      vim.keymap.set('n', '<leader>gp', ':Gitsigns preview_hunk<CR>')
      vim.keymap.set('n', '<leader>gb', ':Gitsigns toggle_current_line_blame<CR>')
    end,
  },
  {
    'tpope/vim-fugitive',
  },
}
