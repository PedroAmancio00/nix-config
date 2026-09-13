# Storage tuning.
{ ... }:

{
  # NVMe devices handle their own command scheduling; the kernel's I/O
  # schedulers only add latency. "none" hands requests straight to the device.
  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="nvme[0-9]*", ATTR{queue/scheduler}="none"
  '';
}
