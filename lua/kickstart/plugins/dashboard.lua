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
            [[                               __                ]],
            [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
            [[ /'___\  / __`\ /' _ `\/\ \/\ \\/\ \ /' __` __`\  ]],
            [[/\ \__/ /\ \_\ \/\ \/\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
            [[\ \____\\ \____/\ \_\ \_\ \___/  \ \_\ \_\ \_\ \_\]],
            [[ \/____/ \/___/  \/_/\/_/\/__/    \/_/\/_/\/_/\/_/]],
            [[                                                  ]],
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
