---@diagnostic disable: missing-fields

return {
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'everforest',
    },
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'mocha',
        transparent_background = false,
        custom_highlights = function(colors)
          return {
            -- Normal = { bg = colors.crust },
            -- Blink
            BlinkCmpMenu = { bg = colors.mantle },
            BlinkCmpMenuSelection = { fg = colors.green },
            BlinkCmpDoc = { bg = colors.surface0 },
            BlinkCmpScrollBarThumb = { bg = colors.mauve },
          }
        end,
      }
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
