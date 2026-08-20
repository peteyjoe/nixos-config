{
  description = "My NixOS configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager-unstable = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    home-manager-unstable,
    sops-nix,
    disko,
    ...
  }:

  let
    mkSystem = nixpkgsInput: modules:
      nixpkgsInput.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        inherit modules;
      };
  in
  {
    nixosConfigurations = {
      the-box = mkSystem nixpkgs [
        ./hosts/the-box
        sops-nix.nixosModules.sops
      ];

      casa-vps = mkSystem nixpkgs [
        ./hosts/casa-vps
        disko.nixosModules.disko
        sops-nix.nixosModules.sops
      ];

      big-juan = mkSystem nixpkgs-unstable [
        ./hosts/big-juan
        disko.nixosModules.disko
        home-manager-unstable.nixosModules.home-manager

        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = { inherit inputs; };

            users.peteyjoe = import ./home/peteyjoe;
          };
        }
      ];
    };
  };
}
