{
  description = "System configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:Nix-community/impermanence";
    };

    systems = {
      url = "github:nix-systems/x86_64-linux";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.systems.follows = "systems";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      self,
      ...
    }:
    let
      username = "matt";
      system = "x86_64-linux";
    in
    {
      nixosConfigurations = {
        atlas = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/atlas ];
          specialArgs = {
            host = "atlas";
            inherit self inputs username;
          };
        };
        hermes = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [ ./hosts/hermes ];
          specialArgs = {
            host = "hermes";
            inherit self inputs username;
          };
        };
      };
    };
}
