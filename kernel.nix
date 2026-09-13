# kernel.nix — Ryzen 9 9950X3D + RTX 5090 + 96 GB RAM
{ config, lib, pkgs, ... }:

{
  ############################################################
  # KERNEL
  ############################################################

  boot.kernelPackages = pkgs.linuxPackages_zen;

  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "amd_pstate=active"
    "mitigations=off"
  ];

  boot.kernelModules = [ "kvm-amd" "ntsync" ];

  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  ############################################################
  # CPU — Ryzen 9 9950X3D (Zen 5)
  ############################################################

  hardware.enableRedistributableFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "performance";

  ############################################################
  # GPU — RTX 5090 (Blackwell)
  ############################################################

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.new_feature;
  };

  ############################################################
  # MEMÓRIA — 96 GB
  ############################################################

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "50%";
  };

  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"
  '';

  boot.kernel.sysctl = {
    "vm.swappiness" = 180;
    "vm.page-cluster" = 0;
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.dirty_bytes" = 268435456;
    "vm.dirty_background_bytes" = 67108864;
    "vm.max_map_count" = 2147483642;
  };

  systemd.services.amd-x3d-mode = {
    description = "Set AMD 3D V-Cache mode";
    wantedBy = [ "multi-user.target" ];
    after = [ "sysinit.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      echo cache > /sys/bus/platform/drivers/amd_x3d_vcache/AMDI0101:00/amd_x3d_mode
    '';
  };
}
