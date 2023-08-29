return {
   'https://github.com/akinsho/bufferline.nvim',
   dependencies = {
      'https://github.com/nvim-tree/nvim-web-devicons',
   },
   config = function()
      local bufferline = require('bufferline')
      bufferline.setup({
         options = {
            name_formatter = function(buf)
               local Path = require('plenary.path')
               local dir = vim.fn.getcwd()
               return Path:new(buf.path):make_relative(dir)
            end,
            show_buffer_icons = false,
            show_buffer_close_icons = false,
            truncate_names = false,
            style_preset = bufferline.style_preset.no_italic,
            show_tab_indicators = false,
            indicator = {
               style = 'none',
            },
            separator_style = { '', '' },
            offsets = {
               {
                  filetype = "neo-tree",
                  text = "File Explorer",
                  highlight = "Directory",
                  separator = true -- use a "true" to enable the default, or set your own character
               }
            },
            highlights = {
               buffer_visible = {
                  fg = '#ff0000',
                  bg = '#ffffff',
                  italic = true,
               },
            },
         },
      })
   end
}
