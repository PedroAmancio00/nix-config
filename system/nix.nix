# Nix daemon and nixpkgs behaviour.
{ ... }:

{
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    # Silence the "Git tree is dirty" warning on every rebuild. The flake is
    # evaluated from the working tree either way.
    warn-dirty = false;
  };

  # Required by Steam, NVIDIA drivers, VS Code, Spotify and others.
  nixpkgs.config.allowUnfree = true;
}
