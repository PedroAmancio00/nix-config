# User accounts.
{ pkgs, username, ... }:

let
  avatarSource = "/home/${username}/Pictures/Avatar/Avatar.png";
  avatarIcon = "/var/lib/AccountsService/icons/${username}";
  avatarUserFile = "/var/lib/AccountsService/users/${username}";
in
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

  # GNOME/GDM avatar. AccountsService owns this state under /var/lib and
  # rewrites its ini file itself (e.g. on language changes), so it can't be
  # declared as a plain Nix-managed file - this activation script instead
  # keeps the icon and the Icon= key in sync with the source image on every
  # switch, then nudges accounts-daemon to pick up the change immediately.
  systemd.tmpfiles.settings."10-user-avatar" = {
    "/var/lib/AccountsService/icons".d = {
      mode = "0775";
      user = "root";
      group = "root";
    };
    "/var/lib/AccountsService/icons/maerllyn"."C+" = {
      argument = "${avatarSource}";
      mode = "0644";
      user = "root";
      group = "root";
    };
  };
}
