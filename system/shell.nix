# Interactive shell environment.
{ ... }:

{
  # Fish must be enabled at system level for it to be a valid login shell
  # and to get proper completion generation for system packages.
  programs.fish.enable = true;

  programs.starship = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      # Keep the prompt tight against the previous command's output.
      add_newline = false;
    };
  };
}
