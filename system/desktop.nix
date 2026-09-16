# Display server, display manager and desktop portals.
{ pkgs, ... }:

{
  # Keeps XWayland and the X11 toolchain available. The session itself runs
  # on Wayland; this does not force an X11 session.
  services.xserver.enable = true;

  # enable Gnome
  #services.displayManager.gdm.enable = true;
  #services.desktopManager.gnome.enable = true;
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Keyboard layout for the login screen and for TTYs. Note that under a
  # Wayland GNOME session, Mutter manages XKB itself and reads its layouts
  # from dconf instead - see home/gnome/keybindings.nix.
  services.xserver.xkb = {
    layout = "us,br";
    variant = "";
    options = "grp:alt_shift_toggle";
  };

  # XDG portals back the file chooser, screen sharing and "open with" dialogs
  # used by Flatpak, Electron apps and GNOME Shell extension preferences.
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    # The GNOME backend is normally pulled in by the desktop module, but
    # naming it explicitly avoids falling back to the GTK portal when another
    # backend is also present.
    extraPortals = [
      #enable gnome
      #pkgs.xdg-desktop-portal-gnome

      #enable kde
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
  };
}
