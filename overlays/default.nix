# Nixpkgs overlay: locally defined packages and overrides.
#
# `final` is the fully resolved package set (use it to reference other
# overridden packages), `prev` is the set as it was before this overlay ran.

inputs: final: prev: {

  # macOS Tahoe-style GTK theme, built from the pinned upstream source.
  mactahoe-gtk-theme = prev.callPackage ./mactahoe-gtk-theme.nix {
    src = inputs.mactahoe-gtk-src;
  };
}
