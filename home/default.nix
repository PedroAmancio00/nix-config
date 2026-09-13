# Entry point for all user-level (Home Manager) configuration.
{ lib, username, ... }:

{
  imports = [
    ./gnome
    ./theming.nix
    ./applications.nix
    ./packages.nix
    ./hyprland
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  # Same meaning as system.stateVersion, but for Home Manager's own state.
  # Do not change it on an existing profile.
  home.stateVersion = "26.05";

  home.activation.fixSteamIcons = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  for f in ~/.local/share/applications/*.desktop; do
    id=$(grep -Eo 'steam://rungameid/[0-9]+' "$f" | sed 's#.*/##') || true
    [ -n "$id" ] || continue

    want="StartupWMClass=steam_app_$id"

    if ! grep -q "^StartupWMClass=" "$f"; then
      echo "$want" >> "$f"
    fi
  done
'';

  programs.home-manager.enable = true;
}
