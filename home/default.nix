# Entry point for all user-level (Home Manager) configuration.
{ lib, username, ... }:

{
  imports = [
    ./applications.nix
    ./packages.nix
    ./shell.nix
    # enable gnome
    #./gnome
    # enable hyprland
    # ./hyprland.nix
    # enable kde
    ./kde
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Same meaning as system.stateVersion, but for Home Manager's own state.
  # Do not change it on an existing profile.
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
