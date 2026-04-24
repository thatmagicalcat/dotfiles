{
  description = "Snow flakes";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    quickshell = {
      # add ?ref=<tag> to track a tag
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";

      # THIS IS IMPORTANT
      # Mismatched system dependencies will lead to crashes and other issues.
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # nil = {
    #   url = "github:oxalica/nil";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # voxtype = {
    #   url = "github:peteonrails/voxtype";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    opencode = {
      # url = "github:sst/opencode/?ref=v1.1.47";
      url = "github:duskyelf/nixpkgs/update-opencode";
      # inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.DELTA = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/DELTA
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
