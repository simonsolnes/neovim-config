return {
   config = function()
      require('treesj').setup {
         use_default_keymaps = false,
         max_join_length = 512,
      }
   end
}
