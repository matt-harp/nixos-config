{
  ...
}:
{
  config = {
    user = {
      persist.directories = [
        ".cache/mozilla/firefox"
        ".mozilla/firefox"
      ];

      homeConfig = {
        programs.firefox = {
          enable = true;
        };
      };
    };
  };
}