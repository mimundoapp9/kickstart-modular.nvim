return {
  -- Añade dashboard-nvim como un plugin
  {
    'nvimdev/dashboard-nvim',
    config = function()
      -- Aquí puedes configurar dashboard-nvim
      require('dashboard').setup {
        -- Ejemplo de configuración
        theme = 'doom',
        config = {
          header = {
            [[  _         _   _                     _            _             ]],
            [[ | |    ___| |_( )___  __ _  ___   __| | ___ _ __ | | ___  _   _ ]],
            [[ | |   / _ \ __|// __|/ _` |/ _ \ / _` |/ _ \ '_ \| |/ _ \| | | |]],
            [[ | |__|  __/ |_  \__ \ (_| | (_) | (_| |  __/ |_) | | (_) | |_| |]],
            [[ |_____\___|\__| |___/\__, |\___/ \__,_|\___| .__/|_|\___/ \__, |]],
            [[                      |___/                 |_|            |___/ ]],
          },
          center = {
            {
              icon = ' ',
              desc = 'Recently opened files                   ',
              action = 'Telescope oldfiles',
              shortcut = 'SPC j h',
            },
            {
              icon = '  ',
              desc = 'Find  File                              ',
              action = 'Telescope find_files find_command=rg,--hidden,--files',
              shortcut = 'SPC f f',
            },
            {
              icon = '  ',
              desc = 'File Browser                            ',
              action = 'Telescope file_browser',
              shortcut = 'SPC f b',
            },
            {
              icon = '  ',
              desc = 'Find  word                              ',
              action = 'Telescope live_grep',
              shortcut = 'SPC f w',
            },
            {
              icon = '  ',
              desc = 'Open Odoo files                  ',
              action = 'Telescope',
              shortcut = 'SPC f d',
            },
          },
          footer = {}, -- puedes poner algo aquí si quieres
        },
      }
    end,
  },
}
