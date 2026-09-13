# Power management, idle behaviour and screen locking.
{ lib, ... }:

{
  dconf.settings = {
    # Never suspend on idle. This is a desktop; suspending mid-download or
    # mid-build is never what is wanted.
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "nothing";

      # Dim before blanking. GNOME computes the dim delay internally as a
      # fraction of idle-delay and exposes no key to set it directly.
      idle-dim = true;
    };

    # Blank the screen after 10 minutes of inactivity.
    "org/gnome/desktop/session" = {
      idle-delay = lib.hm.gvariant.mkUint32 600;
    };

    # Blanking should not lock. The screen turns off; coming back needs no
    # password. Note this does not cover manual suspend, where GDM still
    # prompts on resume.
    "org/gnome/desktop/screensaver" = {
      lock-enabled = false;
      idle-activation-enabled = false;
    };

    "org/gnome/desktop/notifications".show-banners = true;
  };
}
