return {
   dependencies = {
      {
         'https://github.com/williamboman/mason-lspconfig.nvim',
         dependencies = {
            {
               'https://github.com/williamboman/mason.nvim',

               ensure_installed = {
                  'clang-format',
                  'isort',
                  'lua-language-server',
                  'markdownlint',
                  'mdformat',
                  'pyright',
                  'python-lsp-server',
                  'stylua',
                  'typescript-language-server',
                  'actionlint',
               },
            }
         },
         opts = {
            automatic_installation = true,
         }
      },
      {
         'https://github.com/jay-babu/mason-null-ls.nvim',
         cmd = { 'NullLsInstall', 'NullLsUninstall' },
         opts = {
            ensure_installed = {
               'stylua',
               'markdownlint',
               'mdformat',
               'cpplint',
               'clang_format',
            },
         },
      },
      {
         'https://github.com/folke/neodev.nvim',
         config = true
      }
   }
}
