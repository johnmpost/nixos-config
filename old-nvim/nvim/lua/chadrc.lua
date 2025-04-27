---@diagnostic disable: missing-fields
-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(
-- local test = require "custom_vscode_dark"

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "john_code",
}

M.ui = {
  tabufline = {
    lazyload = false,
    bufwidth = 0,
    order = { "treeOffset", "buffers", "tabs" },
  },
}

M.nvdash = { load_on_startup = true }

return M
