---@diagnostic disable: missing-fields

return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
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
      vim.cmd.colorscheme 'catppuccin'
    end,
  },
  {
    'neanias/everforest-nvim',
    version = false,
    priority = 1000,
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
    end,
  },
}
