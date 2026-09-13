{
  lib,
  stdenvNoCC,
  src,
}:

stdenvNoCC.mkDerivation {
  pname = "mactahoe-gtk-theme";
  # Upstream publishes no releases, so the version follows the nixpkgs
  # convention of "<last-version>-unstable-<commit-date>". The exact revision
  # is pinned by flake.lock, not by this string.
  version = "0-unstable-2026-09-10";

  inherit src;

  # NOTE: do not try to run the upstream `install.sh` here.
  #
  # It sources libs/lib-core.sh, which runs under `set -Eeo pipefail` and
  # assumes a traditional distribution: it calls `getent` to resolve the
  # user's home, probes for `sudo`, and contacts a remote time server to
  # validate the system clock before installing distro packages. None of that
  # exists in the Nix build sandbox, and the failures are silent because the
  # script redirects its own file descriptors.
  #
  # The repository ships prebuilt theme tarballs under `release/`, which is
  # both simpler and reproducible. The trade-off is that only upstream's
  # default variants are available - installer flags such as `--theme`,
  # `--alt` or `-HD` cannot be applied this way.
  dontBuild = true;
  dontConfigure = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/themes
    tar -xf release/MacTahoe-Dark.tar.xz -C $out/share/themes

    runHook postInstall
  '';

  meta = with lib; {
    description = "macOS Tahoe-like theme for GTK desktops";
    homepage = "https://github.com/vinceliuice/MacTahoe-gtk-theme";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
