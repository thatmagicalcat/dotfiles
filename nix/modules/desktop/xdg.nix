{ pkgs, ... }:

{
  xdg.portal = {
    enable = true;
  #   wlr.enable = false;
  #   extraPortals = [
  #     pkgs.xdg-desktop-portal-gnome
  #     pkgs.xdg-desktop-portal-gtk
  #   ];
  #
  #   config = {
  #     common = {
  #       default = [ "gtk" ];
  #       "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
  #       "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
  #     };
  #   };
  };

  environment.variables = {
    QT_QPA_PLATFORM = "wayland";
  };
}
