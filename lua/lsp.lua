vim.api.nvim_create_autocmd("BufWritePre", {
	--pattern = { "*.lua", "*.py},
	callback = function()
		vim.lsp.buf.format()
	end
})



local function parent_of(dir)
	return dir:match("(.*)/")
end



--local capabilities = vim.lsp.protocol.make_client_capabilities()
--capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Swift
require('lspconfig').sourcekit.setup({
	cmd = { '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp' }
})

-- Lua
require('lspconfig').lua_ls.setup({})

-- Python
local venv_path = os.getenv('VIRTUAL_ENV')
local py_path = nil
-- decide which python executable to use for mypy
if venv_path ~= nil then
	py_path = venv_path .. "/bin/python3"
else
	py_path = vim.g.python3_host_prog
end
require('lspconfig').pylsp.setup({
	settings = {
		pylsp = {
			plugins = {
				black = { enabled = true },
				flake8 = { enabled = true },
				pylsp_mypy = {
					enabled = true,
					overrides = { "--python-executable", py_path, true },
				},
				-- auto-completion options
				jedi_completion = { fuzzy = false },
				-- import sorting

				pyls_isort = { enabled = false },



				autopep8 = { enabled = false },
				yapf = { enabled = false },
				-- linter options
				--pylint = { enabled = false, executable = "pylint" },
				pyflakes = { enabled = false },
				pycodestyle = { enabled = false },
				jedi = { enabled = false },
				mccabe = { enabled = false },
				preload = { enabled = false },
				pydocstyle = { enabled = false },
				rope_autoimport = { enabled = false },
				rope_completion = { enabled = false },
			},
		},
	}
})

local lsp_keymap = require('keymap').lsp_keymap

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('UserLspConfig', {}),
	callback = function(ev)
		-- Enable completion triggered by <c-x><c-o>
		vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
		lsp_keymap(ev.buf)
		vim.api.nvim_buf_create_user_command(ev.buf, 'Format', function(_)
			vim.lsp.buf.format()
		end, { desc = 'Format current buffer with LSP' })
	end,
})
