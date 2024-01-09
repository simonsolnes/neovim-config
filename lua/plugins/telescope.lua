return function()
   require('telescope').setup({
      defaults = {
         sorting_strategy = "ascending",
         layout_config = {
            prompt_position = "top"
         }
      },
   })

   -- Enable telescope fzf native, if installed
   pcall(require('telescope').load_extension, 'fzf')
end
