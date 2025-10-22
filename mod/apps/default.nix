{ lib, ... }:
let
  files = builtins.attrNames (builtins.readDir ./.);

  nixFiles = builtins.filter (name: lib.hasSuffix ".nix" name && name != "default.nix") files;

  imports = map (name: ./. + "/${name}") nixFiles;
in
{
  inherit imports;
}
