-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  -- NOTE: Yes, you can install new plugins here!
  'mfussenegger/nvim-dap',
  -- NOTE: And you can specify dependencies as well
  dependencies = {
    -- Creates a beautiful debugger UI
    'rcarriga/nvim-dap-ui',

    -- Required dependency for nvim-dap-ui
    'nvim-neotest/nvim-nio',

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    'leoluz/nvim-dap-go', -- Go debugger
    {
      'mfussenegger/nvim-dap-python',
      ft = 'python',
    }, -- Python debugger

    -- Catppuccin for custom highlights
    { 'catppuccin/nvim', as = 'catppuccin' },

    {
      'theHamsta/nvim-dap-virtual-text',
      config = function()
        require('nvim-dap-virtual-text').setup()
      end,
    },
  },
  keys = function(_, keys)
    local dap = require 'dap'
    local dapui = require 'dapui'
    return {
      -- Basic debugging keymaps, feel free to change to your liking!
      { '<F5>', dap.continue, desc = 'Debug: Start/Continue' },
      { '<F1>', dap.step_into, desc = 'Debug: Step Into' },
      { '<F2>', dap.step_over, desc = 'Debug: Step Over' },
      { '<F3>', dap.step_out, desc = 'Debug: Step Out' },
      { '<leader>b', dap.toggle_breakpoint, desc = 'Debug: Toggle Breakpoint' },
      {
        '<leader>B',
        function()
          dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
        end,
        desc = 'Debug: Set Breakpoint',
      },
      -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
      { '<F7>', dapui.toggle, desc = 'Debug: See last session result.' },
      { '<leader>dw', ":lua require'dap.ui.widgets'.hover()<CR>", silent = true, desc = 'Debug Widget Hover' },
      { '<leader>df', ":lua require'dap.ui.widgets'.centered_float(require'dap.ui.widgets'.scopes)<CR>", silent = true, desc = 'Debug Widget Scopes' },
      { '<leader>dr', ":lua require'dapui'.open({reset = true})<CR>", silent = true, desc = 'Reset Dapui' },
      { '<leader>drc', ":lua require'dap'.repl.clear()", silent = true, desc = 'Clear Dapui Repl' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local catppuccin = require('catppuccin.palettes').get_palette

    -- Catppuccin palette colors
    local colors = catppuccin()

    dap.configurations.java = {
      {
        type = 'java',
        name = 'Integration',
        request = 'launch',
        main = '',
        console = 'internalConsole',
        args = '${command:SpecifyProgramArgs}',
        vmArgs = '-Dspring.profiles.active=integration',
      },
      {
        type = 'java',
        name = 'local',
        request = 'launch',
        main = '',
        console = 'internalConsole',
        args = '${command:SpecifyProgramArgs}',
        vmArgs = '-Dspring.profiles.active=local',
      },
      {
        type = 'java',
        name = 'test',
        request = 'launch',
        main = '',
        console = 'internalConsole',
        args = '${command:SpecifyProgramArgs}',
        vmArgs = '-Dspring.profiles.active=test',
      },
    }

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        'delve',
        'debugpy',
      },
    }

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = '⏪',
          run_last = '🔁',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
      layouts = {
        {
          elements = {
            { id = 'scopes', size = 0.3 },
            { id = 'breakpoints', size = 0.3 },
            { id = 'stacks', size = 0.2 },
            { id = 'watches', size = 0.2 },
          },
          size = 40,
          position = 'left',
        },
        {
          elements = {
            { id = 'repl', size = 0.5 },
            { id = 'console', size = 0.5 },
          },
          size = 10,
          position = 'bottom',
        },
      },
      floating = {
        border = 'rounded',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
    }

    -- Customize DAP UI highlights using Catppuccin palette
    vim.api.nvim_set_hl(0, 'DapUIVariable', { fg = colors.lavender })
    vim.api.nvim_set_hl(0, 'DapUIScope', { fg = colors.pink })
    vim.api.nvim_set_hl(0, 'DapUIType', { fg = colors.green })
    vim.api.nvim_set_hl(0, 'DapUIValue', { fg = colors.flamingo })
    vim.api.nvim_set_hl(0, 'DapUIBreakpointsCurrentLine', { fg = colors.yellow, bold = true })
    vim.api.nvim_set_hl(0, 'DapUIBreakpointsPath', { fg = colors.teal })
    vim.api.nvim_set_hl(0, 'DapUIWatchesValue', { fg = colors.red, bold = true })
    vim.api.nvim_set_hl(0, 'DapUIFrameName', { fg = colors.blue, bold = true })
    vim.api.nvim_set_hl(0, 'DapUIBreakpointsInfo', { fg = colors.cyan })
    vim.api.nvim_set_hl(0, 'DapUIStoppedThread', { fg = colors.orange, bold = true })
    vim.api.nvim_set_hl(0, 'DapUIDecoration', { fg = colors.sapphire })
    vim.api.nvim_set_hl(0, 'DapUILineNumber', { fg = colors.mauve })
    vim.api.nvim_set_hl(0, 'DapUIFloatBorder', { fg = colors.surface0, bg = colors.base })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
    require('dap-python').setup '~/.pyenv/versions/3.12.1/bin/python'
  end,
}
