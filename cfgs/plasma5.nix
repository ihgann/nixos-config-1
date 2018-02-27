{ config, pkgs, ... }:

{
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

    kdeApplications.kdenlive
    ffmpeg
    frei0r
    gifsicle

    kdeconnect
    redshift-plasma-applet
  ];

  fonts.fonts = with pkgs; [
    fira
    fira-mono
    fira-code
    emojione
  ];

  services.geoclue2.enable = true; # For redshift-plasma-applet

  services.printing.enable = true;

  services.avahi.enable = true;

  services.xserver = {
    enable = true;
    displayManager.sddm.enable = true;
    desktopManager.plasma5.enable = true;
  };

  hardware.bluetooth.enable = true;

  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };
}