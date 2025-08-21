{
  ...
}:
{
  user = {
    persist = {
      files = [ ".zsh_history" ];
      directories = [ ".cache/zsh" ];
    };

    homeConfig = {
      programs.zsh = {
        # enable = true;

        # enableAutosuggestions = true;
        # enableCompletion = false;
        # syntaxHighlighting.enable = true;
        # vteIntegration = true;
        # setOptions = [
        #   "autocd"
        # ];

        # history = {
        #   # share history between different zsh sessions
        #   share = true;

        #   # saves timestamps to the histfile
        #   extended = true;

        #   # optimize size of the histfile by avoiding duplicates
        #   # or commands we don't need remembered
        #   save = 100000;
        #   size = 100000;
        #   expireDuplicatesFirst = true;
        #   ignoreDups = true;
        #   ignoreSpace = true;
        #   ignorePatterns = ["rm *" "pkill *" "kill *" "killall *"];
        # };
      };
    };
  };
}