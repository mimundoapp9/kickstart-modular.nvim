-- NOTE: Plugins can specify dependencies.
--
-- The dependencies are proper plugin specifications as well - anything
-- you do for a plugin at the top level, you can do for a dependency.
--
-- Use the `dependencies` key to specify the dependencies of a particular plugin

return {
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-telescope/telescope-file-browser.nvim' },
      { 'andrew-george/telescope-themes' },
      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        -- defaults = {
        --   mappings = {
        --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
        --   },
        -- },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'themes')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
      vim.keymap.set('n', '<leader>jh', builtin.oldfiles, { desc = '[ ] Oldfiles' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>sf', function()
        -- local current_file = vim.fn.expand '%:p' -- Obtiene la ruta completa del archivo actual
        local file_name = vim.fn.expand '%:t:r' -- Obtiene el nombre del archivo actual
        local file_ext = vim.fn.expand '%:e' -- Obtiene la extensión del archivo actual

        -- Reemplaza los guiones bajos por puntos en el nombre del archivo
        local modified_name = file_name:gsub('_', '.')
        local regex_name = '["\']' .. modified_name .. '["\']'
        -- Define el directorio de búsqueda y los argumentos adicionales basados en la extensión del archivo
        local search_dirs = { '~/Datos/odoo17/', vim.fn.getcwd() }
        local additional_args = function()
          return {}
        end

        if file_ext == 'py' then
          additional_args = function()
            return { '--glob', '*.py' }
          end
        elseif file_ext == 'xml' then
          additional_args = function()
            return { '--glob', '*.xml' }
          end
        end

        -- Ejecuta Telescope live_grep con los parámetros configurados
        require('telescope.builtin').live_grep {
          prompt_title = 'Live Grep in Current File',
          search_dirs = search_dirs,
          default_text = regex_name,
          file_ignore_patterns = { '%.po$', '%.pot$' },
          cwd = vim.fn.getcwd(),
          use_regex = true,
          additional_args = additional_args,
        }
      end, { desc = '[S]earch [F]ile: Live Grep in Current File' })
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>op', function()
        require('telescope.builtin').live_grep {
          prompt_title = 'Live Grep in Odoo 17',
          search_dirs = { '~/Datos/odoo17/', vim.fn.getcwd() },
          file_ignore_patterns = { '%.po$', '%.pot$' },
          cwd = vim.fn.getcwd(),
          additional_args = function()
            return { '--glob', '*.py' }
          end,
        }
      end, { desc = '[S]earch [/] in Odoo 17 Python Files' })
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>or', function()
        require('telescope.builtin').live_grep {
          prompt_title = 'Buscar tags Odoo 17',
          search_dirs = { '~/Datos/odoo17/', vim.fn.getcwd() },
          cwd = vim.fn.getcwd(),
          default_text = '<record id="',
          additional_args = function()
            return { '--glob=*.xml' }
          end,
          --vimgrep_arguments = {
          --'rg',
          --            '--color=never',
          --            '--no-heading',
          --            '--with-filename',
          --            '--line-number',
          --'--column',
          --            '--smart-case',
          --'-e',
          --'<record[^>]*>',
          --},
        }
      end, { desc = '[O]doo [R]ecords in XML Files' })

      --ot
      vim.keymap.set('n', '<leader>ot', function()
        require('telescope.builtin').live_grep {
          prompt_title = 'Live Grep in Odoo 17',
          search_dirs = { '~/Datos/odoo17/', vim.fn.getcwd() },
          file_ignore_patterns = { '%.py$', '%.xml$' },
          cwd = vim.fn.getcwd(),
        }
      end, { desc = '[S]earch [/] in Odoo 17 XML Files' })
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>ox', function()
        require('telescope.builtin').live_grep {
          prompt_title = 'Live Grep in Odoo 17',
          search_dirs = { '~/Datos/odoo17/', vim.fn.getcwd() },
          file_ignore_patterns = { '%.po$', '%.pot$' },
          cwd = vim.fn.getcwd(),
          additional_args = function()
            return { '--glob', '*.xml' }
          end,
        }
      end, { desc = '[S]earch [/] in Odoo 17 XML Files' })
      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>oo', function()
        builtin.live_grep {
          prompt_title = 'Live Grep in Odoo 17',
          search_dirs = { '~/Datos/odoo17/', vim.fn.getcwd() },
          file_ignore_patterns = { '%.po$', '%.pot$' },
          cwd = vim.fn.getcwd(),
        }
      end, { desc = '[S]earch [/] in Odoo 17 traslation Files' })

      local function get_visual_selection()
        vim.cmd 'noau normal! "vy"' -- yanks the selected text into the "v register
        local text = vim.fn.getreg 'v'
        vim.fn.setreg('v', {}) -- clear the register v
        return vim.fn.escape(text, '\\/.$^~[]')
      end

      -- Mapeo de teclas para buscar la palabra seleccionada en el directorio `~/Datos/odoo17/`
      vim.keymap.set('v', '<leader>os', function()
        local search_word = get_visual_selection()
        builtin.grep_string {
          prompt_title = 'Grep Selected Word in Odoo 17',
          search = search_word,
          search_dirs = { '~/Datos/odoo17/', vim.fn.getcwd() },
          file_ignore_patterns = { '%.po$', '%.pot$' },
          cwd = vim.fn.getcwd(),
        }
      end, { desc = '[S]earch [G]rep Selected Word in Odoo 17 Files' })
      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>of', function()
        builtin.find_files { cwd = '~/Datos/odoo17/', file_ignore_patterns = { '%.po$', '%.pot$' } }
      end, { desc = '[O]doo [F]iles' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>gs', function()
        builtin.git_status {}
      end, { desc = '[G]it [S]tatus' })
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
