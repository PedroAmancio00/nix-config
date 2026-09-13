# GNOME tooling and Shell extensions.
#
# Installing an extension only makes it available. Enabling it and setting its
# options happens per-user, in home/gnome/.
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # --- Configuration tools ---
    gnome-tweaks
    dconf-editor

    # --- Shell extensions ---
    gnome-shell-extensions # bundle that provides user-themes
    gnomeExtensions.user-themes # allows a custom Shell theme
    gnomeExtensions.dash-to-dock # macOS-style dock
    gnomeExtensions.blur-my-shell # panel/dash/window blur
    gnomeExtensions.clipboard-indicator # clipboard history
    gnomeExtensions.wallpaper-slideshow # rotating wallpaper (azwallpaper)

    # System tray icons. GNOME dropped the legacy tray; this restores it for
    # apps like Vesktop and Spotify.
    #
    # WARNING: upstream MacTahoe lists this extension as incompatible with
    # Blur My Shell. If blur stops working, disable this one first.
    gnomeExtensions.appindicator
  ];

  # Remove GNOME applications that are not used on this machine. Add entries
  # here rather than uninstalling them by hand.
  # environment.gnome.excludePackages = with pkgs; [ gnome-tour ];
}
