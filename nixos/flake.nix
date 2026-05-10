{
  description = "Main system config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: 
  let 
    system = "x86_64-linux";
    vars = import ./variables.nix;
  in {
    nixosConfigurations = {
      "${vars.hostname}" = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs; };

        modules = [
          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              git
              wget
              opentabletdriver
              inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
              awscli2
            ];
          })
          ./configuration.nix
          inputs.home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
