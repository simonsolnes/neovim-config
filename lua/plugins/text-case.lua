return {
   config = function()
      require('textcase').setup({})
      require('telescope').load_extension('textcase')
   end,
}
