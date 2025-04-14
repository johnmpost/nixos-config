{ config, lib, pkgs, ... }:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.11.tar.gz";
  impermanence = builtins.fetchTarball "https://github.com/nix-community/impermanence/archive/master.tar.gz";
in
{
  imports =
    [
      ./hardware-configuration.nix
      "${impermanence}/nixos.nix"
      "${home-manager}/nixos"
    ];

  programs.fuse.userAllowOther = true;

  environment.persistence."/nix/persist" = {
    directories = [
      "/etc/nixos"
      "/var/log"
      "/etc/NetworkManager/system-connections"
    ];
  };

  users.mutableUsers = false;
  users.users.john = {
    isNormalUser = true;
    hashedPassword = "$6$f18PZFZFnwIDW/ZS$n3A4zvkXM4wtmaL4Z8VFQIKdYgG.4plbT0cnl9cbK63ZW3d4b8RZ6rrPjpY33yuqQ46NwZip22EnEfUMrfsMq1";
    extraGroups = [ "wheel" ];
  };

  home-manager.users.john = {
    imports = [ "${impermanence}/home-manager.nix" ];
    home.stateVersion = "24.11";

    fonts.fontconfig.enable = true;

    home.packages = with pkgs; [
      vim
      neovim
      firefox
      alacritty
      git
      (pkgs.nerdfonts.override { fonts = [ "Ubuntu" "UbuntuMono" ]; })
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
      kitty
      gnumake
      libgcc
      pkg-config
      picom
      xorg.xmodmap
      (pkgs.st.override { conf = builtins.readFile /etc/nixos/st-config.h;
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

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
      };
    };

    home.file.".config/i3/config".source = /etc/nixos/i3-config;
    home.file.".config/i3/status-config".source = /etc/nixos/i3-status-config;
    home.file.".bashrc".source = /etc/nixos/bashrc;
    home.file.".xinitrc".source = /etc/nixos/xinitrc;
    home.file.".gitconfig".source = /etc/nixos/gitconfig;
    home.file.".config/alacritty/alacritty.toml".source = /etc/nixos/alacritty.toml;
    home.file.".config/picom/picom.conf".source = /etc/nixos/picom.conf;
    home.file.".Xmodmap".source = /etc/nixos/Xmodmap;

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
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "john-nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";
  services.xserver.enable = true;
  services.xserver.autorun = false;
  services.xserver.displayManager.startx.enable = true;
  services.xserver.windowManager.i3.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.libinput.touchpad.naturalScrolling = true;
  services.libinput.enable = true;
  services.openssh.enable = true;
  networking.firewall.enable = false;
  # services.xserver.deviceSection = ''Option "TearFree" "true"'';
  services.envfs.enable = true;

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
  ];

  system.stateVersion = "24.11"; # never change
}

