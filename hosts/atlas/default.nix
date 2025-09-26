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
      helix.enable = true;
      ollama.enable = true;
      slack.enable = true;
      spotify.enable = true;
      teams.enable = true;
      vim.enable = true;
      vscode.enable = true;
      zoom.enable = false;
    };
    tools = {
      direnv.enable = true;
    };
  };
}
