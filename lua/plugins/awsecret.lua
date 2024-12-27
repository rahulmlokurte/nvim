return {
  {
    'rahulmlokurte/awsecret.nvim',
    -- dir = '~/git/awsecret.nvim',
    config = function()
      require('awsecret').setup {}
    end,
  },
}
