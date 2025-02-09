-- Set up lspconfig.
local lspconfig = require("lspconfig")
local capabilities = require('cmp_nvim_lsp').default_capabilities()
lspconfig.nixd.setup {
  capabilities = capabilities
}
lspconfig.clangd.setup {
  capabilities = capabilities
}
lspconfig.lua_ls.setup {
  capabilities = capabilities
}
