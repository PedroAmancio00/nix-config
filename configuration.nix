# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ inputs, config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./kernel.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,br";
    variant = "";
    options = "grp:alt_shift_toggle";  # Alt+Shift alterna entre os layouts
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # Configuração de qualidade de áudio: 32-bit float, 192kHz
    extraConfig.pipewire."92-audio-quality" = {
      "context.properties" = {
        "default.clock.rate" = 192000;
        "default.clock.allowed-rates" = [ 44100 48000 88200 96000 176400 192000 ];
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 8192;
      };
    };

    wireplumber.extraConfig."51-alsa-config".monitor.alsa = {
      rules = [
        {
          matches = [ { "node.name" = "~alsa_output.*"; } ];
          actions = {
            update-props = {
              "audio.format" = "S32LE";
              "audio.rate" = 192000;
            };
          };
        }
      ];
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."maerllyn" = {
    isNormalUser = true;
    description = "Maerllyn";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
    shell = pkgs.fish;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?


  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # abre portas pro Remote Play
    dedicatedServer.openFirewall = true; # abre portas se hospedar servidores
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false; # opcional: remove linha em branco antes do prompt
    };
  };

  programs.fish = {
    enable = true;

    # Equivalente ao conteúdo do config.fish
    interactiveShellInit = ''
      set -g fish_greeting ""  # remove a mensagem de boas-vindas
      fastfetch
    '';

    shellAliases = {
      upgrade = "sudo nix flake update --flake /etc/nixos";
      update = "sudo nixos-rebuild switch";
    };
  };
  time.hardwareClockInLocalTime = true;

  services.libinput.enable = true;

  services.libinput.mouse = {
    accelProfile = "flat";
    accelSpeed = "0";
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    libGL
    fontconfig
    freetype
    glib
    libxkbcommon
    vulkan-loader
    libx11
    libxcursor
    libxrandr
    libxi
    libxext
    libxrender
    libxtst
    libxml2_13
    gdk-pixbuf
    alsa-lib
    dbus
    expat
    nss
    nspr
    atk
    cups
    gtk3
    pango
    cairo
    udev
    icu
    ncurses
  ];
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
      vscode
      spotify
      psmisc
      fastfetch
      git
      github-desktop
      git-credential-manager

      # Python
      python3
      btop

      # Node.js
      nodejs_24

      dotnet-sdk_10

      # Java
      jdk25

      vesktop
      whatsapp-electron

      hunspell
      hunspellDicts.en_US
      hunspellDicts.pt_BR

      xsettingsd
      xrdb
      mangohud
      gamemode
      gamescope
      protonplus
      whitesur-kde
      whitesur-icon-theme
      kdePackages.qqc2-desktop-style
      kdePackages.qtstyleplugin-kvantum
      
      (colloid-icon-theme.override {
        schemeVariants = [ "dracula" ];
        colorVariants = [ "purple" ];
      })
      (unityhub.override {
        extraLibs = pkgs: [ pkgs.p7zip ];
      })

      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];


}
