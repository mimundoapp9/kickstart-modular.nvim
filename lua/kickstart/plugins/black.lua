return {
  {
    'psf/black',
    branch = 'stable',
    config = function()
      -- Configurar autocmd para ejecutar black al guardar archivos Python
      vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*.py',
        callback = function()
          vim.cmd 'Black'
        end,
      })
    end,
  },
}
