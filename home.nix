{ inputs, config, pkgs, ... }:

{
  home.username = "maerllyn";
  home.homeDirectory = "/home/maerllyn";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  qt = {
    enable = true;
    platformTheme.name = "kde";
    style.name = "kvantum";

    kvantum = {
      enable = true;
      themes = [ pkgs.whitesur-kde ];
      settings.General.theme = "WhiteSurDark";
    };
  };

  xdg = {
    desktopEntries.vesktop = {
      name = "Discord";
      genericName = "Discord";
      exec = "vesktop %U";
      icon = "/home/maerllyn/.icons/meu-icone-customizado.png";
      terminal = false;
      categories = [ "Network" "InstantMessaging" ];
      startupNotify = true;
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

  programs.plasma = {
    enable = true;
    configFile = {
      kcminputrc = {
        Mouse = {
          cursorHighlight = false;
        };
      };
      kwinrc = {
        "org.kde.kdecoration2" = {
          library = "org.kde.kwin.aurorae";
          theme = "__aurorae__svg__WhiteSur-dark";
        };
        Plugins = {
          blurEnabled = true;
          translucencyEnabled = true;
        };
      };
      kdeglobals = {
        KDE.widgetStyle = "kvantum";
      };
      "plasmarc"."PlasmaViews.Panel"."panelOpacity" = 0;
    };

    workspace = {
      theme = "WhiteSur-dark";
      iconTheme = "WhiteSur-dark";
    };

    panels = [
      {
        location = "bottom";
        height = 56;
        hiding = "autohide";
        lengthMode = "fit";
        floating = true;
        widgets = [
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General = {
                launchers = [
                  "applications:org.kde.dolphin.desktop"
                  "applications:org.kde.konsole.desktop"
                  "applications:zen.desktop"
                  "applications:code.desktop"
                  "applications:steam.desktop"
                  "applications:vesktop.desktop"
                  "applications:spotify.desktop"
                ];
              };
            };
          }
        ];
      }
      {
        location = "top";
        height = 36;
        hiding = "autohide";
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
        ];
      }
    ];
  };
}