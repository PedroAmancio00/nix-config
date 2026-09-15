# Appearance, fonts and window decorations.
{ ... }:

{
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      # Must match the theme declared in home/theming.nix.
      gtk-theme = "MacTahoe-Dark";
      icon-theme = "WhiteSur-dark";
      cursor-theme = "Adwaita";

      # Ask applications to prefer their dark variant. Unlike a GTK theme,
      # this is respected by libadwaita apps as well.
      color-scheme = "prefer-dark";
      # Fonts.
      #
      # These are the GNOME defaults, stated explicitly so a future change is
      # a visible diff rather than a surprise. Be careful here: setting any of
      # them to a font that is not installed makes fontconfig fall back
      # unpredictably, and Electron apps then render their entire interface -
      # tabs, sidebars, menus - in the substituted font.
      font-name = "Adwaita Sans 11";
      document-font-name = "Adwaita Sans 11";
      monospace-font-name = "Monospace 11";

      clock-show-weekday = false;
    };

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.0;
    };

    # Titlebar buttons on the right, macOS-style layout notwithstanding.
    # The colon marks the split between the left and right groups.
    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };

    # GNOME Console (kgx) has no font setting of its own and inherits
    # monospace-font-name above. Ptyxis does have one, so the Nerd Font can be
    # scoped to the terminal instead of applied system-wide.
    "org/gnome/Ptyxis" = {
      use-system-font = false;
      font-name = "JetBrainsMono Nerd Font 11";
    };
  };
}
