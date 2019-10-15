{ pkgs, ... }:

{
  boot = {
    plymouth = {
      enable = true;

     #logo = pkgs.fetchurl {
     #  url = "https://zick.kim/ping/me.png";
     #  sha256 = "0pia8imk4rv9caws2wp2r7qphxazy465lmp5p8y96v570gy4q1cq";
     #};

      #theme = "details";
    };

    kernelParams = [
      "i915.fastboot=1"
      #"plymouth.splash-delay=30"
    ];
  };

  /*systemd.services.systemd-ask-password-plymouth.wantedBy = [ "sysinit.target" ];

  systemd.services.display-manager = {
    conflicts = [
      "getty@tty1.service"
      "plymouth-quit.service"
      "plymouth-quit-wait.service"
    ];

    wants = [ "plymouth-deactivate.service" ];

    after = [
      "systemd-user-sessions.service"
      "getty@tty1.service"
      "plymouth-deactivate.service"
      "plymouth-quit.service"
    ];
  };*/
}
