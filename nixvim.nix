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
      };
    };
  };

  plugins = {
    web-devicons.enable = true;
    nvim-surround.enable = true;
    nvim-autopairs.enable = true;
    lualine = {
      enable = true;
      settings.options.disabled_filetypes = [ "NvimTree" ];
    };
    nvim-tree = {
      enable = true;       
      renderer.rootFolderLabel = false;
      hijackCursor = true;
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
  };

  globals.mapleader = " ";
  keymaps = [
  {
    key = ";";
    action = ":";
  }
  {
    key = "<leader>e";
    action = "<cmd>NvimTreeToggle<CR>";
    options.silent = true;
  }
  {
    key = "<leader>ff";
    action = "<cmd>Telescope find_files<CR>";
    options.silent = true;
  }
  # TODO fix double map
  {
    key = "<leader>fg";
    action = "<cmd>Telescope git_files<CR>";
    options.silent = true;
  }
  {
    key = "<leader>fb";
    action = "<cmd>Telescope buffers<CR>";
    options.silent = true;
  }
  {
    key = "<leader>fg";
    action = "<cmd>Telescope live_grep<CR>";
    options.silent = true;
  }
  {
    key = "<leader>fw";
    action = "<cmd>Telescope grep_word<CR>";
    options.silent = true;
  }
  {
    key = "<leader>s";
    action = "<cmd>w<CR>";
    options.silent = true;
  }
  {
    key = "<leader>x";
    action = "<cmd>bd<CR>";
    options.silent = true;
  }
  {
    key = "<leader>r";
    action = "<cmd>Telescope oldfiles cwd_only=true<CR>";
    options.silent = true;
  }
  # TODO bufferline reorder buffers
  # TODO bufferline make separator a color and nice
  # TODO bufferline LSP feedback
  ] ++ 
  (let
    keys = [1 2 3 4 5 6];
  in
  map (i: {
    key = "<A-${toString i}>";
    action = "<cmd>lua require('bufferline').go_to(${toString i}, true)<CR>";
    options.silent = true;
  }) keys);
}
