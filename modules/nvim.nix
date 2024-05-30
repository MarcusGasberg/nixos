{ config, pkgs, inputs, ... }:
{
nixpkgs.overlays = [
    # replace <kickstart-nix-nvim> with the name you chose
    inputs.neovim-flake.overlays.default
];

    environment.systemPackages = with pkgs; [
      nvim-pkg
    ];
}
