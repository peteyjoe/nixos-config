{
  description = "My NixOS server configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    }
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations = {
      the-box = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          sops-nix.nixosModules.sops
          ./hosts/the-box
        ];
      };
    };
  };
}
