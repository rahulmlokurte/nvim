return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    branch = '0.1.x',
    dependencies = {
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-frecency.nvim', version = '*' },
      { 'debugloop/telescope-undo.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-dap.nvim' },
    },
  },
}
