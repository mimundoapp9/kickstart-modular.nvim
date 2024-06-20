return {
  'folke/todo-comments.nvim',
  name = 'todo-comments',
  dependencies = 'nvim-lua/plenary.nvim',
  keys = {
    { '<leader>st', ':TodoTelescope<CR>', desc = '[S]earch [T]ODO marks' },
  },
  opts = {},
}
