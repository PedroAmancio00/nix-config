# Entry point for the KDE Plasma user configuration.
{ ... }:

{
  imports = [
    ./plasma.nix
    ./theming.nix
  ];
}
