return {
  {
    'mistweaverco/kulala.nvim',
    opts = {},
    config = function()
      vim.filetype.add {
        extension = {
          ['http'] = 'http',
        },
      }
    end,
  },
}
