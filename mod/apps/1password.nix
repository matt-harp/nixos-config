{
  config,
  lib,
  username,
  ...
}:
let
  cfg = config.apps._1password;
in
{
  options.apps._1password = {
    enable = lib.mkEnableOption "1Password GUI";
  };

  config = lib.mkIf cfg.enable {
    user.persist.directories = [
      ".config/1Password"
    ];

    programs = {
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ username ];
      };
    };
  };
}
