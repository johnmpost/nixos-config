{ inputs, pkgs, ... }: {
  enable = true;

  opts = {
    number = true;
    shiftwidth = 2;
    ignorecase = true;
    smartcase = true;
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

  extraConfigLua = ''
    require("nvim-tree").config.renderer.hidden_display = "all"
  '';

  plugins = {
    web-devicons.enable = true;
    nvim-surround.enable = true;
    nvim-autopairs.enable = true;

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
      ];
      settings.mapping = {
	"<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
	"<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
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
	key = "<C-h>";
	action = "<C-w>h";
      }
      {
	key = "<C-l>";
	action = "<C-w>l";
      }
      {
	key = "<C-n>";
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
	action = "<cmd>Telescope find_files<CR>";
	options.silent = true;
      }
      {
	key = "<leader>fa";
	action = "<cmd>lua require('telescope.builtin').find_files({ hidden = true, no_ignore = true })<CR>";
	options.silent = true;
      }
      {
	key = "<leader>fg";
	action = "<cmd>Telescope live_grep<CR>";
	options.silent = true;
      }
      {
	key = "<leader>fw";
	action = "<cmd>Telescope grep_string<CR>";
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
	action = "<cmd>lua vim.diagnostic.open_float()<CR>";
	options.silent = true;
      }
    ];
}
