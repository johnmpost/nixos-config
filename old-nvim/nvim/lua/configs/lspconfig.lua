local nvlsp = require "nvchad.configs.lspconfig"
local lspconfig = require "lspconfig"

nvlsp.defaults()

local servers = { "html", "cssls", "ts_ls" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

lspconfig.efm.setup {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  init_options = { documentFormatting = false },
  filetypes = { "ledger" },
  settings = {
    rootMarkers = { ".git/" },
    languages = {
      ledger = {
        {
          lintCommand = "hledger check --strict -f - 2>&1",
          lintStdin = true,
          lintFormats = {
            "%Ehledger: Error: %f:%l-%e:",
            "%Ehledger: Error: %f:%l:%c:",
            "%Ehledger: Error: %f:%l:",
            "%C%.%#|%.%#",
            "%C%^%m%#",
          },
          lintIgnoreExitCode = true,
        },
      },
    },
  },
}
