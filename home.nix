{ config, lib, pkgs, inputs, ... }:

{
  home.stateVersion = "24.11";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    vim
    firefox
    alacritty
    git
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-mono
    python314
    neofetch
    ripgrep
    tree
    scrot
    ungoogled-chromium
    gnucash
    hledger
    xclip
    nodejs_23
    keepassxc
    ffmpeg_6
    pulseaudio
    pavucontrol
    xss-lock
    i3lock
    lesspipe
    pkg-config
    picom
    xorg.xmodmap
    hsetroot
  ];

  programs = {
    home-manager.enable = true;
  };

  programs.nixvim = {
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
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
    };
  };

  home.file.".config/i3/config".source = ./i3-config;
  home.file.".config/i3/status-config".source = ./i3-status-config;
  home.file.".bashrc".source = ./bashrc;
  home.file.".xinitrc".source = ./xinitrc;
  home.file.".gitconfig".source = ./gitconfig;
  home.file.".config/alacritty/alacritty.toml".source = ./alacritty.toml;
  home.file.".config/picom/picom.conf".source = ./picom.conf;
  home.file.".Xmodmap".source = ./Xmodmap;

  home.persistence."/nix/persist/home/john" = {
    directories = [
      ".mozilla"
      ".ssh"
      "dl"
    ];
    files = [
      ".bash_history"
    ];
    allowOther = true;
  };
}
