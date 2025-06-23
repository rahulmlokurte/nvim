---@diagnostic disable: missing-fields

return {
  -- Dracula Theme (Primary)
  {
    'Mofiqul/dracula.nvim',
    name = 'dracula',
    priority = 1000,
    config = function()
      require('dracula').setup {
        -- Customize dracula color palette
        colors = {
          bg = "#282A36",
          fg = "#F8F8F2",
          selection = "#44475A",
          comment = "#6272A4",
          red = "#FF5555",
          orange = "#FFB86C",
          yellow = "#F1FA8C",
          green = "#50FA7B",
          purple = "#BD93F9",
          cyan = "#8BE9FD",
          pink = "#FF79C6",
          bright_red = "#FF6E6E",
          bright_green = "#69FF94",
          bright_yellow = "#FFFFA5",
          bright_blue = "#D6ACFF",
          bright_magenta = "#FF92DF",
          bright_cyan = "#A4FFFF",
          bright_white = "#FFFFFF",
          menu = "#21222C",
          visual = "#3E4452",
          gutter_fg = "#4B5263",
          nontext = "#3B4048",
        },
        -- Show the '~' characters after the end of buffers
        show_end_of_buffer = true,
        -- Use transparent background
        transparent_bg = false,
        -- Set custom lualine background color
        lualine_bg_color = "#44475a",
        -- Set italic comment
        italic_comment = true,
        -- Overrides the default highlights with table see `:h synIDattr`
        overrides = function(colors)
          return {
            -- Enhanced integrations
            TelescopeNormal = { bg = colors.bg },
            TelescopeBorder = { fg = colors.purple },
            TelescopePromptBorder = { fg = colors.purple },
            TelescopeResultsBorder = { fg = colors.purple },
            TelescopePreviewBorder = { fg = colors.purple },
            TelescopeSelectionCaret = { fg = colors.pink },
            TelescopeSelection = { bg = colors.selection },
            TelescopeMatching = { fg = colors.yellow, bold = true },
            
            -- DAP integration
            DapStoppedLine = { bg = colors.selection },
            DapBreakpoint = { fg = colors.red },
            DapLogPoint = { fg = colors.cyan },
            
            -- LSP integration
            DiagnosticError = { fg = colors.red },
            DiagnosticWarn = { fg = colors.orange },
            DiagnosticInfo = { fg = colors.cyan },
            DiagnosticHint = { fg = colors.green },
            
            -- Git integration
            GitSignsAdd = { fg = colors.green },
            GitSignsChange = { fg = colors.orange },
            GitSignsDelete = { fg = colors.red },
            
            -- Completion menu
            BlinkCmpMenu = { bg = colors.menu },
            BlinkCmpMenuBorder = { fg = colors.purple },
            BlinkCmpMenuSelection = { bg = colors.selection, fg = colors.fg, bold = true },
            BlinkCmpDoc = { bg = colors.menu },
            BlinkCmpDocBorder = { fg = colors.purple },
            
            -- Which-key integration
            WhichKey = { fg = colors.purple },
            WhichKeyGroup = { fg = colors.cyan },
            WhichKeyDesc = { fg = colors.fg },
            WhichKeySeperator = { fg = colors.comment },
            WhichKeyFloat = { bg = colors.menu },
            
            -- Trouble integration
            TroubleNormal = { bg = colors.bg },
            TroubleText = { fg = colors.fg },
            
            -- Tree-sitter enhancements
            ["@keyword"] = { fg = colors.pink, italic = true },
            ["@function"] = { fg = colors.green },
            ["@variable"] = { fg = colors.fg },
            ["@parameter"] = { fg = colors.orange, italic = true },
            ["@string"] = { fg = colors.yellow },
            ["@number"] = { fg = colors.purple },
            ["@boolean"] = { fg = colors.purple },
            ["@type"] = { fg = colors.cyan },
            ["@constant"] = { fg = colors.purple },
          }
        end,
      }
      vim.cmd.colorscheme 'dracula'
    end,
  },
  
  -- Catppuccin Theme (Alternative)
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 900,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = true,
        integrations = {
          blink_cmp = true,
          snacks = true,
          lsp_trouble = true,
          dadbod_ui = true,
          which_key = true,
          telescope = true,
        },
        custom_highlights = function(colors)
          return {
            BlinkCmpMenuSelection = { bg = colors.blue, fg = colors.crust, bold = true },
          }
        end,
      }
      -- vim.cmd.colorscheme 'catppuccin'  -- Commented out since Dracula is primary
    end,
  },
  
  -- Everforest Theme (Alternative)
  {
    'neanias/everforest-nvim',
    version = false,
    priority = 800,
    config = function()
      require('everforest').setup {
        on_highlights = function(hl, palette)
          -- stylua: ignore start
          -- Set transparent background for all plugins
          -- hl.Normal = { bg = palette.none}

          -- Git Signs
          hl.GitSignsAdd    = { fg = "#50FA7B" }
          hl.GitSignsDelete = { fg = "#FF5555" }
          hl.GitSignsChange = { fg = "#FFB86C" }

          --  -- Float
          --  hl.FloatBorder = { bg   = palette.none }
          --  hl.FloatTitle  = { bg   = palette.none, bold = true      }
          --  hl.NormalFloat = { link = "Normal"     }
          --
          --  -- Blink
          -- hl.BlinkCmpMenu = { link = "FloatBorder"}
          --  hl.BlinkCmpDocBorder = {bg = "#000000"}
          --  hl.BlinkCmpDoc = {bg = "#000000"}
          --
          --  hl.CurSearch  = { link = "IncSearch" }
          --  hl.FlashMatch = { link = "Search"    }
          --  hl.FlashLabel = { bg = "#db4b4b", fg = "#eeeeee", bold = true }
        end,
      }
      -- vim.cmd.colorscheme 'everforest'  -- Commented out since Dracula is primary
    end,
  },
}
