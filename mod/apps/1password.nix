{ 
  username,
  ...
}:
{
  config = {
    user = {
      persist.directories = [
        ".config/1Password"
      ];
    };

    programs = {
      _1password.enable = true;
      _1password-gui = {
        enable = true;
        polkitPolicyOwners = [ username ];
      };
    };
  };
}
