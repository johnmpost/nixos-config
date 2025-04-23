{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  programs.fuse.userAllowOther = true;

  environment.persistence."/nix/persist" = {
    directories = [
      "/etc/nixos"
      "/var/log"
      "/etc/NetworkManager/system-connections"
      "/var/db/sudo/lectured"
      "/var/lib/systemd/backlight"
    ];
  };

  users.mutableUsers = false;
  users.users.john = {
    isNormalUser = true;
    hashedPassword = "$6$f18PZFZFnwIDW/ZS$n3A4zvkXM4wtmaL4Z8VFQIKdYgG.4plbT0cnl9cbK63ZW3d4b8RZ6rrPjpY33yuqQ46NwZip22EnEfUMrfsMq1";
    extraGroups = [ "wheel" ];
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
  services.envfs.enable = true;

  environment.sessionVariables = {
    MOZ_USE_XINPUT2 = "1";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  
  security.sudo.extraConfig = ''
    Defaults	timestamp_timeout=10
  '';

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  system.stateVersion = "24.11";
}

