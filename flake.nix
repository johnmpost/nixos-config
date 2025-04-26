{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, impermanence, nixvim, ... }: {
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
	  home-manager.backupFileExtension = "backup";
	  home-manager.extraSpecialArgs = { inherit inputs; };
	  home-manager.users.john = { ... }: {
	    imports = [
	      impermanence.homeManagerModules.impermanence
	      nixvim.homeManagerModules.nixvim
	      ./home.nix
	    ];
	  };
	}
      ];
    };
  };
}
