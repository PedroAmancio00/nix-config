# Display server, display manager and desktop portals.
{ pkgs, ... }:

{
  # Keeps XWayland and the X11 toolchain available. The session itself runs
  # on Wayland; this does not force an X11 session.
  services.xserver.enable = true;

  # --- GNOME (disabled) ---
  # services.displayManager.gdm.enable = true;
  # services.desktopManager.gnome.enable = true;

  # --- KDE Plasma (active) ---
  services.displayManager.sddm = {
    enable = true;

    # Run the greeter itself on Wayland. Without this SDDM starts an X
    # server just to draw the login screen, which on NVIDIA means the
    # proprietary driver is initialised twice.
    wayland.enable = true;
  };

  services.desktopManager.plasma6.enable = true;

  # Keyboard layout for the login screen and for TTYs.
  #
  # A Wayland session manages XKB itself and does not read this: GNOME took
  # its layouts from dconf, and Plasma takes them from kxkbrc. Configure the
  # session layout in home/kde/ if it needs to differ from the login screen.
  services.xserver.xkb = {
    layout = "us,br";
    variant = "";
    options = "grp:alt_shift_toggle";
  };

  # XDG portals back the file chooser, screen sharing and "open with" dialogs
  # used by Flatpak and Electron applications.
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;

    extraPortals = [
      # --- GNOME (disabled) ---
      # pkgs.xdg-desktop-portal-gnome

      # --- KDE Plasma (active) ---
      pkgs.kdePackages.xdg-desktop-portal-kde
    ];
  };
}
