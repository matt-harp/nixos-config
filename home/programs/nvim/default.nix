{ pkgs, ... }:


{
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    extraLuaConfig = ''
      require("core")
      require("keymap")
    '';

    plugins = with pkgs.vimPlugins; [
      vim-sleuth # automatically detect and set indentation settings

      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require("plugins.treesitter")
        '';
      }
      which-key-nvim
      {
        plugin = catppuccin-nvim;
        type = "lua";
        config = ''
          vim.cmd.colorscheme "catppuccin"
        '';
      }
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          require("plugins.telescope")
        '';
      }
      neo-tree-nvim
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          require("plugins.lsp")
        '';
      }
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          require("plugins.completion")
        '';
      }
      { plugin = cmp-nvim-lsp; }
      { plugin = luasnip; }
      { plugin = cmp_luasnip; }
      { plugin = nvim-autopairs; }
      {
        plugin = vim-tmux-navigator;
        type = "lua";
        config = ''
          vim.keymap.set('n', 'C-h', ':TmuxNavigateLeft<CR>')
          vim.keymap.set('n', 'C-j', ':TmuxNavigateDown<CR>')
          vim.keymap.set('n', 'C-k', ':TmuxNavigateUp<CR>')
          vim.keymap.set('n', 'C-l', ':TmuxNavigateRight<CR>')
        '';
      }
    ];
    extraPackages = with pkgs; [
      # For telescope
      ripgrep
      fd

      # nix lsp
      nixd

      clang-tools

      lua-language-server
    ];
  };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
