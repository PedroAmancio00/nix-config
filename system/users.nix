# User accounts.
{ pkgs, username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    description = "Maerllyn";

    extraGroups = [
      "networkmanager"
      "wheel" # sudo
    ];

    shell = pkgs.fish;

    # Prefer declaring software in ./packages.nix (system-wide) or in
    # home/ (per-user). This list is for things that are genuinely
    # account-specific.
    packages = with pkgs; [
      # Leftover from the KDE setup - remove if unused under GNOME.
      kdePackages.kate
    ];
  };
}
