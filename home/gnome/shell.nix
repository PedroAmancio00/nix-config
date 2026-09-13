# GNOME Shell: enabled extensions, dock favourites and Mutter features.
{ ... }:

{
  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;

      # Extensions are installed system-wide in system/gnome.nix; this list
      # controls which of them actually load. The values are extension UUIDs,
      # not package names. To find a UUID:
      #   ls $(nix eval --raw nixpkgs#gnomeExtensions.<name>)/share/gnome-shell/extensions/
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "dash-to-dock@micxgx.gmail.com"
        "blur-my-shell@aunetx"
        "clipboard-indicator@tudmotu.com"
        "azwallpaper@azwallpaper.gitlab.com"
      ];

      # Pinned applications, in dock order. These are .desktop filenames; a
      # name that does not resolve simply shows no icon.
      favorite-apps = [
        "zen.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Ptyxis.desktop"
        "code.desktop"
        "vesktop.desktop"
        "com.github.dagmoller.whatsapp-electron.desktop"
        "spotify.desktop"
        "steam.desktop"
      ];
    };

    # Shell theme. Requires the user-themes extension above; without it, the
    # Shell section of GNOME Tweaks stays greyed out.
    "org/gnome/shell/extensions/user-theme".name = "MacTahoe-Dark";

    # Mutter feature flags.
    #
    # Only values accepted by the current schema may appear here - an invalid
    # entry makes GNOME discard the whole list, silently. Check with:
    #   gsettings range org.gnome.mutter experimental-features
    #
    # "variable-refresh-rate" is deliberately absent: VRR graduated out of the
    # experimental flags and is now a per-monitor toggle in
    # Settings > Displays, stored in ~/.config/monitors.xml.
    "org/gnome/mutter".experimental-features = [
      # Fractional scaling (125%, 150%, ...) under Wayland.
      "scale-monitor-framebuffer"
    ];
  };
}
