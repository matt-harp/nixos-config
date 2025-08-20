{ inputs, ... }:

{
  imports = [
    ../../mod/core
    ../../mod/apps
    ../../mod/shell
    inputs.disko.nixosModules.disko

    ./disks.nix
    ./hardware-configuration.nix
  ];
}
