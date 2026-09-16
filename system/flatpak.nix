# Flatpak runtime and declared applications.
#
# The nix-flatpak module handles remotes, installation and removal. Note that
# the application contents come from Flathub rather than the Nix store, so
# these packages are not pinned by flake.lock.
{ ... }:

{
  services.flatpak = {
    enable = true;

    remotes = [
      {
        name = "flathub";
        location = "https://flathub.org/repo/flathub.flatpakrepo";
      }
    ];

    # packages = [
    #   "com.unity.UnityHub"
    # ];

    # Remove applications that are no longer declared above.
    uninstallUnmanaged = true;

    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };
  };
}
