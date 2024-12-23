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
      require('kulala.api').on('after_request', function(data)
        print 'Request completed'
        print('Headers: ' .. data.headers)
        print('Body: ' .. data.body)
      end)
    end,
  },
}
