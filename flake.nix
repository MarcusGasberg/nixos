{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin = { url = "github:catppuccin/nix"; };

    # hyprland = { url = "git+https://github.com/hyprwm/Hyprland?submodules=1"; };
    #
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    nvim = {
      url = "git+file:./nvim";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, catppuccin, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; };
        system = system;
        modules = [
          ./configuration.nix
          # if you use home-manager
          catppuccin.nixosModules.catppuccin
          home-manager.nixosModules.home-manager
          {
            # if you use home-manager
            home-manager.users.marcusg = {
              imports = [ ./home.nix catppuccin.homeManagerModules.catppuccin ];
            };
          }
        ];
      };
    };
}
