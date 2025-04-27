require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

map({ "n" }, "<leader>k", function()
  vim.diagnostic.open_float()
end, { desc = "open floating diagnostics" })

map({ "n" }, "<A-z>", function()
  vim.opt.wrap = not vim.opt.wrap:get()
end, { desc = "toggle line wrap" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
