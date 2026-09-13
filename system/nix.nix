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
  nix.gc = {
  automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d"; 
  };
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
  # Required by Steam, NVIDIA drivers, VS Code, Spotify and others.
  nixpkgs.config.allowUnfree = true;
}
