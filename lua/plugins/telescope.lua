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
      { 'debugloop/telescope-undo.nvim' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-dap.nvim' },
    },
    config = function()
      local actions = require 'telescope.actions'
      local builtin = require 'telescope.builtin'
      local telescope = require 'telescope'

      telescope.setup {
        pickers = {
          colorscheme = {
            enable_preview = true,
          },
          buffers = {
            previewer = false,
            layout_config = {
              width = 0.7,
              prompt_position = 'top',
            },
          },
          lsp_references = {
            layout_strategy = 'vertical',
            layout_config = {
              width = 0.9,
              height = 0.9,
              preview_cutoff = 1,
              mirror = false,
            },
          },
          lsp_implementations = {
            layout_strategy = 'vertical',
            layout_config = {
              width = 0.9,
              height = 0.9,
              preview_cutoff = 1,
              mirror = false,
            },
          },
          lsp_document_symbols = {
            layout_strategy = 'vertical',
            layout_config = {
              width = 0.9,
              height = 0.9,
              preview_cutoff = 1,
              mirror = false,
            },
          },
          lsp_dynamic_workspace_symbols = {
            layout_strategy = 'vertical',
            layout_config = {
              width = 0.9,
              height = 0.9,
              preview_cutoff = 1,
              mirror = false,
            },
          },
        },
        defaults = {
          path_display = { 'smart' },
          layout_strategy = 'horizontal',
          layout_config = {
            horizontal = {
              prompt_position = 'top',
              preview_width = 0.5,
            },
            width = 0.8,
            height = 0.8,
            preview_cutoff = 120,
          },
          sorting_strategy = 'ascending',
          winblend = 0,
          prompt_prefix = '  ',
          selection_caret = ' ',
          mappings = {
            i = {
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-c>'] = actions.close, -- close Telescope window
              ['<ESC>'] = actions.close,
              -- ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {
              layout_config = {
                width = 0.6,
                height = 0.4,
              },
            },
          },
          ['undo'] = {
            layout_strategy = 'vertical',
            layout_config = {
              width = 0.9,
              height = 0.9,
              preview_cutoff = 1,
              mirror = false,
            },
          },
        },
      }

      telescope.load_extension 'fzf'
      telescope.load_extension 'ui-select'
      telescope.load_extension 'undo'
      telescope.load_extension 'dap'

      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Find File' })
      vim.keymap.set('n', '<C-p>', builtin.git_files, { desc = 'Find Git files' })
      vim.keymap.set('n', '<leader><leader>', function()
        builtin.buffers { sort_mru = true, ignore_current_buffer = true }
      end, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Live Grep' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Help Tags' })
      vim.keymap.set('n', '<leader>fx', builtin.treesitter, { desc = 'List treesitter funcs, vars' })
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = 'Recent Files' })
      vim.keymap.set('n', '<leader>gi', builtin.lsp_implementations, { desc = 'Show Implementations' })
      vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'List Todo' })
      vim.keymap.set('n', '<leader>u', '<cmd>Telescope undo<cr>', { desc = 'Telescope Undo' })
      vim.keymap.set('n', '<leader>co', '<cmd>Telescope colorscheme<cr>', { desc = 'Telescope colorscheme' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          -- winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>f/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = 'Search [/] in Open Files' })

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files {
          cwd = vim.fn.stdpath 'config',
          prompt_title = 'Neovim configuration',
        }
      end, { desc = 'Search neovim files' })
    end,
  },
}
