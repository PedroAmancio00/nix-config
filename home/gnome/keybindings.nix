# Keyboard shortcuts and input sources.
{ lib, ... }:

{
  dconf.settings = {
    ##############################################################
    # Input sources
    ##############################################################

    "org/gnome/desktop/input-sources" = {
      sources = [
        (lib.hm.gvariant.mkTuple [
          "xkb"
          "us"
        ])
        (lib.hm.gvariant.mkTuple [
          "xkb"
          "br"
        ])
      ];

      # Under Wayland, Mutter owns XKB and reads options from here rather than
      # from services.xserver.xkb. Alt+Shift is handled at the XKB level
      # because GNOME shortcuts cannot be bound to modifier keys alone.
      xkb-options = [ "grp:alt_shift_toggle" ];
    };

    "org/gnome/desktop/wm/keybindings" = {
      # Cleared so the XKB toggle above is the only thing switching layouts;
      # leaving GNOME's own binding in place makes the two fight.
      switch-input-source = [ ];
      switch-input-source-backward = [ ];
    };

    ##############################################################
    # Shell shortcuts
    ##############################################################

    "org/gnome/shell/keybindings" = {
      # Moved off its Super+V default to free that combination for the
      # clipboard history extension.
      toggle-message-tray = [ "<Super>space" ];

      # Screenshot UI. Super+Shift+S rather than Ctrl+Shift+S, which would
      # shadow "Save as" inside applications.
      show-screenshot-ui = [ "<Super><Shift>s" ];
    };
  };
}
