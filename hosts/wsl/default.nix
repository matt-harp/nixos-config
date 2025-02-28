{ config, pkgs, ... }:

{
  imports = [
    ../../mod/core.nix
    ../../mod/1password.nix
  ];

  # Set hostname
  networking.hostName = "wsl";
  networking.networkmanager.enable = true;

  wsl.enable = true;
  wsl.defaultUser = "matt";

  system.stateVersion = "24.11";
}
