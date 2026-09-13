# NixOS configuration

Ryzen 9 9950X3D / RTX 5090 / 96 GB RAM, running GNOME on Wayland.

## Layout

```
flake.nix              Inputs, the host definition, and Home Manager wiring
overlays/              Locally packaged software
  mactahoe-gtk-theme.nix
system/                NixOS (system-wide) configuration
  default.nix          Import list and system.stateVersion
  hardware-configuration.nix   Generated - do not edit
  hardware/            Per-subsystem hardware settings
    cpu.nix            Governor, microcode, 3D V-Cache mode
    gpu.nix            NVIDIA driver and graphics stack
    memory.nix         zram and VM sysctls
    storage.nix        NVMe I/O scheduler
    audio.nix          PipeWire
    peripherals.nix    Mouse, touchpad, printing
  boot.nix             Bootloader, kernel, kernel parameters
  nix.nix              Nix daemon settings, allowUnfree
  networking.nix
  locale.nix           Time zone and locale
  users.nix            Account definition
  desktop.nix          GDM, GNOME session, XDG portals
  gnome.nix            GNOME tools and Shell extension packages
  fonts.nix
  shell.nix            Fish and Starship
  gaming.nix           Steam, Gamescope, GameMode
  development.nix      nix-ld and its libraries
  packages.nix         System packages, grouped by purpose
home/                  Home Manager (per-user) configuration
  default.nix          Import list, username, stateVersion
  theming.nix          GTK theme, icons, fonts
  applications.nix     Desktop entries, autostart, MIME defaults
  packages.nix         Per-user packages
  gnome/               dconf settings, split by function
    interface.nix      Appearance, fonts, titlebar layout
    shell.nix          Enabled extensions, dock favourites, Mutter flags
    extensions.nix     Per-extension settings
    keybindings.nix    Shortcuts and keyboard layouts
    power.nix          Idle, blanking, locking
```

## Usage

```fish
update       # nixos-rebuild switch
upgrade      # update flake inputs
checkconfig  # parse-check without building
```

## Conventions

- The username is defined once in `flake.nix` and passed to both module trees
  via `specialArgs`. Reference it as `username`, or use
  `config.home.homeDirectory` for paths.
- One concern per file. Adding a new area means adding a file and listing it
  in the relevant `default.nix`.
- Each dconf path is declared in exactly one file, so the effective value is
  always traceable.
- Runtime state (extension queues, current wallpaper, display geometry) is
  deliberately not declared.

## Things that are deliberately not declared

**`~/.config/monitors.xml`** - resolution, scale, refresh rate, VRR and HDR.
GNOME rewrites this file whenever the display settings change and keys it by
monitor serial. Declaring it would make Settings > Displays read-only.

**`org/gnome/desktop/background`** - owned by the wallpaper-slideshow
extension, which rewrites it on every rotation.

## Known limitations

**HDR through Gamescope.** Nested under GNOME, Gamescope reads the display's
HDR metadata but reports `bExposeHDRSupport: false`, because Mutter does not
yet expose the Wayland colour-management protocol. Launch HDR titles without
Gamescope, or run Gamescope from a bare TTY. This should start working on its
own as Mutter gains the protocol.

**Tray icons vs. blur.** Upstream MacTahoe lists the AppIndicator extension as
incompatible with Blur My Shell. If blur breaks, disable AppIndicator first.

## Formatting

```fish
nix run nixpkgs#nixfmt-rfc-style -- .
```
