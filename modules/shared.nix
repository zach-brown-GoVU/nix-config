{ pkgs, ... }:

{
  # Fonts
  fonts.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  nixpkgs.config.allowUnfree = true;

  # Packages shared across all systems
  environment.systemPackages = [
    pkgs.vim
    pkgs.jetbrains-toolbox
    pkgs.fastfetch
    pkgs.starship
    pkgs.zoxide
    pkgs.obsidian
    pkgs.spotify
    pkgs.lazygit
    pkgs.claude-code
    pkgs.android-tools
    pkgs.javaPackages.compiler.temurin-bin.jdk-25
    pkgs.stow
    pkgs.fzf
    pkgs.bat
    pkgs.eza
    pkgs.vscode
    pkgs.delta
    pkgs.tldr
    pkgs.ruby
    pkgs.nodejs_20
  ];

  # Homebrew packages
  homebrew = {
    enable = true;
    brews = [
      "thefuck"
      "fastlane"
    ];
    casks = [
      "ghostty"
      "zen"
    ];
    onActivation.cleanup = "zap";
  };

  # Enable fish shell
  programs.fish = {
    enable = true;
  };

  # Set fish as default shell for user
  users.users.zachbrown.shell = pkgs.fish;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
}
