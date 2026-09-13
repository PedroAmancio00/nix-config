# GPU - NVIDIA GeForce RTX 5090 (Blackwell).
{ config, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];
  services.lact.enable = true;

  hardware.graphics = {
    enable = true;
    # 32-bit drivers, required by Steam and most Proton titles.
    enable32Bit = true;
  };

  hardware.nvidia = {
    # Open kernel modules. Required on Blackwell, and a prerequisite for
    # variable refresh rate under Wayland.
    open = true;

    # KMS. Must stay enabled for Wayland sessions.
    modesetting.enable = true;

    powerManagement.enable = true;

    # Installs nvidia-settings.
    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.new_feature;
  };

  # Display configuration (resolution, scale, refresh rate, VRR and HDR) is
  # NOT declared here. GNOME stores it per physical monitor in
  # ~/.config/monitors.xml, keyed by vendor/model/serial, and rewrites the
  # file whenever settings change. Pinning it from Nix would make the
  # Settings > Displays panel read-only. Configure it through the GUI.
  #
  # Known limitation: HDR does not pass through a nested Gamescope session
  # under GNOME. Gamescope reads the display's HDR metadata but reports
  # bExposeHDRSupport=false, because Mutter does not yet expose the Wayland
  # colour-management protocol it needs. For HDR titles, launch them without
  # Gamescope, or run Gamescope from a bare TTY where it drives KMS directly.
}
