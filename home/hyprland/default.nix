# GNOME settings, written to the user's dconf database.
#
# Each file below owns a distinct set of dconf paths. Keep it that way: two
# modules defining the same path is legal but makes the effective value hard
# to trace.
#
# To discover the key behind a setting, run `dconf watch /` and change it in
# the GUI - the exact path and value are printed as you go.
{ ... }:

{
  imports = [
    ./hyprland.nix
  ];
}
