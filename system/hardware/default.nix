# Hardware-specific configuration, split by subsystem.
{ ... }:

{
  imports = [
    ./cpu.nix
    ./gpu.nix
    ./memory.nix
    ./storage.nix
    ./audio.nix
    ./peripherals.nix
  ];

  # Firmware blobs with a redistributable licence (Wi-Fi, Bluetooth, GPU).
  hardware.enableRedistributableFirmware = true;
}
