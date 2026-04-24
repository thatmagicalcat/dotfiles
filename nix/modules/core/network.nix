{ ... }:

{
  networking.hostName = "DELTA";
  networking.networkmanager.enable = true;
  networking.nameservers = [ "1.1.1.1" ];
  networking.firewall.allowedTCPPorts = [ 
    22
    47984
    47989
    47990
    47999
    48010
  ];
  networking.firewall.allowedUDPPorts = [ 
    47998
    47999
    48000
    48002
    48010
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "no";
    };
  };
}
