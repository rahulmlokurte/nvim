-- Status line
return {
  -- https://github.com/nvim-lualine/lualine.nvim
  'nvim-lualine/lualine.nvim',
  dependencies = {
    -- https://github.com/nvim-tree/nvim-web-devicons
    'nvim-tree/nvim-web-devicons', -- fancy icons
    -- https://github.com/linrongbin16/lsp-progress.nvim
    'linrongbin16/lsp-progress.nvim', -- LSP loading progress
  },
  opts = {
    options = {
      -- For more themes, see https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md
      theme = 'tokyonight-night', -- "auto, tokyonight, catppuccin, codedark, nord"
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_c = {
        {
          -- Customize the filename part of lualine to be parent/filename
          'filename',
          file_status = true, -- Displays file status (readonly status, modified status)
          newfile_status = false, -- Display new file status (new file means no write after created)
          path = 4, -- 0: Just the filename
          -- 1: Relative path
          -- 2: Absolute path
          -- 3: Absolute path, with tilde as the home directory
          -- 4: Filename and parent dir, with tilde as the home directory
          symbols = {
            modified = '[+]', -- Text to show when the file is modified.
            readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
          },
        },
      },
      lualine_x = {
        function()
          local clients = vim.lsp.get_clients()
          if next(clients) == nil then
            return 'No LSP'
          end
          local client_names = {}
          for _, client in pairs(clients) do
            table.insert(client_names, client.name)
          end
          return table.concat(client_names, ', ')
        end,
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
  },
}
