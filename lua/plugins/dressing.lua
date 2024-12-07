return {
  'stevearc/dressing.nvim',
  opts = {},
  config = function()
    require('dressing').setup {
      input = {
        win_options = {
          winhighlight = 'NormalFloat:DiagnosticError',
        },
      },
      select = {
        get_config = function(opts)
          if opts.kind == 'codeaction' then
            return {
              backend = 'nui',
              nui = {
                relative = 'cursor',
                max_width = 40,
              },
            }
          end
        end,
      },
    }
  end,
}
