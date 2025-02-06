return {
  'preservim/vimux',
  keys = {
    { '<leader>vp', '<cmd>VimuxPromptCommand<cr>', desc = 'Run command from vim to tmux' },
    { '<leader>vl', '<cmd>VimuxRunLastCommand<cr>', desc = 'Run last command from vim to tmux' },
    { '<leader>vi', '<cmd>VimuxInspectRunner<cr>', desc = 'Copy mode from vim to tmux' },
    { '<leader>vz', '<cmd>VimuxZoomRunner<cr>', desc = 'Zoom from vim to tmux' },
  },
}
