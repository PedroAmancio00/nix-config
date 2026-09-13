# Gaming stack: Steam, Gamescope and GameMode.
{ ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Nested compositor. Useful for fixed internal resolution, frame limiting
  # and isolating a game from the desktop's scaling.
  #
  # Launch example (Steam launch options):
  #   gamemoderun gamescope -W 3840 -H 2160 -r 240 --mangoapp -- %command%
  programs.gamescope = {
    enable = true;

    # Must stay false. With CAP_SYS_NICE set on the binary, Steam's bubblewrap
    # sandbox refuses to start:
    #   "bwrap: Unexpected capabilities but not setuid, old file caps config?"
    # The lost thread priority is negligible on this hardware, and
    # `gamemoderun` provides prioritisation through the GameMode daemon
    # instead, without touching file capabilities.
    capSysNice = false;
  };

  # Raises the priority of a running game and switches the CPU governor for
  # its lifetime. The module (rather than the bare package) is what installs
  # the daemon and the polkit rule that make renice actually work.
  programs.gamemode = {
    enable = true;

    settings.general = {
      # Priority boost applied to the game process. Values are subtracted from
      # the process's nice value, so 10 means nice -10. Higher is more
      # aggressive, but starving the compositor causes stutter.
      renice = 10;
    };
  };
}
