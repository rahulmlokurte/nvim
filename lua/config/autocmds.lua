-- Custom code snippets for different purposes

-- Prevent LSP from overwriting treesitter color settings
-- https://github.com/NvChad/NvChad/issues/1907
vim.highlight.priorities.semantic_tokens = 95 -- Or any number lower than 100, treesitter's priority level

-- Appearance of diagnostics
-- Disable virtual text for diagnostics
vim.diagnostic.config {
  title = false,
  underline = true,
  virtual_text = false,
  update_in_insert = false,
  severity_sort = true,
  float = {
    source = 'if_many',
    style = 'minimal',
    border = 'rounded',
    header = '',
    prefix = '',
  },
}

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 }
  end,
  group = highlight_group,
  pattern = '*',
})

-- Fix conceallevel for json files
local json_conceal = vim.api.nvim_create_augroup('YankHighlight', { clear = true })

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = json_conceal,
  pattern = { 'json', 'jsonc', 'json5' },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'java' },
  callback = function()
    vim.opt_local.expandtab = true -- Use spaces instead of tabs
    vim.opt_local.shiftwidth = 4 -- Number of spaces to use for autoindent
    vim.opt_local.tabstop = 4 -- Number of spaces that a <Tab> counts for
  end,
})
