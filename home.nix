{ config, lib, pkgs, inputs, ... }:

{
  home.stateVersion = "24.11";

  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    vim
#     neovim
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
    (pkgs.st.override { conf = builtins.readFile ./st-config.h;
      patches = [
        (fetchpatch {
          url = "https://st.suckless.org/patches/scrollback/st-scrollback-0.9.2.diff";
          sha256 = "0ymc5db75cwmdvv8ak3bfaf7iz4snj65fbmhrl9blv7h7pw3pdld";
        })
        # (fetchpatch {
          # url = "https://st.suckless.org/patches/columnredraw/st-columnredraw-20241119-fb8569b.diff";
          # sha256 = "1243mrpi06ldr8d7b554slhpaf02j7j4cpzrnfqanfms0mhijix5";
        # })
        # (fetchpatch {
          # url = "https://st.suckless.org/patches/boxdraw/st-boxdraw_v2-0.8.5.diff";
          # sha256 = "108h30073yb8nm9x04x7p39di8syb8f8k386iyy2mdnfdxh54r04";
        # })
      ];
    })
  ];

  programs = {
    home-manager.enable = true;
  };

  programs.nixvim = {
    enable = true;
    colorschemes.catppuccin.enable = true;
    plugins.lualine.enable.true;
  }

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
