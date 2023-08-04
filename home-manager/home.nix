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
  home.packages = with pkgs; [
    htop
    nodePackages_latest.pnpm
    nodePackages_latest.npm
    gcc
    fd
    unzip
    nodejs
    rustup
    nixpkgs-fmt
    cachix
    light
    babelfish
    brave
    pciutils
    drm_info
    ripgrep
    lazygit
  ] ++ [
    # Fonts
    (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = { };

  home.sessionVariables = { };

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
  # programs.ripgrep.enable = true;
  # programs.lazygit.enable = true;
}
