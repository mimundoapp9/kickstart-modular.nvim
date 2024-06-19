return {
  'catppuccin/nvim',
  name = 'catppuccin',
  config = function()
    require('catppuccin').setup {
      flavor = 'mocha',
      no_italic = false,
      no_bold = false,
      integrations = {
        gitsigns = true,
        nvimtree = true,
        telescope = {
          enabled = true,
          style = 'nvchad',
        },
        coc_nvim = true,
        treesitter = true,
      },
    }
    vim.cmd.colorscheme 'catppuccin'
  end,
}
