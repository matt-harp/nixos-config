{ pkgs, inputs, ... }:
{
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
      # (final: prev: {
      #   bash = prev.bash.overrideAttrs (oldAttrs: {
      #     src = prev.fetchurl {
      #       url = oldAttrs.src.url;
      #       hash = "sha256-DVzYaWX4aaJs9k9Lcb57lvkKO6iz104n6OnZ1VUPMbo=";
      #     };
      #   });
      # })
      # (self: super: let
      #   gnuConfig = builtins.fetchGit {
      #     url = "git://git.savannah.gnu.org/config.git";
      #     rev = "948ae97ca5703224bd3eada06b7a69f40dd15a02";
      #     allRefs = true;
      #   };
      # in {
      #   gnu-config = super.gnu-config.overrideAttrs {
      #     unpackPhase = ''
      #       runHook preUnpack
      #       cp ${gnuConfig}/config.guess ./config.guess
      #       cp ${gnuConfig}/config.sub ./config.sub
      #       chmod +w ./config.sub ./config.guess
      #       runHook postUnpack
      #     '';
      #   };
      # })
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    git
    nixfmt-rfc-style
  ];

  time.timeZone = "America/Denver";
  time.hardwareClockInLocalTime = true;
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "25.11";
}
