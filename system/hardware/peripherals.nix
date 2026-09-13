# Input devices and printing.
{ ... }:

{
  services.libinput.enable = true;

  # Raw mouse input: no acceleration curve, no speed adjustment. What the
  # sensor reports is what the cursor does.
  services.libinput.mouse = {
    accelProfile = "flat";
    accelSpeed = "0";
  };

  services.printing.enable = true;
}
