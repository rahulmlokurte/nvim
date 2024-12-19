return {
  {
    'saghen/blink.cmp',
    dependencies = {
      'rafamadriz/friendly-snippets',
      { 'L3MON4D3/LuaSnip', version = 'v2.*' },
    },
    version = 'v0.*',
    opts = {
      snippets = {
        expand = function(snippet)
          require('luasnip').lsp_expand(snippet)
        end,
        active = function(filter)
          if filter and filter.direction then
            return require('luasnip').jumpable(filter.direction)
          end
          return require('luasnip').in_snippet()
        end,
        jump = function(direction)
          require('luasnip').jump(direction)
        end,
      },
      sources = {
        default = { 'lsp', 'path', 'luasnip', 'buffer' },
      },
      {
        completion = {
          menu = {
            draw = {
              treesitter = { 'lsp' },
              columns = { { 'label', 'label_description', gap = 1 }, { 'kind_icon', 'kind' } },
            },
          },
          {
            list = {
              selection = 'auto_insert',
            },
          },
        },
      },
      keymap = { preset = 'enter', ['<C-y>'] = { 'select_and_accept' } },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
      },
      signature = { enabled = true },
    },
  },
}
