return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  after = 'catppuccin',
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
  },
  config = function()
    local mocha = require('catppuccin.palettes').get_palette 'mocha'
    require('bufferline').setup {
      highlights = {
        fill = {
          bg = '#1F1F1F',
        },
        tab_selected = {
          fg = '#D27E99',
        },
        buffer_selected = {
          fg = '#D27E99',
          bold = true,
          italic = true,
        },
      },
    }
  end,
}
