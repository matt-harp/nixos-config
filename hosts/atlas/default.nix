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

  config = {
    apps = {
      _1password.enable = true;
      discord.enable = true;
      firefox.enable = true;
      godot.enable = true;
      lutris.enable = true;
      ollama.enable = true;
      prism.enable = true;
      qmk.enable = true;
      slack.enable = true;
      spotify.enable = true;
      teams.enable = true;
      zed.enable = true;
      zoom.enable = false;
      zoxide.enable = true;
    };
    system.impermanent = true;
    tools = {
      direnv.enable = true;
    };
  };
}
