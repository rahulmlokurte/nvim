return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  after = 'catppuccin',
  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next buffer' },
  },
  config = function()
    local tokyonight_colors = require('tokyonight.colors').setup()
    require('bufferline').setup {
      options = {
        color_icons = true,
        separator_style = 'slant',
      },
      highlights = {
        fill = {
          bg = tokyonight_colors.bg,
        },
      },
    }
  end,
}
