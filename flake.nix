{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-flake ={
      url = "github:marcusgasberg/dotnix";
    };
  };

  outputs = { self, nixpkgs,home-manager, neovim-flake, ... }@inputs: 
let
  neovimOverlay = neovim-flake.overlays.default;
  pkgsWithOverlay = import nixpkgs { overlays = [ neovimOverlay ]; };
in
  {
    systemPackages = with pkgsWithOverlay; [
      nvim-pkg
    ];


    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
      ];
    };
  };
}
