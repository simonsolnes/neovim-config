local M = {}

local shared = {
   options = {
      icons_enabled = true,
      theme = require('theme').colorscheme,
      component_separators = '',
      section_separators = '',
      always_divide_middle = true,
   },
}
function M.single_window()
   require('lualine').setup(vim.tbl_deep_extend('error', shared, {
      tabline =
      {
         lualine_a = { {
            'filename',
            path = 1,
            shorting_target = 0,
         } },
         lualine_b = { { 'branch', icons_enabled = false } },
         lualine_c = { 'diff', 'diagnostics' },
         lualine_x = {},
         lualine_y = { {
            'buffers',
            icons_enabled = false,
            symbols = {
               modified = '+',
               alternate_file = '',
               directory = '',
            },
            use_mode_colors = false,
            max_length = 100,
         } },
         lualine_z = { 'location' }
      },
      inactive_sections = {},
      sections = {},
      winbar = {},
      inactive_winbar = {},
      extensions = {},
   }))
end

function M.multiple_windows()
   require('lualine').setup(shared)
   local winbar = {
      lualine_a = { {
         'filename',
         path = 1,
         shorting_target = 0,
      } },
      lualine_b = { 'diff' },
      lualine_c = {},
      lualine_x = { 'diagnostics', },
      lualine_y = { 'progress' },
      lualine_z = { 'location' }
   }
   require('lualine').setup({
      --[[
      tabline = {
         --lualine_a = {},
         lualine_y = { { 'branch', icons_enabled = false } },
         --lualine_c = {},
         --lualine_x = {},
         lualine_b = { {
            'buffers',
            icons_enabled = false,
            symbols = {
               modified = '+',
               alternate_file = '',
               directory = '',
            },
            use_mode_colors = false,
            max_length = 100,
         } },
         --lualine_z = {}
      },
      ]]
      inactive_sections = {},
      sections = {},
      winbar = winbar,
      inactive_winbar = winbar,
      extensions = {}
   })
   vim.opt.laststatus = 0
end

return M
