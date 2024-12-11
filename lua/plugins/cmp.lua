return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'onsails/lspkind.nvim',
      {
        'L3MON4D3/LuaSnip',
        dependencies = { 'rafamadriz/friendly-snippets' },
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
        end,
      },
      'saadparwaiz1/cmp_luasnip',
    },
    config = function()
      local cmp = require 'cmp'
      local defaults = require 'cmp.config.default'()
      local lspkind = require 'lspkind'
      local luasnip = require 'luasnip'

      cmp.setup {
        completion = { completeopt = 'menu,menuone,preview' },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        window = {
          completion = {
            border = 'rounded',
            scrollbar = true,
            winblend = 0,
          },
          documentation = {
            border = 'rounded',
            max_height = math.floor(vim.o.lines * 0.5),
            max_width = math.floor(vim.o.columns * 0.4),
            winblend = 0,
          },
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<CR>'] = cmp.mapping.confirm { select = true, behavior = cmp.ConfirmBehavior.Replace },
        },
        sources = cmp.config.sources({
          -- keyword_length = 2 to not show completions with single letter identifiers.
          { name = 'nvim_lsp', keyword_length = 2 },
          {
            name = 'luasnip',
            -- Don't show snippet completions in comments or strings.
            entry_filter = function()
              local ctx = require 'cmp.config.context'
              local in_string = ctx.in_syntax_group 'String' or ctx.in_treesitter_capture 'string'
              local in_comment = ctx.in_syntax_group 'Comment' or ctx.in_treesitter_capture 'comment'

              return not in_string and not in_comment
            end,
          },
        }, {
          {
            name = 'buffer',
            keyword_length = 3,
            option = {
              -- Buffer completions from all visible buffers (that aren't huge).
              get_bufnrs = function()
                local bufs = {}

                for _, win in ipairs(vim.api.nvim_list_wins()) do
                  local buf = vim.api.nvim_win_get_buf(win)
                  if vim.bo[buf].filetype ~= 'bigfile' then
                    table.insert(bufs, buf)
                  end
                end

                return bufs
              end,
            },
          },
        }),
        sorting = defaults.sorting,
        performance = {
          max_view_entries = 10,
        },
        preselect = cmp.PreselectMode.None,
        formatting = {
          format = lspkind.cmp_format {
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
            menu = {
              buffer = '[Buffer]',
              nvim_lsp = '[LSP]',
              luasnip = '[LuaSnip]',
              nvim_lua = '[Lua]',
              latex_symbols = '[Latex]',
            },
          },
        },
      }
    end,
  },
}
