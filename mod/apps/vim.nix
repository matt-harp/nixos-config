{
  config,
  lib,
  inputs,
  pkgs,
  ...
}:
let
  cfg = config.apps.vim;
  mkLua = lib.generators.mkLuaInline;
in
{
  options.apps.vim = {
    enable = lib.mkEnableOption "Vim";
  };

  imports = [
    inputs.nvf.nixosModules.default
  ];

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      ripgrep
      fd
    ];

    programs.nvf = {
      enable = true;

      settings = {
        vim = {
          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
          };

          options = {
            showmode = false; # commandline mode disable
          };

          keymaps = [
            {
              mode = "n";
              key = "<leader><space>";
              action = "function() Snacks.picker.smart() end";
              lua = true;
              desc = "Smart Find Files";
            }
            {
              mode = "n";
              key = "<leader>/";
              action = "function() Snacks.picker.grep() end";
              lua = true;
              desc = "Grep";
            }
            {
              mode = "n";
              key = "<leader>sk";
              action = "function() Snacks.picker.keymaps() end";
              lua = true;
              desc = "Keymaps";
            }
          ];

          autopairs.nvim-autopairs.enable = true;
          statusline.lualine.enable = true;
          # telescope.enable = true;
          autocomplete.nvim-cmp.enable = true;

          binds = {
            whichKey.enable = true;
          };

          utility = {
            sleuth.enable = true;
            direnv.enable = true;
            snacks-nvim = {
              enable = true;
              setupOpts = {
                picker = {
                  enabled = true;
                };
                explorer = {
                  enabled = true;
                };
              };
            };
          };

          treesitter.fold = true;

          lsp = {
            enable = true;
            formatOnSave = true;
            inlayHints.enable = true;
            lightbulb.enable = true;
          };

          languages = {
            enableTreesitter = true;

            nix.enable = true;
            ts.enable = true;
            rust.enable = true;
            clang.enable = true;
            odin = {
              enable = true;
              lsp.package = [ "ols" ]; # use $PATH-based LS
            };
          };
        };
      };
    };
  };
}
