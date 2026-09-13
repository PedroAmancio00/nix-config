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

    # Run the graph at 192 kHz, but allow renegotiation down to whatever the
    # source actually uses so no resampling happens unnecessarily.
    extraConfig.pipewire."92-audio-quality" = {
      "context.properties" = {
        "default.clock.rate" = 192000;
        "default.clock.allowed-rates" = [
          44100
          48000
          88200
          96000
          176400
          192000
        ];

        # Buffer size. A larger default quantum favours stability; the min/max
        # bounds let low-latency clients negotiate something smaller.
        "default.clock.quantum" = 1024;
        "default.clock.min-quantum" = 32;
        "default.clock.max-quantum" = 8192;
      };
    };

    # Force 32-bit samples at 192 kHz on ALSA sinks.
    wireplumber.extraConfig."51-alsa-config".monitor.alsa = {
      rules = [
        {
          matches = [ { "node.name" = "~alsa_output.*"; } ];
          actions = {
            update-props = {
              "audio.format" = "S32LE";
              "audio.rate" = 192000;
            };
          };
        }
      ];
    };
  };
}
