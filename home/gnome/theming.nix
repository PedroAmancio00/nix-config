# GTK theme, icons and fonts.
#
# These options generate ~/.gtkrc-2.0 and ~/.config/gtk-{3,4}.0/settings.ini.
# They are what non-GNOME toolkits - and Electron apps such as VS Code - read
# to decide how to draw their own chrome.
#
# Leaving `font` unset here produces settings.ini without a `gtk-font-name`
# line, which makes Electron fall back to an unpredictable font for its entire
# UI. Keep it declared, and keep it matching the dconf values in
# gnome/interface.nix.
{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "MacTahoe-Dark";
      package = pkgs.mactahoe-gtk-theme;
    };

    font = {
      name = "Adwaita Sans";
      size = 11;
    };
  };
}
