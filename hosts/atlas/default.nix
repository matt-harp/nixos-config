{ inputs, ... }:

{
  imports = [
    ../../mod/core

    ./disks.nix
    ./hardware-configuration.nix
  ];
}
