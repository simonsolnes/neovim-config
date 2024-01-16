require('option')
require('plugins')
require('autocommand')
require('usercommand')
require('keymap')
require('lsp')

-- todo
-- - replace hop with leap
-- - surround
-- - overseer
-- - learn treesitter text objects
-- - commenting library that works with jsx
-- configure noice
-- - llms
-- - bootstrap
--
-- https://github.com/JoosepAlviste/nvim-ts-context-commentstring
--
-- fix todo.nvim
-- add code spelling

-- https://github.com/Bekaboo/dropbar.nvim#installation

-- overseer run a file on save
-- https://github.com/Jezda1337/nvim-html-css
--
-- Show 'recording' in lualine
if vim.g.neovide then
   vim.opt.guifont = "SFMono Nerd Font:20"
end

-- You can add this in your init.lua
-- this should be executed before setting the colorscheme
local function hide_semantic_highlights()
   for _, group in ipairs(vim.fn.getcompletion('@lsp', 'highlight')) do
      vim.api.nvim_set_hl(0, group, {})
   end
end

vim.api.nvim_create_autocmd('ColorScheme', {
   desc = 'Clear LSP highlight groups',
   callback = hide_semantic_highlights,
})
--- #Formatting:
-- Start using
-- https://github.com/stevearc/conform.nvim
--
-- https://github.com/stevearc/aerial.nvim
-- https://github.com/folke/noice.nvim

--[[
Plugins to research more:
https://github.com/stevearc/aerial.nvim/blob/master/README.md
https://github.com/willothy/nvim-cokeline
https://github.com/folke/trouble.nvim
https://github.com/tummetott/unimpaired.nvim

Cool plugins that needs to be tried
https://github.com/sindrets/diffview.nvim
https://github.com/Wansmer/binary-swap.nvim
https://github.com/dgagn/diagflow.nvim
https://github.com/pmizio/typescript-tools.nvim
https://github.com/nvim-telescope/telescope-frecency.nvim
https://github.com/ghostbuster91/nvim-next#diagnostics
https://github.com/pwntester/octo.nvim
https://github.com/stevearc/overseer.nvim
https://github.com/nvim-neotest/neotest
https://github.com/kevinhwang91/nvim-bqf
https://github.com/chentoast/marks.nvim

Maybe:
https://github.com/kevinhwang91/nvim-hlslens

Theming:
https://alpha2phi.medium.com/neovim-for-beginners-color-scheme-e880762c6cc6

Config  references:
- [ ] https://github.com/NvChad/tinyvim
]]
