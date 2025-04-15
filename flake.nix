{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, impermanence, ... }: {
    nixosConfigurations.john-nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # how to add unfree?
      specialArgs = { inherit inputs; };

      modules = [
        ./configuration.nix
	impermanence.nixosModules.impermanence
	home-manager.nixosModules.home-manager
	{
	  imports = [ home-manager.nixosModules.home-manager ];
	  home-manager.useGlobalPkgs = true;
	  home-manager.useUserPackages = true;
	  home-manager.users.john = { ... }: {
	    imports = [
	      impermanence.homeManagerModules.impermanence
	      ./home.nix
	    ];
	  };
	}
      ];
    };
  };
}
