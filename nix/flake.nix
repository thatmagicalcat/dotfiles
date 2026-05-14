{
  description = "Snow flakes";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ytm-player = {
      url = "github:peternaame-boop/ytm-player";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      unstable = nixpkgs-unstable.legacyPackages.${system};
    in
    {
      nixosConfigurations.DELTA = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/DELTA
        ];
        specialArgs = { inherit inputs; inherit unstable; };
      };
    };
}
