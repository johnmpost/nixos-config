{ inputs, pkgs, ... }: {
  enable = true;

  opts = {
    number = true;
    shiftwidth = 2;
    ignorecase = true;
    smartcase = true;
  };

  diagnostic.settings = {
    virtual_text = true;
    underline = true;
    signs = false;
  };

  colorschemes.vscode = {
    enable = true;
    settings = {
      disable_nvimtree_bg = true;
      color_overrides = {
	vscBack = "#222222";
      };
      group_overrides = {
	Comment = { fg = "#5A5A5A"; bg = "NONE"; };
	RainbowDelimiterYellow = { fg = "#FFD602"; bg = "NONE"; };
	RainbowDelimiterViolet = { fg = "#DA70D6"; bg = "NONE"; };
      };
    };
  };

  highlight."@comment".link = "Comment";
  highlight."SpecialChar".fg = "#FFD602";
  highlight."@ledger.negative".link = "ErrorMsg";

  filetype.extension = { pv = "proverif"; };

  lsp = {
    servers.lua_ls.enable = true;
    servers.nil_ls.enable = true;
    servers.ts_ls.enable = true;
    servers.jsonls.enable = true;
    servers.efm = {
      enable = true;
      settings.filetypes = { __unkeyed-1 = "ledger"; };
      settings.settings = {
	root_markers = [ ".git/" ];
	languages = {
	  ledger = {
	    __unkeyed-1 = {
	      lintCommand = "hledger check --strict -f - 2>&1";
	      lintStdin = true;
	      lintFormats = [
		"%Ehledger: Error: %f:%l-%e:"
		"%Ehledger: Error: %f:%l:%c:"
		"%Ehledger: Error: %f:%l:"
		"%C%.%#|%.%#"
		"%C%^%m%#"
	      ];
	      lintIgnoreExitCode = true;
	    };
	  };
	};
      };
    };
  };

  plugins = {
    web-devicons.enable = true;
    nvim-surround.enable = true;
    nvim-autopairs.enable = true;
    lspconfig.enable = true;
    cmp-nvim-lsp.enable = true;
    comment.enable = true;
    lsp-signature = {
      enable = true;
      settings.hint_enable = false;
    };

    conform-nvim = {
      enable = true;
      settings.formatters_by_ft = {
	lua = [ "stylua" ];
	css = [ "prettier" ];
	html = [ "prettier" ];
	typescript = [ "prettier" ];
	javascript = [ "prettier" ];
	json = [ "prettier" ];
	jsonc = [ "prettier" ];
	ledger = [ "hledgerfmt" ];
	markdown = [ "prettier" ];
	javascriptreact = [ "prettier" ];
	typescriptreact = [ "prettier" ];
	"*" = [ "trim_newlines" ];
      };

      settings.formatters = {
	hledgerfmt = {
	  command = "sh";
	  args = {
	    __unkeyed-1 = "-c";
	    __unkeyed-2 =
	    ''
	      {
		tmpfile=$(mktemp) || exit 1
		trap 'rm -f "$tmpfile"' EXIT
		cat - > "$tmpfile"
		{
		  awk '/^[0-9]{4}-[0-9]{2}-[0-9]{2}/ {exit} {print}' "$tmpfile"
		  hledger print -n -f "$tmpfile" --round=soft -x
		} || cat "$tmpfile"
	      }
	    '';
	  };
	};
      };

      settings.format_on_save = {
	timeout_ms = 500;
	lsp_fallback = true;
      };
    };

    rainbow-delimiters = {
      enable = true;
      highlight = [
	"RainbowDelimiterYellow"
	"RainbowDelimiterViolet"
	"RainbowDelimiterBlue"
      ];
    };

    treesitter = {
      enable = true;
      settings.highlight.enable = true;
    };

    lualine = {
      enable = true;
      settings.options.disabled_filetypes = [ "NvimTree" ];
      settings.sections.lualine_b = [
	"diff"
	"diagnostics"
      ];
      settings.sections.lualine_c = [{
	__unkeyed-1 = "filename";
	path = 1;
      }];
    };

    nvim-tree = {
      enable = true;       
      renderer.rootFolderLabel = false;
      hijackCursor = true;
      filters.custom = [ "^\\.git$" ];
    };

    telescope.enable = true;

    bufferline = {
      enable = true;
      settings.highlights.buffer_selected.italic = false;
      settings.highlights.buffer_selected.bold = false;
      settings.options = {
	show_buffer_close_icons = false;
	offsets = [{
	  filetype = "NvimTree";
	  text = "Files";
	  highlight = "Directory";
	  separator = true;
	}];
	persist_buffer_sort = false;
	separator_style = "thin";
      };
    };

    cmp = {
      enable = true;
      settings.sources = [
	{ name = "hledger"; }
	{ name = "nvim_lsp"; }
	{ name = "path"; }
	{ name = "buffer"; }
      ];
      settings.mapping = {
	"<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
	"<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
	"<CR>" = "cmp.mapping.confirm({select = false})";
      };
    };
  };

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "koraa/proverif.vim";
      src = pkgs.fetchFromGitHub {
	  owner = "koraa";
	  repo = "proverif.vim";
	  rev = "7ff704a";
	  hash = "sha256-4nL8R2H6lJZcNjl0DUqlNkyPB+sJjExekhIKVmgKrCY=";
      };
    })
    (pkgs.vimUtils.buildVimPlugin {
      name = "cmp_hledger";
      src = pkgs.fetchFromGitHub {
	  owner = "kirasok";
	  repo = "cmp-hledger";
	  rev = "ea2211c";
	  hash = "sha256-5P6PsCop8wFdFkCPpShAoCj1ygryOo4VQUZQn+0CNdo=";
      };
      dependencies = with pkgs; [ vimPlugins.nvim-cmp ];
    })
  ];

  globals.mapleader = " ";

  keymaps =
    let
      numberKeys = map (i: {
	key = "<A-${toString i}>";
	action = "<cmd>lua require('bufferline').go_to(${toString i}, true)<CR>";
	options.silent = true;
      }) [1 2 3 4 5 6];
    in
    numberKeys ++ [
      {
	key = ";";
	action = ":";
      }
      {
	key = "<A-h>";
	action = "<C-w>h";
      }
      {
	key = "<A-l>";
	action = "<C-w>l";
      }
      {
	key = "<A-n>";
	action = "<cmd>NvimTreeToggle<CR>";
	options.silent = true;
      }
      {
	key = "<leader>e";
	action = "<cmd>NvimTreeFocus<CR>";
	options.silent = true;
      }
      {
	key = "<C-p>";
	action = "<cmd>Telescope find_files<CR>";
	options.silent = true;
      }
      {
	key = "<leader>ff";
	action = "<cmd>Telescope git_files<CR>";
	options.silent = true;
      }
      {
	key = "<leader>fF";
	action = "<cmd>lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true })<CR>";
	options.silent = true;
      }
      {
        key = "<leader>fg";
        action = "<cmd>lua require('telescope.builtin').live_grep({ search_dirs = vim.fn.systemlist('git ls-files')})<CR>";
        options.silent = true;
      }
      {
        key = "<leader>fG";
        action = "<cmd>Telescope live_grep<CR>";
        options.silent = true;
      }
      {
	key = "<leader>fw";
	action = "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>'), search_dirs = vim.fn.systemlist('git ls-files') })<CR>";
	options.silent = true;
      }
      {
	key = "<leader>fb";
	action = "<cmd>Telescope buffers<CR>";
	options.silent = true;
      }
      {
	key = "<leader>fo";
	action = "<cmd>Telescope oldfiles cwd_only=true<CR>";
	options.silent = true;
      }
      {
	key = "<C-s>";
	action = "<cmd>w<CR>";
	options.silent = true;
      }
      {
	key = "<leader>x";
	action = "<cmd>bd<CR>";
	options.silent = true;
      }
      {
	key = "<A-z>";
	action = "<cmd>set wrap!<CR>";
	options.silent = true;
      }
      {
	key = "<leader>k";
	action = "<cmd>lua vim.diagnostic.open_float({ border = 'single' })<CR>";
	options.silent = true;
      }
      {
	key = "<leader>ca";
	action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
	options.silent = true;
      }
      {
	key = "<leader>sa";
	action = "<cmd>lua vim.lsp.buf.code_action({ context = { only = { 'source' }, diagnostics = {} } })<CR>";
	options.silent = true;
      }
      {
        key = "<leader>gr";
	action = "<cmd>lua require('telescope.builtin').lsp_references()<CR>";
        options.silent = true;
      }
      {
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options.silent = true;
      }
      {
        key = "<leader>gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options.silent = true;
      }
      {
	key = "K";
	action = "<cmd>lua vim.lsp.buf.hover({ border = 'single'})<CR>";
	options.silent = true;
      }
      {
        key = "<leader>yp";
        action = "<cmd>let @+ = expand('%')<CR>";
        options.silent = true;
      }
      {
        key = "<leader>/";
        action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
        options.silent = true;
      }
      {
        key = "<leader>fr";
        action = "<cmd>Telescope resume<CR>";
        options.silent = true;
      }
      {
        key = "<leader>gf";
        action = "<cmd>NvimTreeFindFile<CR>";
        options.silent = true;
      }
      {
        key = "[d";
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        options.silent = true;
      }
      {
        key = "]d";
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        options.silent = true;
      }
    ];

  extraConfigLua = ''
  -- Make :bd and :q behave as usual when tree is visible
  vim.api.nvim_create_autocmd({'BufEnter', 'QuitPre'}, {
    nested = false,
    callback = function(e)
      local tree = require('nvim-tree.api').tree

      -- Nothing to do if tree is not opened
      if not tree.is_visible() then
	return
      end

      -- How many focusable windows do we have? (excluding e.g. incline status window)
      local winCount = 0
      for _,winId in ipairs(vim.api.nvim_list_wins()) do
	if vim.api.nvim_win_get_config(winId).focusable then
	  winCount = winCount + 1
	end
      end

      -- We want to quit and only one window besides tree is left
      if e.event == 'QuitPre' and winCount == 2 then
	vim.api.nvim_cmd({cmd = 'qall'}, {})
      end

      -- :bd was probably issued an only tree window is left
      -- Behave as if tree was closed (see `:h :bd`)
      if e.event == 'BufEnter' and winCount == 1 then
	-- Required to avoid "Vim:E444: Cannot close last window"
	vim.defer_fn(function()
	  -- close nvim-tree: will go to the last buffer used before closing
	  tree.toggle({find_file = true, focus = true})
	  -- re-open nivm-tree
	  tree.toggle({find_file = true, focus = false})
	end, 10)
      end
    end
  })
  '';
}
