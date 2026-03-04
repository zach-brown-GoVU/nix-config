{ config, lib, pkgs, inputs, username, ... }:

{
  imports = [
    ../../modules/home-manager/bat.nix
    ../../modules/home-manager/claude-code.nix
    ../../modules/home-manager/delta.nix
    ../../modules/home-manager/eza.nix
    ../../modules/home-manager/fastfetch.nix
    ../../modules/home-manager/fish.nix
    ../../modules/home-manager/ghostty.nix
    ../../modules/home-manager/git.nix
    ../../modules/home-manager/lazygit.nix
    ../../modules/home-manager/starship.nix
    ../../modules/home-manager/tldr.nix
    ../../modules/home-manager/zoxide.nix
  ];

  # Home-manager settings
  home = {
    username = username;
    homeDirectory = "/Users/${username}";

    # User packages
    packages = with pkgs; [
      # CLI tools
      ripgrep
      fd
      jq
      tree
      htop

      # Add more packages here
    ];

    # Environment variables
    sessionVariables = {
      EDITOR = "vim";
    };

    # Home state version - do not change after initial setup
    stateVersion = "24.05";
  };

  # Work-specific git configuration
  programs.git.settings.user = {
    name = "Zach Brown";
    email = "zacharyc.brown@veteransunited.com";
  };
}
