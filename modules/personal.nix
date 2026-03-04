{ pkgs, ... }:

{
  # Packages specific to personal workstation
  environment.systemPackages = [
    pkgs.brave
  ];

  homebrew = {
    enable = true;
    casks = [
      "discord"
    ];
    onActivation.cleanup = "zap";
  };
}
