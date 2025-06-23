return {
  {
    'mrcjkb/rustaceanvim',
    version = '^5', -- Recommended
    lazy = false, -- This plugin is already lazy
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      -- Use Mason's standard path structure
      local mason_path = vim.fn.stdpath('data') .. '/mason'
      local codelldb_root = mason_path .. '/packages/codelldb'
      local extension_path = codelldb_root .. '/extension/'
      local codelldb_path = extension_path .. 'adapter/codelldb'
      local liblldb_path = extension_path .. 'lldb/lib/liblldb'
      
      -- Check for different library extensions (macOS uses .dylib, Linux uses .so)
      if vim.fn.has('mac') == 1 then
        liblldb_path = liblldb_path .. '.dylib'
      else
        liblldb_path = liblldb_path .. '.so'
      end

      -- Check if codelldb is installed and executable
      if vim.fn.executable(codelldb_path) == 0 then
        vim.notify('codelldb not found. Install it with :MasonInstall codelldb', vim.log.levels.WARN)
        return
      end

      -- Check if liblldb exists
      if vim.fn.filereadable(liblldb_path) == 0 then
        vim.notify('liblldb not found at: ' .. liblldb_path, vim.log.levels.WARN)
        -- Try alternative locations
        local alt_paths = {
          extension_path .. 'lldb/lib/liblldb.so',
          extension_path .. 'lldb/lib/liblldb.dylib',
        }
        for _, alt_path in ipairs(alt_paths) do
          if vim.fn.filereadable(alt_path) == 1 then
            liblldb_path = alt_path
            vim.notify('Found liblldb at: ' .. liblldb_path, vim.log.levels.INFO)
            break
          end
        end
      end

      -- Load rustaceanvim config
      local cfg_ok, cfg = pcall(require, 'rustaceanvim.config')
      if not cfg_ok then
        vim.notify('rustaceanvim.config not available', vim.log.levels.WARN)
        return
      end

      -- Configure rustaceanvim
      vim.g.rustaceanvim = {
        dap = {
          adapter = cfg.get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
      
      vim.notify('rustaceanvim configured successfully with codelldb', vim.log.levels.INFO)
    end,
  },
}
