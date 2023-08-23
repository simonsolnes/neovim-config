vim.api.nvim_create_autocmd("BufWritePre", {
	--pattern = { "*.lua", "*.py},
	callback = function()
		vim.lsp.buf.format()
	end
})



local function parent_of(dir)
	return dir:match("(.*)/")
end



local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Swift
require('lspconfig').sourcekit.setup({
	cmd = { '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp' }
})

-- Lua
require('lspconfig').lua_ls.setup({})
-- Typescript
require("lspconfig").tsserver.setup({
	capabilities = capabilities,
	on_attach = function(client)
		client.resolved_capabilities.document_formatting = false
	end,
})

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
	capabilities = capabilities,

	settings = {
		formatCommand = { "black" },
		pylsp = {
			plugins = {
				flake8 = { enabled = true },
				pylsp_mypy = {
					enabled = true,
					overrides = { "--python-executable", py_path, true },
				},
				autopep8 = { enabled = false },
				yapf = { enabled = false },
				pylint = { enabled = false, executable = "pylint" },
				jedi = { enabled = true, environment = py_path },
			},
		},
	}
})

-- require("null-ls").setup({
-- 	sources = {
-- 		require("null-ls").builtins.formatting.shfmt, -- shell script formatting
-- 	},
-- })

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
