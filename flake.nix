{
  description = "Maerllyn's NixOS configuration - Ryzen 9 9950X3D / RTX 5090 / GNOME";

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

    # Declarative Flatpak management.
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    # Upstream source for the MacTahoe GTK theme. Marked `flake = false`
    # because the repository is a plain Git tree with no flake.nix.
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
      ...
    }@inputs:
    let
      system = "x86_64-linux";

      # Single source of truth for the primary user. Passed to both the NixOS
      # and the Home Manager module trees, so the name is never hardcoded twice.
      username = "maerllyn";
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs username; };

        modules = [
          # Custom packages and package overrides.
          { nixpkgs.overlays = [ (import ./overlays inputs) ]; }

          # Declarative Flatpak support.
          inputs.nix-flatpak.nixosModules.nix-flatpak

          # System-level configuration (see ./system/default.nix).
          ./system

          # Home Manager is wired in as a NixOS module, so a single
          # `nixos-rebuild switch` applies both system and user configuration.
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              # Use the system's nixpkgs (with overlays) instead of a second
              # evaluation. Required for `pkgs.mactahoe-gtk-theme` to resolve.
              useGlobalPkgs = true;

              # Install user packages into /etc/profiles/per-user rather than
              # ~/.nix-profile, which keeps the user profile fully declarative.
              useUserPackages = true;

              extraSpecialArgs = { inherit inputs username; };
              users.${username} = import ./home;

              # Delete pre-existing unmanaged files instead of aborting the
              # activation. Everything under Home Manager's control is declared
              # here, so a conflicting file is always stale state.
              backupFileExtension = null;
              backupCommand = "rm -f";
            };
          }
        ];
      };
    };
}
