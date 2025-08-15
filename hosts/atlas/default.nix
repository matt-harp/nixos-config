{ inputs, ... }:

{
  imports = [
    ../../mod/core
    ../../mod/apps
    inputs.disko.nixosModules.disko

    ./disks.nix
    ./hardware-configuration.nix
  ];
}
