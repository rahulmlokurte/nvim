return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  after = 'catppuccin',
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
  },
  config = function()
    require('bufferline').setup {
      highlights = require('catppuccin.groups.integrations.bufferline').get(),
      options = {
        color_icons = true,
        separator_style = 'slant',
      },
    }
  end,
}
