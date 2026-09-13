# Bootloader, kernel selection and kernel-level tuning.
{ pkgs, ... }:

{
  ##############################################################
  # Bootloader
  ##############################################################

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ##############################################################
  # Kernel
  ##############################################################

  # Zen kernel: desktop-oriented scheduler and latency tuning.
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # sched_ext userspace scheduler. LAVD ("Latency-criticality Aware Virtual
  # Deadline") is tuned for interactive and gaming workloads.
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
  };

  boot.kernelParams = [
    # Required for Wayland on NVIDIA.
    "nvidia-drm.modeset=1"

    # Hand frequency scaling to the AMD P-State driver (Zen 5).
    "amd_pstate=active"

    # Disable CPU speculative-execution mitigations. Trades security hardening
    # for throughput - reasonable on a single-user desktop, not on a server.
    "mitigations=off"
  ];

  boot.kernelModules = [
    "kvm-amd" # AMD-V virtualisation
    "ntsync" # Wine/Proton synchronisation primitives
  ];

  # Load the NVIDIA stack in the initrd so the framebuffer is driven by the
  # proprietary driver from the very first frame (no console flicker on boot).
  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  ##############################################################
  # /tmp
  ##############################################################

  # Back /tmp with tmpfs. With 96 GB of RAM this keeps build artefacts and
  # Steam shader compilation off the SSD entirely.
  boot.tmp = {
    useTmpfs = true;
    tmpfsSize = "50%";
  };
}
