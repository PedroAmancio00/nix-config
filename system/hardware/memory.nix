# Memory - 96 GB DDR5, tuned for a desktop with plenty of headroom.
{ ... }:

{
  # Compressed swap in RAM. Faster than disk swap and avoids SSD wear;
  # zstd gives a good ratio-to-CPU trade-off.
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 25;
  };

  boot.kernel.sysctl = {
    # High swappiness is correct *with zram*: swapping to compressed RAM is
    # cheap, so the kernel should prefer it over evicting page cache.
    "vm.swappiness" = 180;

    # zram has no seek penalty, so read-ahead on swap-in is wasted work.
    "vm.page-cluster" = 0;

    # Reclaim tuning: react earlier, without the extra boost pass.
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;

    # Cap dirty page cache by absolute size rather than percentage. With 96 GB
    # the default percentages would allow multi-gigabyte writeback stalls.
    "vm.dirty_bytes" = 268435456; # 256 MiB
    "vm.dirty_background_bytes" = 67108864; # 64 MiB

    # Required by several Proton/Wine titles and by some game engines.
    "vm.max_map_count" = 2147483642;
  };
}
