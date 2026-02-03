{ inputs, ... }:

{
  imports = [
    ./hardware.nix
    inputs.voxtype.nixosModules.default

    ../../modules/core/boot.nix
    ../../modules/core/network.nix
    ../../modules/core/user.nix
    ../../modules/core/nix.nix

    ../../modules/desktop/river.nix
    ../../modules/desktop/fonts.nix
    ../../modules/desktop/xdg.nix

    ../../modules/services/audio.nix
    ../../modules/services/bluetooth.nix
    ../../modules/services/printing.nix
    ../../modules/services/misc.nix
    ../../modules/services/battery.nix
    ../../modules/services/autocpufreq.nix

    ../../modules/packages.nix
  ];
}
