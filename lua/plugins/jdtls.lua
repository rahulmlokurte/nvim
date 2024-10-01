return {
  'mfussenegger/nvim-jdtls',
  keys = {
    { '<leader>jc', '<cmd>JdtCompile<cr>', desc = 'Java Compile' },
    { '<leader>jr', '<cmd>JdtUpdateDebugConfig<cr>', desc = 'Java Debug' },
  },
  config = function()
    local jdtls = require 'jdtls'
    jdtls.setup_dap { hotcodereplace = 'auto' }
  end,
}
