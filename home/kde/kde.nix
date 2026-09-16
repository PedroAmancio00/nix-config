# KDE Plasma tooling and applications.
#
# The desktop session itself is enabled in ./desktop.nix; this file only adds
# software on top of it.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Qt/Plasma integration ---
    # Required for Qt Quick Controls applications to pick up the desktop
    # style instead of falling back to the default look.
    kdePackages.qqc2-desktop-style

    # Syncs the GTK theme with Plasma's appearance settings.
    kdePackages.kde-gtk-config

    # --- Applications ---
    kdePackages.kate
    kdePackages.filelight # disk usage
    kdePackages.kcalc
  ];

  # Plasma applications that ship by default but are not used here. Add
  # entries rather than uninstalling by hand.
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    elisa # music player - Spotify is used instead
    khelpcenter
    kwrited # console message daemon
  ];
}
