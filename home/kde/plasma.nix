# KDE Plasma workspace configuration, via plasma-manager.
#
# NOTE: plasma-manager takes full ownership of whatever it manages. Once
# `panels` is declared, every panel not listed here is removed on the next
# login - there is no partial management. The same applies to window rules.
{ ... }:

{
  programs.plasma = {
    enable = true;
    overrideConfig = true;

    ##############################################################
    # Appearance
    ##############################################################

    workspace = {
      # The Global Theme. This is the option that actually switches the whole
      # workspace to dark; setting only colorScheme leaves parts of the shell
      # light. Run `plasma-apply-lookandfeel --list` for valid values.
      lookAndFeel = "org.kde.breezedark.desktop";

      # The Plasma desktop theme (panel and widget styling). Use the internal
      # name, not the display name - `plasma-apply-desktoptheme --list-themes`.
      theme = "breeze-dark";

      # Application colour scheme. Run `plasma-apply-colorscheme --list-schemes`.
      colorScheme = "BreezeDark";

      iconTheme = "Colloid-Purple-Dracula-Dark";
    };

    ##############################################################
    # Raw config files
    #
    # For anything plasma-manager has no dedicated option for. Keys map
    # directly onto the files in ~/.config.
    ##############################################################

    configFile = {
      "kwinrc"."Windows" = {
        # Placement: 0 = Smart, 1 = Maximizing, 2 = Cascade, 3 = Random, 4 = Centered, 5 = Zero-Cornered, 6 = Under Mouse
        Placement = "Centered";
      };
      # Desliga “lembrar posição” (ajuda muito no multi-monitor)
      "kwinrc"."Windows"."AllowWindowActivation" = true;
      kcminputrc = {
        Mouse = {
          cursorHighlight = false;
          XLbInptAccelProfileFlat = true;
          XLbInptPointerAcceleration = 0;
        };
      };

      kwinrc = {
        Plugins = {
          blurEnabled = true;
          translucencyEnabled = true;
          shakecursorEnabled = false;
        };
      };
    };

    kscreenlocker = {
      autoLock = false;
      lockOnResume = false;
    };

    powerdevil.AC = {
      autoSuspend.action = "nothing";
      dimDisplay.idleTimeout = 300;
      turnOffDisplay.idleTimeout = 600;
      powerButtonAction = "showLogoutScreen";
    };

    window-rules = [
      {
        description = "Abrir sempre no monitor principal";
        match = {
          # casa com praticamente todas as janelas normais
          window-types = [ "normal" ];
        };
        apply = {
          # 0 = primeiro monitor na ordem de prioridade do KDE (= seu primary / DP-1)
          screen = {
            value = 0;
            apply = "force";
          };
          # ignora a geometria que o app pede (senão ele volta pro 2º monitor)
          ignoregeometry = {
            value = true;
            apply = "force";
          };
        };
      }
    ];

    ##############################################################
    # Panels
    ##############################################################

    panels = [
      # Bottom dock: pinned launchers and running tasks.
      {
        location = "bottom";
        height = 56;
        hiding = "autohide";
        lengthMode = "fit";
        floating = true;

        widgets = [
          {
            name = "org.kde.plasma.icontasks";
            config.General.launchers = [
              "applications:org.kde.dolphin.desktop"
              "applications:org.kde.konsole.desktop"
              "applications:zen.desktop"
              "applications:code.desktop"
              "applications:steam.desktop"
              "applications:vesktop.desktop"
              "applications:spotify.desktop"
            ];
          }
        ];
      }

      # Top bar: menu, tray and clock.
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
