local cmp = require('cmp')
local harpoon = require('harpoon')
local gitsigns = require('gitsigns')
local comment = require('Comment.api')
local treesj = require('treesj')
local sibling_swap = require('sibling-swap')

local macros = require('macros')
local utils = require('utils')
local lua_cmd = utils.lua_cmd
local alt = utils.alt
local control = utils.control
local leader = utils.leader

local map = {
	-- https://github.com/kylechui/nvim-surround
	-- treesitter textobjs

	normal = {
		-- System
		[leader .. 'w']               = { 'Write', ':w <cr>' },
		[leader .. 'q']               = { 'Quit', ':q <cr>' },
		[leader .. 'r']               = { 'Run', "<cmd>!swift run<cr>" },

		-- Navigation
		['s']                         = { 'Jump', function() require("flash").jump() end },
		['S']                         = { 'Jump', function() require("flash").treesitter() end },

		-- Harpoon
		[leader .. 'h' .. 'a']        = { 'Harpoon add', function() harpoon:list():append() end },
		[leader .. 'h' .. 'l']        = { 'Harpoon list', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end },
		[alt('t')]                    = { 'Harpoon list', function() harpoon:list():select(1) end },
		[alt('s')]                    = { 'Harpoon list', function() harpoon:list():select(2) end },
		[alt('r')]                    = { 'Harpoon list', function() harpoon:list():select(3) end },
		[alt('a')]                    = { 'Harpoon list', function() harpoon:list():select(4) end },

		-- Replacements
		['w']                         = { 'Word', macros.spider_motion('w') },
		['e']                         = { 'End', macros.spider_motion('e') },
		['b']                         = { 'Back', macros.spider_motion('b') },

		[leader .. 'o' .. 'o']        = { 'Open', macros.open_url_under_cursor },

		-- Sidepanels
		[leader .. 'n' .. 'n']        = { 'Open filetree', function() vim.cmd.Neotree('toggle') end },
		[leader .. 'n' .. 'b']        = { 'Open buffertree', function() vim.cmd.Neotree('toggle', 'buffers') end },
		[leader .. 'n' .. 'u']        = { 'Open undotree', vim.cmd.UndotreeToggle },
		[leader .. 'n' .. 's']        = { 'Open symbols', vim.cmd.SymbolsOutline },
		[leader .. 'n' .. 'a']        = { 'Open aerial', "<cmd>AerialToggle!<CR>" },
		['<Down>']                    = { 'Open aerial', "<cmd>AerialNext<CR>" },
		['<Up>']                      = { 'Open aerial', "<cmd>AerialPrev<CR>" },

		-- Text case conversion
		[leader .. 'c' .. 's']        = { 'Snake case (lorem_ipsum)', macros.textcase_word('to_snake_case') },
		[leader .. 'c' .. 'k']        = { 'Kebab case (lorem-ipsum)', macros.textcase_word('to_dash_case') },
		[leader .. 'c' .. 'f']        = { 'Title kebab case (Lorem-Ipsum)', macros.textcase_word('to_title_dash_case') },
		[leader .. 'c' .. 'n']        = { 'Constant case (LOREM_IPSUM)', macros.textcase_word('to_constant_case') },
		[leader .. 'c' .. 'd']        = { 'Dot case (lorem.ipsum)', macros.textcase_word('to_dot_case') },
		[leader .. 'c' .. 'c']        = { 'Camel case (loremIpsum)', macros.textcase_word('to_camel_case') },
		[leader .. 'c' .. 'p']        = { 'Pascal case (LoremIpsum)', macros.textcase_word('to_pascal_case') },
		[leader .. 'c' .. 'h']        = { 'Path case (lorem/ipsum)', macros.textcase_word('to_path_case') },
		[leader .. 'c' .. 'u']        = { 'Uppercase (LOREM IPSUM)', macros.textcase_word('to_upper_case') },
		[leader .. 'c' .. 'l']        = { 'Lowercase (lorem ipsum)', macros.textcase_word('to_lower_case') },
		[leader .. 'c' .. 't']        = { 'Title case (Lorem Ipsum)', macros.textcase_word('to_title_case') },
		[leader .. 'c' .. 'r']        = { 'Phrase case (Lorem ipsum)', macros.textcase_word('to_phrase_case') },

		-- Comment
		[leader .. 'c' .. 'o' .. 'l'] = { 'Comment', comment.call('toggle.linewise.current', 'g@$'), { expr = true } },

		-- Git
		[leader .. 'g' .. 'i' .. 't'] = { 'Git', vim.cmd.Git },
		[leader .. 'g' .. 'l' .. 'l'] = { 'Open link for line', macros.git.open_line_on_origin('n') },
		[leader .. 'g' .. 'l' .. 'r'] = { 'Open repo', macros.git.open_origin_repo },
		[leader .. 'g' .. 'b']        = { 'Git blame', function() gitsigns.blame_line { full = true } end },
		[']' .. 'h']                  = { 'Next hunk', gitsigns.next_hunk },
		['[' .. 'h']                  = { 'Previous hunk', gitsigns.prev_hunk },
		[leader .. 'g' .. 's']        = { 'Stage hunk', gitsigns.stage_hunk },
		[leader .. 'g' .. 'r']        = { 'Reset hunk', gitsigns.reset_hunk },
		[leader .. 'g' .. 'r' .. 's'] = { 'Stage buffer', gitsigns.stage_buffer },
		[leader .. 'g' .. 'h' .. 'p'] = { 'Preview hunk', gitsigns.preview_hunk },
		[leader .. 'g' .. 't']        = { 'Toggle line blame', gitsigns.toggle_current_line_blame },
		[leader .. 'g' .. 'd']        = { 'Diff', function() gitsigns.diffthis('~') end },
		[leader .. 'g' .. 'k']        = { 'Toggle deleted', gitsigns.toggle_deleted },

		-- Indentation
		['>']                         = { 'Indent right', '>>' },
		['<']                         = { 'Indent left', '<<' },

		-- Windows
		[control('k')]                = { 'Window up', control('w') .. 'k' },
		[control('j')]                = { 'Window down', control('w') .. 'j' },
		[control('h')]                = { 'Window left', control('w') .. 'h' },
		[control('l')]                = { 'Window right', control('w') .. 'l' },
		[control('w') .. 'k']         = { 'Move window up', control('w') .. 'K' },
		[control('w') .. 'j']         = { 'Move window down', control('w') .. 'J' },
		[control('w') .. 'h']         = { 'Move window left', control('w') .. 'H' },
		[control('w') .. 'l']         = { 'Move window right', control('w') .. 'L' },
		[alt('Up')]                   = { 'Resize window up', ':resize -3<cr>' },
		[alt('Down')]                 = { 'Resize window down', ':resize +3<cr>' },
		[alt('Left')]                 = { 'Resize window left', ':vertical resize -3<cr>' },
		[alt('Right')]                = { 'Resize window right', ':vertical resize +3<cr>' },

		-- Buffers
		[alt('l')]                    = { 'Next buffer', vim.cmd.bn },
		[alt('h')]                    = { 'Previous buffer', vim.cmd.bp },
		[alt('w')]                    = { 'Close buffer', ':bp<bar>sp<bar>bn<bar>bd<Enter>' },

		-- Scroll
		[control('u')]                = { 'Scroll half up', control('u') .. 'M' },
		[control('d')]                = { 'Scroll half down', control('d') .. 'M' },
		[control('b')]                = { 'Scroll up', control('b') .. 'M' },
		[control('f')]                = { 'Scroll down', control('f') .. 'M' },
		[control('e')]                = { 'Scroll down', control('e') .. control('e') .. control('e') },
		[control('y')]                = { 'Scroll up', control('y') .. control('y') .. control('y') },

		-- Telescope
		[leader .. 't' .. 'f']        = { 'Find files', function() vim.cmd.Telescope('find_files') end },
		[leader .. 't' .. 'g']        = { 'Grep', function() vim.cmd.Telescope('live_grep') end },
		[leader .. 't' .. 'r']        = { 'Resume', function() vim.cmd.Telescope('resume') end },
		[leader .. 't' .. 'o']        = { 'Old files', function() vim.cmd.Telescope('oldfiles') end },
		[leader .. 't' .. 's']        = { 'Symbols', function() vim.cmd.Telescope('lsp_dynamic_workspace_symbols') end },
		[leader .. 'u']               = { 'Buffers', function() vim.cmd.Telescope('buffers') end },

		-- LSP
		[leader .. 'x' .. 'x']        = { 'Trouble', function() vim.cmd.TroubleToggle() end },
		[leader .. 'l' .. 's']        = { 'Signature', vim.lsp.buf.signature_help },
		[leader .. 'l' .. 'i']        = { 'Import', require("lspimport").import },
		[leader .. 'l' .. 'r']        = { 'Rename', vim.lsp.buf.rename },
		[leader .. 'l' .. 'a']        = { 'Code action', vim.lsp.buf.code_action },
		[']' .. 'd']                  = { 'Next diagnostic', vim.diagnostic.goto_next },
		['[' .. 'd']                  = { 'Previous diagnostic', vim.diagnostic.goto_prev },
		['g' .. 'l']                  = { 'Diagnostic float', vim.diagnostic.open_float },
		['g' .. 'r']                  = { 'References', function() vim.cmd.Telescope('lsp_references') end },
		['g' .. 'd']                  = { 'Definition', function() vim.cmd.Telescope('lsp_definitions') end },
		['g' .. 'D']                  = { 'Declaration', vim.lsp.buf.declaration },
		['g' .. 'i']                  = { 'Implementation', vim.lsp.buf.implementation },
		['g' .. 't']                  = { 'Type definiition', vim.lsp.buf.type_definition },
		['K']                         = { 'Hover', vim.lsp.buf.hover },

		-- Tree operations
		[leader .. 's' .. 'j' .. 't'] = { 'SJ Toggle', treesj.toggle },
		[leader .. 's' .. 'j' .. 's'] = { 'SJ Split', treesj.split },
		[leader .. 's' .. 'j' .. 'j'] = { 'SJ Join', treesj.join },

		[alt('f')]                    = { 'Swap sibling left', sibling_swap.swap_with_left },
		[alt('p')]                    = { 'Swap sibling right', sibling_swap.swap_with_right },
	},
	visual_select = {
		['J']                         = { 'Move lines down', ":m'>+<cr>gv=gv" },
		['K']                         = { 'Move lines up', ":m-2<cr>gv=gv" },
		['p']                         = { 'Paste with preserve register', '"_dP' },

		['>']                         = { 'Indent right', '>gv' },
		['<']                         = { 'Indent left', '<gv' },

		[leader .. 'g' .. 'l' .. 'l'] = { 'Open link for lines', macros.git.open_line_on_origin('v') },
		['g' .. 'c' .. 'c']           = { '', function() print("hello") end },

		[leader .. 'g' .. 's']        = { 'Stage hunk', function() gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end },
		[leader .. 'g' .. 'r']        = { 'Reset hunk', function() gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end },

	},
	visual = {
		['y'] = { 'Yank and retain position', 'ygv<esc>' },
	},
	operator_pending = {
	},

	visual_and_operator_pending = {
		['s'] = { 'Jump', function() require("flash").jump() end },
		['w'] = { 'Word', macros.spider_motion('w') },
		['e'] = { 'End', macros.spider_motion('e') },
		['b'] = { 'Back', macros.spider_motion('b') },
		['i' .. 'h'] = { 'Hunk', gitsigns.select_hunk },
		['iw'] = { 'Subword', lua_cmd([[require('various-textobjs').subword('inner')]]) },
		['iW'] = { 'Word', 'iw' },
		['aw'] = { 'Subword', lua_cmd([[require('various-textobjs').subword('outer')]]) },
		['aW'] = { 'Word', 'aw' },

	},
	cmp = {
		[control('n')] = cmp.mapping.select_next_item(),
		[control('p')] = cmp.mapping.select_prev_item(),
		[control('d')] = cmp.mapping.scroll_docs(-4),
		[control('f')] = cmp.mapping.scroll_docs(4),
		['<Tab>'] = cmp.mapping.confirm({ select = true }),
		["<cr>"] = require('plugins.nvim-cmp').special_cr_mapping(),
	}

}
--[[
Very free buttons:
- C-j
- ) and ( for sentences in md etc and something else in code
- q can be another button

TODO:Start tracking frequency use of these mappings
]]

for mode, mappings in pairs(map) do
	if mode == 'cmp' then
		cmp.setup({
			mapping = cmp.mapping.preset.insert(mappings)
		})
	else
		local modeShorthand = ({
			normal = 'n',
			visual_select = 'v',
			visual = 'x',
			operator_pending = 'o',
			visual_and_operator_pending = { 'x', 'o' },
		})[mode]
		for keys, mapping in pairs(mappings) do
			local description = mapping[1]
			local action = mapping[2]
			local options = { desc = description, noremap = false, silent = true }
			local extra_options = mapping[3]
			if extra_options ~= nil then
				options = vim.tbl_deep_extend("force", options, extra_options)
			end
			vim.keymap.set(modeShorthand, keys, action, options)
		end
	end
end
