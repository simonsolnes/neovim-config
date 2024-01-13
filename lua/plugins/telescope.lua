return {
   config = function()
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
   end,
   fzf_dependency = {
      'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = vim.fn.executable('make') == 1
   },
}
