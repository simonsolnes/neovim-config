return {
   config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')
      require('luasnip.loaders.from_vscode').lazy_load()
      luasnip.config.setup {}

      local kind_icons = {
         Text = "",
         Method = "󰆧",
         Function = "󰊕",
         Constructor = "",
         Field = "󰇽",
         Variable = "󰂡",
         Class = "󰠱",
         Interface = "",
         Module = "",
         Property = "󰜢",
         Unit = "",
         Value = "󰎠",
         Enum = "",
         Keyword = "󰌋",
         Snippet = "",
         Color = "󰏘",
         File = "󰈙",
         Reference = "",
         Folder = "󰉋",
         EnumMember = "",
         Constant = "󰏿",
         Struct = "",
         Event = "",
         Operator = "󰆕",
         TypeParameter = "󰅲",
      }

      cmp.setup {
         snippet = {
            expand = function(args)
               luasnip.lsp_expand(args.body)
            end,
         },
         mapping = cmp.mapping.preset.insert {
         },
         sources = {
            { name = 'nvim_lua' },
            { name = 'nvim_lsp_signature_help' },
            { name = 'nvim_lsp' },
            { name = 'path' },
            { name = 'luasnip' },
            { name = 'buffer' },
         },
         formatting = {
            format = function(entry, vim_item)
               -- Kind icons
               vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
               -- Source
               vim_item.menu = ({
                  buffer = "[Buffer]",
                  nvim_lsp = "[LSP]",
                  path = "[path]",
                  luasnip = "[LuaSnip]",
                  nvim_lsp_signature_help = "[signature]",
                  nvim_lua = "[Lua]",
                  latex_symbols = "[LaTeX]",
               })[entry.source.name]
               return vim_item
            end
         },
      }
   end,
   special_cr_mapping = function()
      local cmp = require('cmp')
      return cmp.mapping({
         i = function(fallback)
            if cmp.visible() and cmp.get_active_entry() then
               cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
            else
               fallback()
            end
         end,
         s = cmp.mapping.confirm({ select = true }),
         c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
      })
   end
}
