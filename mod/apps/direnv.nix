{
  user = {
    persist.directories = [ ".config/direnv" ".local/share/direnv" ];
    homeConfig = {
      programs.direnv = {
        enable = true;
        enableBashIntegration = true;
        nix-direnv.enable = true;
      };
    };
  };
}