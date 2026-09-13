# Development runtimes and compatibility shims.
{ pkgs, ... }:

{
  # nix-ld provides a dynamic loader at the path that FHS-assuming binaries
  # expect, so prebuilt executables (Unity, downloaded language servers,
  # vendor SDKs) run without patching.
  programs.nix-ld.enable = true;

  # Libraries exposed to those binaries. Extend this when a downloaded tool
  # fails with "cannot open shared object file".
  programs.nix-ld.libraries = with pkgs; [
    # --- Core runtime ---
    stdenv.cc.cc
    zlib
    glib
    icu
    ncurses
    expat
    libxml2_13

    # --- Graphics ---
    libGL
    vulkan-loader
    gdk-pixbuf
    cairo
    pango
    gtk3

    # --- Fonts and text ---
    fontconfig
    freetype

    # --- X11 ---
    libx11
    libxcursor
    libxrandr
    libxi
    libxext
    libxrender
    libxtst
    libxkbcommon

    # --- System services ---
    dbus
    udev
    alsa-lib
    cups

    # --- Chromium/Electron runtime (NSS) ---
    nss
    nspr
    atk
  ];
}
