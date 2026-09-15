# Per-extension settings.
#
# Only configuration keys belong here. Extensions also store runtime state in
# dconf (current slide index, queue contents, timers); declaring those would
# reset the extension on every rebuild.
{ config, lib, ... }:

{
  dconf.settings = {
    ##############################################################
    # Blur My Shell
    ##############################################################

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
      # false = dynamic blur, sampling whatever is behind the panel in real
      # time. true would freeze a single snapshot of the wallpaper instead.
      static-blur = false;
      style-panel = 0;
      override-background = true;
    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      static-blur = false;
      blur = true;
      dynamic-opacity = true;
      opacity = 210; # 0-255
      blur-on-overview = false;
      enable-all = true; # opt in per application rather than globally
    };

    ##############################################################
    # Clipboard Indicator
    ##############################################################

    "org/gnome/shell/extensions/clipboard-indicator" = {
      # Super+V is bound to the message tray by default; that binding is
      # moved aside in ./keybindings.nix so this one can take effect.
      toggle-menu = [ "<Super>v" ];
      history-size = 200;
    };

    ##############################################################
    # Wallpaper Slideshow (azwallpaper)
    ##############################################################

    "org/gnome/shell/extensions/azwallpaper" = {
      slideshow-directory = "${config.home.homeDirectory}/Pictures/Wallpapers";

      # Tuple of (hours, minutes, seconds) per slide.
      slideshow-slide-duration = lib.hm.gvariant.mkTuple [
        0
        10
        0
      ];

      slideshow-queue-sort-type = "Random";
      slideshow-queue-reshuffle-on-complete = true;
      slideshow-pause-on-fullscreen = false;
      slideshow-pause-notifications = true;
      slideshow-show-quick-settings-entry = true;
      slideshow-use-absolute-time-for-duration = false;
    };

    # Note: org/gnome/desktop/background is intentionally NOT declared. The
    # extension rewrites picture-uri on every change, and a declared value
    # would be restored on each rebuild, freezing the slideshow on one image.

    ##############################################################
    # Dash to Dock
    ##############################################################

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      extend-height = false; # floating dock rather than a full-width bar
      dash-max-icon-size = 52;
      show-trash = false;
      click-action = "minimize-or-previews";
      dock-fixed = false; # false = permite auto-hide (obrigatório)
      autohide = true; # ativa o auto-hide de fato
      intellihide = false; # false = sempre esconde, não só quando tem janela sobrepondo
      autohide-in-fullscreen = true; # também esconde em tela cheia

      hide-delay = 0.2; # tempo (segundos) até esconder depois que o mouse sai
      show-delay = 0.1; # tempo até aparecer quando o mouse chega na borda
      transparency-mode = "DEFAULT";
      running-indicator-style = "DOTS";
    };

    "org/gnome/shell/extensions/hidetopbar" = {
      enable-active-window = false;
      enable-intellihide = false; # false = sempre esconde, igual ao dash-to-dock
      mouse-sensitive = true;
      mouse-sensitive-fullscreen-window = true;
      animation-time = 0.2;
      show-in-overview = true;
    };
  };
}
