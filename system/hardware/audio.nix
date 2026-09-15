# Audio - PipeWire, configured for high-resolution output.
{ ... }:

{
  # PipeWire replaces PulseAudio entirely; the compatibility layer below
  # keeps PulseAudio clients working.
  services.pulseaudio.enable = false;

  # Allows PipeWire to acquire realtime scheduling priority.
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    # Force 32-bit samples at 192 kHz on ALSA sinks.
    extraConfig.pipewire."92-audio-quality" = {
      "context.properties" = {
        # Default rate. PipeWire switches to another allowed rate when a client
        # requests one and no other stream is active, so this is a starting
        # point rather than a ceiling.
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [
          44100
          48000
          88200
          96000
          176400
          192000
        ];

        "default.clock.quantum" = 512;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 8192;
      };
    };
  };
}
