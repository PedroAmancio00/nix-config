{ ... }:

{
  programs.fish = {
    enable = true;

    functions = {
      findDesktop = ''
        find /run/current-system/sw/share/applications -iname "*$argv[1]*"
      '';

      cB = ''
        git branch $argv[1] && git switch $argv[1]
      '';
    };

    interactiveShellInit = ''
      # Drop the default fish banner.
      set -g fish_greeting ""

      fastfetch
    '';

    shellAliases = {
      # Update flake inputs (nixpkgs, home-manager, themes) to their latest
      # revisions and rewrite flake.lock.
      upgrade = "sudo nix flake update --flake /etc/nixos";

      # Build and activate the current configuration.
      update = "git -C /etc/nixos add -A; sudo nixos-rebuild switch";

      # Validate syntax without building - much faster than a full rebuild.
      checkNix = "nix-instantiate --parse /etc/nixos/flake.nix > /dev/null && echo ok";

      formatNix = "nix run nixpkgs#nixfmt-tree";

      tB = "git switch";

      cB = "git branch";
    };
  };
}
