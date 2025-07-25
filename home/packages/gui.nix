{ pkgs, ... }:
{
  home.packages = with pkgs; [
    spotify
    firefox
  ];
}