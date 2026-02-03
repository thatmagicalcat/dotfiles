{ pkgs, ... }:

{
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

  hardware.printers = {
    ensurePrinters = [
      {
        name = "HP_LaserJet";
        location = "Home";
        deviceUri = "usb://HP/LaserJet%20M1005?serial=KJ6BBZB&interface=1";
        model = "drv:///hp/hpcups.drv/hp-laserjet_m1005.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
  };
}
