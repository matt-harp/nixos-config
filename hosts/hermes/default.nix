{ ... }:

{
  imports = [
    ../../mod/core
    ../../mod/apps
    ../../mod/shell

    ./hardware-configuration.nix
  ];

  config = {
    apps = {
      _1password.enable = true;
      discord.enable = true;
      firefox.enable = true;
      godot.enable = false;
      helix.enable = true;
      lutris.enable = false;
      ollama.enable = false;
      qmk.enable = false;
      slack.enable = true;
      spotify.enable = true;
      teams.enable = true;
      tidal.enable = false; #TODO BLOW AWAY
      vim.enable = true;
      vscode.enable = true;
      zed.enable = true;
      zoom.enable = true;
    };
    system.impermanent = false;
    tools = {
      direnv.enable = true;
    };
  };
}
