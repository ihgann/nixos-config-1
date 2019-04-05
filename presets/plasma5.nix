{ config, pkgs, ... }:

{
  includes = [
    ../cfgs/fonts.nix
  ];

  environment.systemPackages = with pkgs; [
    filelight
    kate
    kdeFrameworks.kdesu
    krita
    ktorrent
    partition-manager
    spectacle

    ark
    p7zip

    kdeApplications.kdialog

    kdeconnect
  ];

  services.printing = {
    enable = true;
    drivers = [ pkgs.hplip ];
  };

  services.avahi.enable = true;

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  hardware.bluetooth = {
    enable = true;

    extraConfig = "${ft.dosini}
      [General]
      Enable=Source,Sink,Media,Socket
    ";
  };

  nixpkgs.config.pulseaudio = true;

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  networking.firewall = {
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; }
    ];

    allowedUDPPortRanges = [
      { from = 1714; to = 1764; }
    ];
  };
}
