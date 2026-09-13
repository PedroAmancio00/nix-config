# Packages installed for this user only.
#
# Most software is declared system-wide in system/packages.nix. Use this file
# for tools that are genuinely personal, or that you want to be able to change
# without touching the system closure.
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # (empty for now)
  ];
}
