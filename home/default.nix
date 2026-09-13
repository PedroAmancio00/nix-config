# Entry point for all user-level (Home Manager) configuration.
{ username, ... }:

{
  imports = [
    ./gnome
    ./theming.nix
    ./applications.nix
    ./packages.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Same meaning as system.stateVersion, but for Home Manager's own state.
  # Do not change it on an existing profile.
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
