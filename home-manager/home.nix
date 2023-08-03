{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "poyehchen";
  home.homeDirectory = "/home/poyehchen";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    pkgs.htop
    pkgs.nodePackages_latest.pnpm
    pkgs.nodePackages_latest.npm
    pkgs.gcc
    pkgs.fd
    pkgs.unzip
    pkgs.nodejs
    pkgs.rustup
    pkgs.nixpkgs-fmt
    pkgs.cachix
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  programs.git = {
    enable = true;
    userName = "Po-Yeh Chen";
    userEmail = "poyehchen@cs.nctu.edu.tw";
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.ripgrep.enable = true;
  programs.lazygit.enable = true;
}
