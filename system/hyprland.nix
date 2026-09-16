# Hyprland compositor, installed alongside GNOME for evaluation.
{ ... }:

{
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
