# Packages installed for this user only.
#
# Most software is declared system-wide in system/packages.nix. Use this file
# for tools that are genuinely personal, or that you want to be able to change
# without touching the system closure.
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # NOTE: the Colloid icon theme moved to home/kde/theming.nix, where it is
    # installed as gtk.iconTheme.package. Declaring it here as well would
    # build the same derivation into two profile paths.
  ];
}
