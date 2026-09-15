# CPU - AMD Ryzen 9 9950X3D (Zen 5, dual CCD with 3D V-Cache).
{ ... }:

{
  hardware.cpu.amd.updateMicrocode = true;

  # Desktop on mains power: favour clocks over power saving.
  powerManagement.cpuFreqGovernor = "performance";

  # The 9950X3D has one CCD with 3D V-Cache and one without. The kernel driver
  # exposes which CCD the scheduler should prefer:
  #
  #   cache     - prefer the V-Cache CCD. Larger L3, better for games and
  #               simulation-heavy workloads.
  #   frequency - prefer the non-cache CCD. Higher boost clocks, better for
  #               single-threaded compilation and rendering.
  #
  # The kernel resets this on every boot, so a oneshot unit reapplies it.
  # The AMDI0101:00 device path is board-specific; if this unit starts failing
  # after a hardware change, check the path under
  # /sys/bus/platform/drivers/amd_x3d_vcache/.
  systemd.services.amd-x3d-mode = {
    description = "Set AMD 3D V-Cache mode";
    wantedBy = [ "multi-user.target" ];
    after = [ "sysinit.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };

    script = ''
      echo frequency > /sys/bus/platform/drivers/amd_x3d_vcache/AMDI0101:00/amd_x3d_mode
    '';
  };
}
