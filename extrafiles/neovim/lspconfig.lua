local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()

capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.ccls.setup{}
lspconfig.nixd.setup{}
lspconfig.bashls.setup{}
lspconfig.kotlin_language_server.setup{}
lspconfig.html.setup {
   capabilities = capabilities,
}
lspconfig.jsonls.setup {
   capabilities = capabilities,
}
lspconfig.cssls.setup {
   capabilities = capabilities,
}
lspconfig.eslint.setup({
   on_attach = function(client, bufnr)
      vim.api.nvim_create_autocmd("BufWritePre", {
         buffer = bufnr,
         command = "EslintFixAll",
      })
   end,
})
lspconfig.lua_ls.setup {
   on_init = function(client)
      local path = client.workspace_folders[1].name
      if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
         return
      end

      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
         workspace = {
            checkThirdParty = false,
            library = {
               vim.env.VIMRUNTIME
            }
         }
      })
   end,
   settings = {
      Lua = {}
   }
}
lspconfig.rust_analyzer.setup{
   settings = {
      ['rust-analyzer'] = {
         diagnostics = {
            enable = false;
         }
      }
   }
}

