{
  description = "Main system config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, home-manager, ... }@inputs: 
  let 
    system = "x86_64-linux";
    vars = import ./variables.nix;
    unstable = import nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
    };
  in {
    nixosConfigurations = {
      inherit system;
      "${vars.hostname}" = nixpkgs.lib.nixosSystem {

        specialArgs = { inherit inputs; };

        modules = [
          ({ pkgs, ... }: {
            environment.systemPackages = with pkgs; [
              git
              wget
              opentabletdriver
              inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
              unstable.awscli2
            ];
          })
          ./configuration.nix
          inputs.home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
