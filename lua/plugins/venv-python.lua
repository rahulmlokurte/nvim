return {
  'linux-cultist/venv-selector.nvim',
  branch = 'regexp', -- Use this branch for the new version
  cmd = 'VenvSelect',
  opts = {},
  ft = 'python',
  keys = { { '<leader>ve', '<cmd>:VenvSelect<cr>', desc = 'Select VirtualEnv', ft = 'python' } },
}
