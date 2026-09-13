{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "maerllyn";
  home.homeDirectory = "/home/maerllyn";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  xdg = {
    desktopEntries = {
      vesktop = {
        name = "Discord";
        genericName = "Discord";
        exec = "vesktop %U";
        icon = "/home/maerllyn/.icons/meu-icone-customizado.png";
        terminal = false;
        categories = [ "Network" "InstantMessaging" ];
        startupNotify = true;
      };

      "com.github.dagmoller.whatsapp-electron" = {
        name = "Whatsapp";
        exec = "whatsapp-electron --ozone-platform=x11 %u";
        icon = "whatsapp";
        terminal = false;
        categories = [ "Network" "InstantMessaging" ];
        settings = {
          StartupWMClass = "com.github.dagmoller.whatsapp-electron";
        };
      };
    };



    configFile = {
      "mimeapps.list".force = true;
      "autostart/vesktop.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Exec=sh -c "sleep 8 && vesktop"
        Name=Vesktop
        X-GNOME-Autostart-enabled=true
      '';
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        # Web browser
        "text/html" = "zen.desktop";
        "x-scheme-handler/http" = "zen.desktop";
        "x-scheme-handler/https" = "zen.desktop";
        "x-scheme-handler/about" = "zen.desktop";
        "x-scheme-handler/unknown" = "zen.desktop";

        # Text/code files
        "text/plain" = "code.desktop";
        "text/x-python" = "code.desktop";
        "text/x-csrc" = "code.desktop";
        "text/x-c++src" = "code.desktop";
        "application/json" = "code.desktop";
        "application/x-yaml" = "code.desktop";
        "text/x-shellscript" = "code.desktop";
        "text/markdown" = "code.desktop";
        "text/x-log" = "code.desktop";
      };
    };
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      gtk-theme = "MacTahoe-Dark";
      icon-theme = "WhiteSur-dark";
      color-scheme = "prefer-dark";
      cursor-theme = "Adwaita";
      font-name = "Adwaita Sans 11";
      clock-show-weekday = true;
      document-font-name = "Adwaita Sans 11";
      monospace-font-name = "Monospace 11";
    };

    "org/gnome/Ptyxis" = {
      use-system-font = false;
      font-name = "JetBrainsMono Nerd Font 11";
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
        "clipboard-indicator@tudmotu.com"
        "azwallpaper@azwallpaper.gitlab.com"
      ];
      favorite-apps = [
        "zen.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Ptyxis.desktop"
        "code.desktop"
        "vesktop.desktop"
        "com.github.dagmoller.whatsapp-electron.desktop"
        "spotify.desktop"
        "steam.desktop"
      ];
    };

    "org/gnome/shell/extensions/user-theme".name = "MacTahoe-Dark";

    "org/gnome/shell/extensions/dash-to-dock" = {
      dock-position = "BOTTOM";
      extend-height = false;
      dash-max-icon-size = 52;
      show-trash = false;
      click-action = "minimize-or-previews";
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-input-source = [ ];
      switch-input-source-backward = [ ];
    };

    "org/gnome/shell/keybindings" = {
      toggle-message-tray = [ "<Super>space" ];
      show-screenshot-ui = [ "<Super><Shift>s" ];
    };

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
      xkb-options = [ "grp:alt_shift_toggle" ];
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = true;
      static-blur = false; # false = dinâmico
      style-panel = 0;
      override-background = true;
    };
    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = true;
      dynamic-opacity = true;
      opacity = 230;
      blur-on-overview = false;
      enable-all = false;
    };
    "org/gnome/shell/extensions/clipboard-indicator" = {
      toggle-menu = [ "<Super>v" ];
      history-size = 200;
    };

    "org/gnome/shell/extensions/azwallpaper" = {
      slideshow-directory = "/home/maerllyn/Pictures/Wallpapers";
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

    "org/gnome/desktop/screensaver" = {
      lock-enabled = false;
      idle-activation-enabled = false;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";
      idle-dim = true;
    };

    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 600;
    };

    "org/gnome/desktop/notifications".show-banners = true;

    "org/gnome/mutter".experimental-features = [ "scale-monitor-framebuffer"];
  };

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