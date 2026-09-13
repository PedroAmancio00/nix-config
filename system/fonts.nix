# System fonts.
{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    # Patched monospace font. The glyphs are what make the Starship prompt
    # render correctly instead of showing replacement boxes.
    nerd-fonts.jetbrains-mono
  ];

  # Which font is actually used where is a per-user setting; see
  # home/gnome/interface.nix and home/theming.nix.
}
