{ pkgs, config, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig
      catppuccin-nvim
    ];
  };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
