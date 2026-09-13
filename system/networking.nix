# Networking and firewall.
{ ... }:

{
  networking.hostName = "pedro-linux-pc";
  networking.networkmanager.enable = true;

  # The firewall is on by default. Game-related ports are opened by the Steam
  # module in ./gaming.nix rather than listed here.
  # networking.firewall.allowedTCPPorts = [ ];
  # networking.firewall.allowedUDPPorts = [ ];
}
