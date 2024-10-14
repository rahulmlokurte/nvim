return {
  'mfussenegger/nvim-jdtls',
  keys = {
    { '<leader>jc', '<cmd>JdtCompile<cr>', desc = 'Java Compile' },
    { '<leader>jr', '<cmd>JdtUpdateDebugConfig<cr>', desc = 'Java Debug' },
    { '<leader>jt', ":lua require'jdtls'.test_nearest_method()<CR>", silent = true, desc = 'Run nearest test' },
    { '<leader>jf', ":lua require'jdtls'.test_class()<CR>", silent = true, desc = 'Run File test' },
  },
  config = function()
    local jdtls = require 'jdtls'
    jdtls.setup_dap { hotcodereplace = 'auto' }
  end,
}
