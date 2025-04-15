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
    alacritty
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
    };
    colorschemes.vscode.enable = true;
    plugins = {
      lualine.enable = true;
      nvim-tree = {
        enable = true;       
	renderer.root_folder_label = false;
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
    ];
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
