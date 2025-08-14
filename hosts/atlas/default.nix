{ inputs, ... }:

{
  imports = [
    ../../mod/core
    inputs.disko.nixosModules.disko

    ./disks.nix
    ./hardware-configuration.nix
  ];
}
