# Desktop entries, autostart and default applications.
{ config, pkgs, ... }:

{
  xdg = {
    ##############################################################
    # Desktop entries
    #
    # An entry declared here is written to
    # ~/.local/share/applications/<name>.desktop, which takes precedence over
    # the system copy of the same filename. Use the exact upstream filename to
    # override an existing launcher; use a new name to add one.
    ##############################################################

    desktopEntries = {
      # Rebrand Vesktop as "Discord" and give it a custom icon.
      vesktop = {
        name = "Discord";
        genericName = "Discord";
        exec = "vesktop %U";
        icon = "${config.home.homeDirectory}/.icons/meu-icone-customizado.png";
        terminal = false;
        categories = [
          "Network"
          "InstantMessaging"
        ];
        startupNotify = true;
      };

      # Override the packaged launcher to force XWayland.
      #
      # Electron 43 mis-sizes its window under native Wayland here: the
      # conversation list is cut off at the bottom regardless of window size,
      # and the app exposes no zoom control to work around it. Running through
      # XWayland sidesteps the compositor path that causes it.
      "com.github.dagmoller.whatsapp-electron" = {
        name = "Whatsapp";
        exec = "whatsapp-electron --ozone-platform=x11 %u";
        icon = "whatsapp";
        terminal = false;
        categories = [
          "Network"
          "InstantMessaging"
        ];

        settings = {
          # Must match the window class the app actually sets, otherwise the
          # running window does not bind to this launcher's dock icon.
          StartupWMClass = "com.github.dagmoller.whatsapp-electron";
        };
      };

      # Zen ships without libavcodec on its LD_LIBRARY_PATH, so H.264, HEVC
      # and AAC all report as unsupported in about:support - which breaks
      # YouTube live streams and Instagram audio. Point it at system ffmpeg.
      zen = {
        name = "Zen Browser";
        genericName = "Web Browser";
        exec = "env LD_LIBRARY_PATH=${pkgs.ffmpeg.lib}/lib zen --name zen %U";
        icon = "zen";
        terminal = false;
        startupNotify = true;
        categories = [
          "Network"
          "WebBrowser"
        ];
        mimeType = [
          "text/html"
          "text/xml"
          "application/xhtml+xml"
          "application/vnd.mozilla.xul+xml"
          "x-scheme-handler/http"
          "x-scheme-handler/https"
        ];

        settings = {
          StartupWMClass = "zen";
        };

        actions = {
          new-private-window = {
            name = "New Private Window";
            exec = "env LD_LIBRARY_PATH=${pkgs.ffmpeg.lib}/lib zen --private-window %U";
          };
          new-window = {
            name = "New Window";
            exec = "env LD_LIBRARY_PATH=${pkgs.ffmpeg.lib}/lib zen --new-window %U";
          };
          profile-manager-window = {
            name = "Profile Manager";
            exec = "env LD_LIBRARY_PATH=${pkgs.ffmpeg.lib}/lib zen --ProfileManager";
          };
        };
      };
    };

    ##############################################################
    # Autostart
    ##############################################################

    configFile = {
      # mimeapps.list is rewritten by applications whenever the user picks a
      # new default, so Home Manager needs permission to overwrite it.
      "mimeapps.list".force = true;

      # Vesktop starts late so the system tray is up first; without the tray,
      # closing its window quits the app instead of minimising it.
      "autostart/vesktop.desktop".text = ''
        [Desktop Entry]
        Type=Application
        Exec=sh -c "sleep 8 && vesktop"
        Name=Vesktop
        X-GNOME-Autostart-enabled=true
      '';
    };

    ##############################################################
    # Default applications per MIME type
    ##############################################################

    mimeApps = {
      enable = true;

      defaultApplications = {
        # Web
        "text/html" = "zen.desktop";
        "x-scheme-handler/http" = "zen.desktop";
        "x-scheme-handler/https" = "zen.desktop";
        "x-scheme-handler/about" = "zen.desktop";
        "x-scheme-handler/unknown" = "zen.desktop";

        # Text and source files
        "text/plain" = "code.desktop";
        "text/markdown" = "code.desktop";
        "text/x-log" = "code.desktop";
        "text/x-python" = "code.desktop";
        "text/x-csrc" = "code.desktop";
        "text/x-c++src" = "code.desktop";
        "text/x-shellscript" = "code.desktop";
        "application/json" = "code.desktop";
        "application/x-yaml" = "code.desktop";
      };
    };
  };
}
