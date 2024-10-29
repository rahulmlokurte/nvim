return {
  'nvim-lualine/lualine.nvim',
  enabled = true,
  event = 'VeryLazy',
  opts = function(plugin)
    if plugin.override then
      require('lazyvim.util').deprecate('lualine.override', 'lualine.opts')
    end

    local icons = require 'config.icons'

    local diagnostics = {
      'diagnostics',
      sources = { 'nvim_diagnostic' },
      sections = { 'error', 'warn', 'info', 'hint' },
      symbols = {
        error = icons.diagnostics.Error,
        hint = icons.diagnostics.Hint,
        info = icons.diagnostics.Info,
        warn = icons.diagnostics.Warn,
      },
      colored = true,
      update_in_insert = false,
      always_visible = false,
    }

    local diff = {
      'diff',
      symbols = {
        added = icons.git.added .. ' ',
        untracked = icons.git.added .. ' ',
        modified = icons.git.changed .. ' ',
        removed = icons.git.deleted .. ' ',
      },
      colored = true,
      always_visible = false,
      source = function()
        local gitsigns = vim.b.gitsigns_status_dict
        if gitsigns then
          return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
          }
        end
      end,
    }

    return {
      options = {
        theme = 'rose-pine',
        globalstatus = true,
        icons_enabled = true,
        component_separators = '|',
        section_separators = '',
        disabled_filetypes = { statusline = { 'dashboard', 'lazy', 'alpha' } },
      },
      sections = {
        lualine_a = {
          {
            'filename',
            path = 0,
            use_mode_colors = true,
            shorting_target = 40,
            symbols = {
              modified = ' ●', -- Text to show when the buffer is modified
              alternate_file = '#', -- Text to show to identify the alternate file
              directory = '', -- Text to show when the buffer is a directory
            },
          },
        },
        lualine_b = { 'branch' },
        lualine_c = { diagnostics },
        lualine_x = { diff },
        lualine_y = { 'progress' },
        lualine_z = {},
      },
    }
  end,
}
