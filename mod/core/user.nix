{
  pkgs,
  config,
  lib,
  inputs,
  username,
  host,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options = {
    user = {
      homeConfig = lib.mkOption {
        description = "Shared User Home Configuration";
        type = lib.types.attrs;
        default = { };
      };
    };
  };
  
  config = {
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      extraSpecialArgs = { inherit inputs username host; };
      users.${username} = {
        imports = [
          ../../home
        ];
        home.username = "${username}";
        home.homeDirectory = "/home/${username}";
        home.stateVersion = "25.11";
        programs.home-manager.enable = true;
      } // config.user.homeConfig;
    };

    users.users.${username} = {
      isNormalUser = true;
      hashedPasswordFile = "/persist/passwords/${username}";
      description = "${username}";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.bash;
    };

    users.users.root = {
      hashedPasswordFile = "/persist/passwords/root";
    };
    nix.settings.allowed-users = [ "${username}" ];
  };
}
