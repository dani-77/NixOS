{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    oxwm.url = "github:tonybanters/oxwm";
    oxwm.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, oxwm, ... }: {
    nixosConfigurations.yourhost = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        oxwm.nixosModules.default
      ];
    };
  };
}
