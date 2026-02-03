{ pkgs, ... }:

{
  systemd.services.battery-threshold = {
    description = "Set battery charge threshold";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''
        ${pkgs.runtimeShell} -c 'echo 70 > /sys/class/power_supply/BAT0/charge_control_end_threshold'
      '';
    };
  };
}
