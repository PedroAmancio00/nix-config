# Qt and GTK appearance.
#
# Plasma themes Qt applications by itself (see workspace.* in ./plasma.nix),
# but GTK applications - and Electron apps such as VS Code and Zen - read
# ~/.gtkrc-2.0 and ~/.config/gtk-{3,4}.0/settings.ini instead. Without the
# block below they render light while everything else is dark.
{ pkgs, ... }:

let
  # Also used as the Plasma icon theme in ./plasma.nix - keep the names in
  # sync. Declaring the package here installs it; it does not need to be
  # repeated in home/packages.nix.
  colloid = pkgs.colloid-icon-theme.override {
    schemeVariants = [ "dracula" ];
    colorVariants = [ "purple" ];
  };
in
{
  qt = {
    enable = true;

    # Routes Qt applications through Plasma's own theming, so they follow the
    # colour scheme set in ./plasma.nix.
    platformTheme.name = "kde";
  };

  gtk = {
    enable = true;

    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };

    iconTheme = {
      name = "Colloid-Purple-Dracula-Dark";
      package = colloid;
    };

    cursorTheme = {
      name = "breeze_cursors";
      package = pkgs.kdePackages.breeze;
      size = 24;
    };

    # Leaving `font` unset produces a settings.ini without a gtk-font-name
    # line, which makes Electron fall back to an unpredictable font for its
    # whole UI - tabs, sidebars, menus included.
    font = {
      name = "Noto Sans";
      size = 10;
    };

    # libadwaita applications ignore the GTK theme entirely, but they do
    # honour this hint, which is what switches them to their dark variant.
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  # Tells libadwaita and portal-aware applications that dark is preferred.
  dconf.settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
}
