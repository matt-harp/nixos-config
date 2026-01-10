{ ... }:
{
  user.homeConfig = {
    programs.bash = {
      enable = true;
      enableCompletion = true;
      bashrcExtra = ''
        eval "$(starship init bash)"
        eval "$(direnv hook bash)"
      '';
      shellAliases = {
        "cd" = "z";
        ".." = "cd ..";
        "find" = "fd";
        "ls" = "eza";
      };
    };
  };
}
