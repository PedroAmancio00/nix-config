# Interactive shell environment.
{ ... }:

{
  # Fish must be enabled at system level for it to be a valid login shell
  # and to get proper completion generation for system packages.
  programs.fish = {
    enable = true;

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
      update = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";

      # Validate syntax without building - much faster than a full rebuild.
      checkNix = "nix-instantiate --parse /etc/nixos/flake.nix > /dev/null && echo ok";

      formatNix = "nix run nixpkgs#nixfmt-rfc-style -- .";

      tB = "git switch";
    };   
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      # Keep the prompt tight against the previous command's output.
      add_newline = false;
    };
  };
}
