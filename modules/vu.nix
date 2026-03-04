{ pkgs, ... }:

{
  # Packages specific to VU workstation
  environment.systemPackages = [
    pkgs.dotnetCorePackages.sdk_8_0_1xx-bin
  ];
}
