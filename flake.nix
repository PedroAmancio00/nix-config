{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mactahoe-gtk-src = {
      url = "github:vinceliuice/MacTahoe-gtk-theme";
      flake = false;
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      zen-browser,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          {
            nixpkgs.overlays = [
              (final: prev: {
                mactahoe-gtk-theme = prev.stdenvNoCC.mkDerivation {
                  pname = "mactahoe-gtk-theme";
                  version = "0-unstable-2026-09-10";
                  src = inputs.mactahoe-gtk-src;

                  dontBuild = true;
                  dontConfigure = true;

                  installPhase = ''
                    runHook preInstall
                    mkdir -p $out/share/themes
                    tar -xf release/MacTahoe-Dark.tar.xz -C $out/share/themes
                    runHook postInstall
                  '';
                };
              })
            ];
          }
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.maerllyn = import ./home.nix;
          }
        ];
      };
    };
}
