{ pkgs, ... }:

{
  documentation.man.generateCaches = false;

  # services.nohang.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.gvfs.enable = true;
  services.displayManager.ly.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      mesa
    ];
  };

  programs.nix-ld.enable = true;
  programs.gpu-screen-recorder.enable = true;
  programs.dconf.enable = true;
  programs.kdeconnect.enable = true;
}
