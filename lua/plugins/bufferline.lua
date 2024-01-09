return function()
   local bufferline = require('bufferline')
   require('bufferline').setup {
      options = {
         show_buffer_icons = false,
         show_buffer_close_icons = false,
         truncate_names = false,
         style_preset = bufferline.style_preset.no_italic,
         show_tab_indicators = false,
         separator_style = { '', '' },
         modified_icon = '[+]',
         left_trunc_marker = '..',
         right_trunc_marker = '..',
      }
   }
end
