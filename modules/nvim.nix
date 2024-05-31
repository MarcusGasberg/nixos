
{ config, pkgs, inputs, ... }: 

let
  myOverlay = inputs.nvim.overlays.default;
  pkgsWithOverlay = import pkgs { overlays = [ myOverlay ]; };
in
{
  environment.systemPackages = with pkgsWithOverlay; [
    nvim-pkg
  ];

}
