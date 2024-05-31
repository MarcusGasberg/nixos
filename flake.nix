{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim = {
      url = "git+file:./nvim";
      flake = false;
    };

    hyprland = { url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; };

    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };

        modules = [ ./configuration.nix home-manager.nixosModules.default ];
      };

      homeConfigurations."marcusg" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [ ./nixos/home.nix ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
