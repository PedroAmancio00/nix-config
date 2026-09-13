# System-wide packages, grouped by purpose.
#
# GNOME tooling lives in ./gnome.nix, fonts in ./fonts.nix, and anything the
# gaming/development modules install themselves is not repeated here.
{ inputs, pkgs, ... }:

{
  environment.systemPackages =
    (with pkgs; [
      # ----------------------------------------------------------------
      # Browsers
      # ----------------------------------------------------------------
      chromium

      # ----------------------------------------------------------------
      # Development
      # ----------------------------------------------------------------
      vscode
      git
      github-desktop
      git-credential-manager

      # Language runtimes and SDKs
      python3
      nodejs_24
      dotnet-sdk_10
      jdk25

      (unityhub.override {
        # Unity's asset pipeline shells out to 7-Zip.
        extraLibs = pkgs: [ pkgs.p7zip ];
      })

      # ----------------------------------------------------------------
      # Communication
      # ----------------------------------------------------------------
      vesktop # Discord client
      whatsapp-electron
      teamspeak6-client

      # ----------------------------------------------------------------
      # Media
      # ----------------------------------------------------------------
      spotify

      # ----------------------------------------------------------------
      # Terminal and system utilities
      # ----------------------------------------------------------------
      ptyxis # GNOME terminal
      fastfetch # system summary, run on shell start
      btop # process/resource monitor
      psmisc # killall, fuser, pstree
      jq # JSON processor
      pciutils # lspci
      usbutils # lsusb

      # Provides `pactl`, which the Steam client shells out to for volume
      # control. PipeWire's pulse layer answers it.
      pulseaudio

      # ----------------------------------------------------------------
      # Gaming (see also ./gaming.nix)
      # ----------------------------------------------------------------
      mangohud # in-game performance overlay
      protonplus # Proton/Wine version manager
      vulkan-tools # vulkaninfo, vkcube - useful for driver diagnostics

      # ----------------------------------------------------------------
      # Theming
      # ----------------------------------------------------------------
      whitesur-icon-theme
      xsettingsd # serves settings to X11/XWayland clients
      xrdb

      # ----------------------------------------------------------------
      # Spell checking
      # ----------------------------------------------------------------
      hunspell
      hunspellDicts.en_US
      hunspellDicts.pt_BR

      file
    ])
    ++ [
      # Packages that come from flake inputs rather than nixpkgs.
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
}
