return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  after = "catppuccin",
  keys = {
    { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
    { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
  },
  config = function()
    local mocha = require("catppuccin.palettes").get_palette "mocha"
    require("bufferline").setup({
      highlights = require("catppuccin.groups.integrations.bufferline").get(
        {
          styles = { "italic", "bold" },
          custom = {
            all = {
              fill = { bg = "#1e1e2e" },
            },
            mocha = {
              background = { fg = mocha.text },
            },
          },
        }
      )
    })
  end
}
