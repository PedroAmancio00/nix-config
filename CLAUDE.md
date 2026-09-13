# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

A single-machine NixOS flake configuration (Ryzen 9 9950X3D / RTX 5090 / 96 GB RAM, GNOME on Wayland), combining system-level NixOS config with per-user Home Manager config in one flake. The flake output is `nixosConfigurations.nixos`; the username (`maerllyn`) is defined once in `flake.nix` and threaded to both module trees via `specialArgs`/`extraSpecialArgs` — reference it as the `username` argument rather than hardcoding it, and use `config.home.homeDirectory` for user paths.

Read `README.md` first — it documents the full file layout, conventions, deliberately-undeclared state, and known limitations in detail. Don't duplicate that content here; this file only adds what README.md doesn't cover.

## Commands

This repo is deployed as `/etc/nixos` on the target machine. Fish shell aliases (defined in `system/shell.nix`) wrap the actual commands:

```fish
update       # sudo nixos-rebuild switch --flake /etc/nixos#nixos
upgrade      # sudo nix flake update --flake /etc/nixos
checkconfig  # nix-instantiate --parse /etc/nixos/flake.nix > /dev/null && echo ok
```

When working from a checkout that is not itself `/etc/nixos`, `nixos-rebuild switch --flake .#nixos` (or `--flake <path>#nixos`) still requires root and will apply the config to the *running* machine — treat it as a real deploy action, not a safe check.

To validate changes without deploying:
```fish
nix flake check                                  # evaluates the flake, catches option/type errors
nixos-rebuild build --flake .#nixos               # builds the system closure without switching
nix run nixpkgs#nixfmt-rfc-style -- .             # format all .nix files
```

## Architecture

- **Two module trees, one flake.** `system/` (NixOS) and `home/` (Home Manager) are imported side by side in `flake.nix`; Home Manager runs as a NixOS module (`useGlobalPkgs = true`, `useUserPackages = true`) so one `nixos-rebuild switch` applies both. Home Manager's `backupFileExtension` is disabled and `backupCommand` deletes conflicting files instead of erroring — unmanaged files under its control are always treated as stale, so don't rely on HM to preserve out-of-band edits to files it owns.
- **Overlay wiring.** `overlays/default.nix` is a function of `inputs` (curried in `flake.nix` as `nixpkgs.overlays = [ (import ./overlays inputs) ]`), taking `final`/`prev` to add locally packaged software (e.g. `mactahoe-gtk-theme`, built from a `flake = false` source input). Because Home Manager shares the global pkgs, overlay packages are usable from both `system/` and `home/`.
- **One concern per file, imported explicitly.** Both `system/default.nix` and `home/default.nix` are plain import lists — there is no auto-discovery. Adding a new configuration area means adding a `.nix` file and listing it in the relevant `default.nix`.
- **dconf/GNOME settings** live under `home/gnome/`, split by function (interface, shell/extensions, keybindings, power). Each dconf path is set in exactly one file. Some GNOME-owned state (`~/.config/monitors.xml`, the wallpaper-slideshow-owned background key) is intentionally left undeclared — see README.md's "Things that are deliberately not declared" before adding config for display geometry or wallpaper.
- **Generated/do-not-edit files:** `system/hardware-configuration.nix` (from `nixos-generate-config`) and `flake.lock`. Regenerate rather than hand-edit; `flake.lock` updates via `upgrade`.
- **stateVersion fields** (`system.stateVersion` in `system/default.nix`, `home.stateVersion` in `home/default.nix`) pin on-disk data formats for stateful services — never bump them to "match the current NixOS version" as a routine change.
