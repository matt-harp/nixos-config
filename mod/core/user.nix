{
  pkgs,
  config,
  lib,
  inputs,
  username,
  host,
  ...
}:
let
  inherit (builtins) attrValues;
  mergedAttrs = lib.mkOptionType {
    name = "mergedAttrs";
    merge = _: lib.getValues;
  };
in
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  options.user.homeConfig = lib.mkOption {
    description = "Alias for `home-manager.users.\${username}`";
    type = lib.mkOptionType {
      name = "home-manager module";
      check = _: true;
      merge =
        loc:
        map (def: {
          _file = def.file;
          imports = [ def.value ];
        });
    };
  };

  config = {
    programs.niri.enable = true; # TODO move from here!!!
    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "bak";
      extraSpecialArgs = { inherit inputs username host; };
      users.${username} = {
        imports = [
          ../../home
        ]
        ++ config.user.homeConfig;
        home.username = "${username}";
        home.homeDirectory = "/home/${username}";
        home.stateVersion = "25.11";
        programs.home-manager.enable = true;
      };
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
