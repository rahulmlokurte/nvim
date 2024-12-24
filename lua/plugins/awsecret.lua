return {
  {
    dir = '~/git/awsecret.nvim',
    keys = {
      { '<leader>gsm', "<cmd>lua require('awsecret').fetch_and_cache('/secret/SECRET_NAME')<cr>", desc = 'Fetch Secrets' },
      { '<leader>gsc', "<cmd>lua require('awsecret').select_secret()<cr>", desc = 'Get Secrets' },
    },
    config = function()
      require('awsecret').setup {}
    end,
  },
}
