return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "typescript",
        "tsx",
        "javascript",
        "ledger",
        "markdown",
        "bash",
      },
    },
  },
  -- {
  --   "HiPhish/rainbow-delimiters.nvim",
  --   lazy = false,
  --   main = "rainbow-delimiters.setup",
  --   opts = {},
  -- },
  {
    "kirasok/cmp-hledger",
    event = "InsertEnter",
    config = function()
      local cmp = require "cmp"
      cmp.setup {
        sources = cmp.config.sources({
          { name = "hledger" },
        }, cmp.get_config().sources),
      }
    end,
  },
  {
    "koraa/proverif.vim",
    ft = "proverif",
  },
}
