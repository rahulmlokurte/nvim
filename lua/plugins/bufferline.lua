return {
  'akinsho/bufferline.nvim',
  event = 'ColorScheme',
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
  },
  config = function()
    require('bufferline').setup {
      highlights = require 'rose-pine.plugins.bufferline',
    }
  end,
}
