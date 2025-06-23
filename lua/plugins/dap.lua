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

    -- Creates AutoCompletion for dap expressions
    'rcarriga/cmp-dap',

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

    {
      'theHamsta/nvim-dap-virtual-text',
      config = function()
        require('nvim-dap-virtual-text').setup()
      end,
    },
    {
      'microsoft/vscode-js-debug',
      version = '1.x',
      build = 'npm i && npm run compile vsDebugServerBundle && mv dist out',
    },
    { 'mxsdev/nvim-dap-vscode-js' },
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
      { '<leader>drc', ":lua require'dap'.repl.clear()<CR>", silent = true, desc = 'Clear Dapui Repl' },
      unpack(keys),
    }
  end,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

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

    -- Dap UI setup with Enhanced Icons
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      controls = {
        element = 'repl',
        enabled = true,
        icons = {
          disconnect = '■',     -- Stop square
          pause = '⏸',          -- Pause symbol
          play = '▶',           -- Play triangle
          run_last = '↻',       -- Refresh/replay
          step_back = '◀',      -- Step back
          step_into = '▼',      -- Step into (down arrow)
          step_out = '▲',       -- Step out (up arrow)
          step_over = '▶',      -- Step over (next)
          terminate = '■',      -- Terminate (stop)
        },
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = 'single',
        mappings = {
          close = { 'q', '<Esc>' },
        },
      },
      force_buffers = true,
      icons = {
        collapsed = '▶',        -- Right-pointing triangle
        current_frame = '👉',    -- Pointing finger for current frame
        expanded = '▼',         -- Down-pointing triangle
      },
      layouts = {
        {
          elements = {
            {
              id = 'scopes',
              size = 0.50,
            },
            {
              id = 'stacks',
              size = 0.30,
            },
            {
              id = 'watches',
              size = 0.10,
            },
            {
              id = 'breakpoints',
              size = 0.10,
            },
          },
          size = 40,
          position = 'left', -- Can be "left" or "right"
        },
        {
          elements = {
            'repl',
            'console',
          },
          size = 10,
          position = 'bottom', -- Can be "bottom" or "top"
        },
      },
      mappings = {
        edit = 'e',
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        repl = 'r',
        toggle = 't',
      },
      render = {
        indent = 1,
        max_value_lines = 100,
      },
    }

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    -- Enhanced Sign Definitions with Better Icons and Colors
    vim.api.nvim_set_hl(0, 'DapStoppedHl', { fg = '#98BB6C', bg = '#2A2A2A', bold = true })
    vim.api.nvim_set_hl(0, 'DapStoppedLineHl', { bg = '#204028', bold = true })
    vim.api.nvim_set_hl(0, 'DapBreakpointHl', { fg = '#FF6B6B', bold = true })
    vim.api.nvim_set_hl(0, 'DapBreakpointConditionHl', { fg = '#FFD93D', bold = true })
    vim.api.nvim_set_hl(0, 'DapBreakpointRejectedHl', { fg = '#FF4757', bold = true })
    vim.api.nvim_set_hl(0, 'DapLogPointHl', { fg = '#74B9FF', bold = true })

    -- Enhanced breakpoint and debugging state icons
    vim.fn.sign_define('DapStopped', { 
      text = '🔍', 
      texthl = 'DapStoppedHl', 
      linehl = 'DapStoppedLineHl', 
      numhl = '' 
    })
    vim.fn.sign_define('DapBreakpoint', { 
      text = '🔴', 
      texthl = 'DapBreakpointHl', 
      linehl = '', 
      numhl = '' 
    })
    vim.fn.sign_define('DapBreakpointCondition', { 
      text = '🟡', 
      texthl = 'DapBreakpointConditionHl', 
      linehl = '', 
      numhl = '' 
    })
    vim.fn.sign_define('DapBreakpointRejected', { 
      text = '❌', 
      texthl = 'DapBreakpointRejectedHl', 
      linehl = '', 
      numhl = '' 
    })
    vim.fn.sign_define('DapLogPoint', { 
      text = '📝', 
      texthl = 'DapLogPointHl', 
      linehl = '', 
      numhl = '' 
    })

    -- AutoCompletion for DAP UI
    require('cmp').setup {
      enabled = function()
        return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require('cmp_dap').is_dap_buffer()
      end,
    }

    require('cmp').setup.filetype({ 'dap-repl', 'dapui_watches', 'dapui_hover' }, {
      sources = {
        { name = 'dap' },
      },
    })

    -- Install golang specific config
    require('dap-go').setup {
      delve = {
        -- On Windows delve must be run attached or it crashes.
        -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
        detached = vim.fn.has 'win32' == 0,
      },
    }
    require('dap-python').setup '~/.pyenv/versions/3.12.1/bin/python'

    require('dap-vscode-js').setup {
      -- node_path = "node", -- Path of node executable. Defaults to $NODE_PATH, and then "node"
      debugger_path = vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug', -- Path to vscode-js-debug installation.
      -- debugger_cmd = { "js-debug-adapter" }, -- Command to use to launch the debug server. Takes precedence over `node_path` and `debugger_path`.
      adapters = { 'pwa-node', 'pwa-chrome', 'pwa-msedge', 'node-terminal', 'pwa-extensionHost' }, -- which adapters to register in nvim-dap
      -- log_file_path = "(stdpath cache)/dap_vscode_js.log" -- Path for file logging
      -- log_file_level = false -- Logging level for output to file. Set to false to disable file logging.
      -- log_console_level = vim.log.levels.ERROR -- Logging level for output to console. Set to false to disable console output.
    }

    for _, language in pairs { 'typescript', 'javascript' } do
      require('dap').configurations[language] = {
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
        },
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
        },
      }
    end
  end,
}
