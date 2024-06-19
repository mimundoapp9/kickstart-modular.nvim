return {
  'max397574/better-escape.nvim',
  config = function()
    require('better_escape').setup {
      mapping = { 'jk', 'jj' }, -- Teclas para salir del modo de inserción
      timeout = 150, -- Tiempo de espera en milisegundos
      clear_empty_lines = false, -- No borrar líneas vacías al salir
      keys = '<Esc>', -- Tecla a simular al salir del modo de inserción
    }
  end,
}
