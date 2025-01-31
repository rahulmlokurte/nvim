-- LSP Plugins
return {
  {
    -- Configures Lua LSP for Neovim
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        -- Load luvit types when the `vim.uv` word is found
        { path = 'luvit-meta/library', words = { 'vim%.uv' } },
      },
    },
  },
  { 'Bilal2453/luvit-meta', lazy = true },
  {
    -- Main LSP Configuration
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Allows extra capabilities provided by nvim-cmp
      'Saghen/blink.cmp',
      -- 'hrsh7th/cmp-nvim-lsp',
    },
    config = function()
      -- LSP (Language Server Protocol) provides features like go-to definition, references, and more.
      -- Language Servers are external tools installed separately. `mason` helps manage them.

      -- Runs when an LSP attaches to a buffer, configuring it.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- Helper function to define LSP-specific key mappings.
          local map = function(keys, func, desc, mode)
            mode = mode or 'n'
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under the cursor.
          map('gd', function()
            Snacks.picker.lsp_definitions()
          end, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', function()
            Snacks.picker.lsp_references()
          end, 'References')

          -- Jump to the implementation of the word under the cursor.
          map('gI', function()
            Snacks.picker.lsp_implementations()
          end, '[G]oto [I]mplementation')

          -- Jump to the type definition of the word under the cursor.
          map('gy', function()
            Snacks.picker.lsp_type_definitions()
          end, 'Type [D]efinition')

          -- Fuzzy find all symbols in the current document.
          map('<leader>ss', function()
            Snacks.picker.lsp_symbols()
          end, 'LSP symbols')

          -- Rename the variable under the cursor.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', { 'n', 'x' })

          -- Go to declaration.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          map('<leader>cl', vim.lsp.codelens.display, 'Show function/types usage/reference count')

          map('<leader>cc', vim.lsp.codelens.clear, 'Clear function/types usage/reference count')

          -- Autocommands to highlight references of the word under the cursor.
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          -- Keymap to toggle inlay hints if supported by the language server.
          if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
            end, '[T]oggle Inlay [H]ints')
          end
          if client and client.name == 'ruff' then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end,
      })

      -- Extend LSP capabilities with nvim-cmp for additional features.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.completion.completionItem.snippetSupport = true
      capabilities = vim.tbl_deep_extend('force', capabilities, require('blink.cmp').get_lsp_capabilities())

      -- Configure and enable language servers. Add/remove LSPs as needed.
      local servers = {
        -- clangd = {},
        -- gopls = {},
        -- pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`ts_ls`) will work just fine
        ts_ls = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
        gopls = {},
        basedpyright = {
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = 'off',
                autoSearchPaths = true,
                diagnosticMode = 'workspace',
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        ruff = {
          init_options = {
            trace = 'messages',
            settings = {
              logLevel = 'debug',
            },
          },
        },
      }

      -- Ensure the specified servers and tools are installed.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'gofumpt',
        'goimports-reviser',
        'golines',
        'basedpyright',
        'mypy',
        'black',
        'java-debug-adapter',
        'java-test',
        'google-java-format',
        'html',
        'cssls',
        'tailwindcss',
        'graphql',
        'eslint-lsp',
        'emmet_ls',
        'prismals',
        'prettierd',
        'codelldb',
        'cpptools',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for ts_ls)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
