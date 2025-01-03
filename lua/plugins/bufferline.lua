return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  after = 'everforest',
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
  },
  config = function()
    require('bufferline').setup {
      options = {
        color_icons = true,
        separator_style = 'slant',
      },
    }
  end,
}
