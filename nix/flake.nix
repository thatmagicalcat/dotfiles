{
    description = "A very basic flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-25.05";
        zen-browser.url = "github:0xc000022070/zen-browser-flake/beta";
        nil.url = "github:oxalica/nil";
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
            nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
                inherit system;
                modules = [
                    ./configuration.nix
                    {
                        config._module.args = {
                            inherit inputs;
                        };
                    }
                ];
            };
        };
}
