{
  config,
  lib,
  inputs,
  ...
}:
let
  cfg = config.apps.vim;
in
{
  options.apps.vim = {
    enable = lib.mkEnableOption "Vim";
  };

  imports = [
    inputs.nvf.nixosModules.default
  ];

  config = lib.mkIf cfg.enable {
    programs.nvf = {
      enable = true;

      settings = {
        vim = {
          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
          };

          statusline.lualine.enable = true;
          telescope.enable = true;
          autocomplete.nvim-cmp.enable = true;

          lsp = {
            enable = true;
          };

          languages = {
            enableTreesitter = true;

            nix.enable = true;
            ts.enable = true;
            rust.enable = true;
          };
        };
      };
    };
  };
}
