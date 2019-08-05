{ config, pkgs, ... }:

{
  imports = [
    ../../config/networkmanager.nix
    ../../profiles/common.nix
    ../../profiles/server.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.variables = {
    themeSecondaryColor = "yellow";
  };

  environment.systemPackages = with pkgs; [
    parted
  ];
}
