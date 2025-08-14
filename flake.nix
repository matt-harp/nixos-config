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
  };

  outputs = inputs @ { 
    nixpkgs,
    self,
    ... 
  }:
  let
    username = "matt";
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    lib = nixpkgs.lib;
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
