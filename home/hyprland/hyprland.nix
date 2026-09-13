# Minimal Hyprland session config, kept separate from home/gnome/ since it's
# only used to test HDR-through-Gamescope (see system/hardware/gpu.nix).
{ ... }:

{
  home.file.".config/hypr/hyprland.conf".text = ''
    monitor=,3840x2160@240,auto,1,cm,hdr,bitdepth,10

    exec-once = waybar
    exec-once = swaybg -i ~/Pictures/Wallpapers/wallpaper.jpg

    $terminal = kitty
    $menu = wofi --show drun

    bind = SUPER, RETURN, exec, $terminal
    bind = SUPER, D, exec, $menu
    bind = SUPER, Q, killactive
    bind = SUPER, M, exit
  '';
}