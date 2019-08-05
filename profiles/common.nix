{ lib, pkgs, ... }:

let

  inherit (lib) optional optionalAttrs mkIf mkMerge mkDefault flatten;
  inherit (builtins) currentSystem;
  inherit (lib.systems.elaborate { system = currentSystem; }) isLinux isDarwin;

in

{
  imports = flatten [
    ../config/neovim.nix
    ../config/zsh.nix
    ./users.nix

    (optional isLinux ./hosts.nix)
  ];
} //

mkMerge [
  {
    environment.systemPackages =
      (with pkgs; [
        ack
        curl
        file
        gnupg
        mosh
        nix-prefetch-git
        nmap
        pv
        telnet
        unzip
        w3m
        wget
        youtube-dl
        zip

        cht-sh

        git
        gitAndTools.git-hub
        gitAndTools.hub
        gitAndTools.git-fame
        lab
      ]);

    nixpkgs.config.allowUnfree = true;
  }

  (optionalAttrs isLinux {
    environment.systemPackages = with pkgs; [
      whois
    ];

    services.gpm.enable = true;

    time.timeZone = "America/New_York";

    i18n = {
      consoleFont = "Lat2-Terminus16";
      defaultLocale = "en_US.UTF-8";
      consoleUseXkbConfig = true;
    };

    services.xserver = {
      layout = "us";
      xkbOptions = "caps:escape,compose:prsc";
    };

    boot.extraModprobeConfig = /* modconf */ ''
      options usb-storage quirks=0bc2:ac30:u
    '';

    environment.variables = {
      themePrimaryColor = mkDefault "magenta";
      themeSecondaryColor = mkDefault "green";
      tmuxPrefixKey = mkDefault "b";
    };

    system.stateVersion = "19.03";
  })

  (mkIf isDarwin {
    environment.systemPackages = with pkgs; [
      coreutils
    ];

    system.stateVersion = 3;
  })
]
