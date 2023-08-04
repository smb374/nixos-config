{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Enable flakes.
  nix.settings = {
    allowed-users = [
      "@wheel"
      "@builders"
    ];
    trusted-users = [
      "poyehchen"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
  # Allow Unfree
  nixpkgs.config.allowUnfree = true;

  # Settings

  boot = {
    # kernelParams = ["nomodeset"];
    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot = {
        enable = true;
        memtest86.enable = true;
      };
    };
  };

  console = {
    keyMap = "us";
  };

  environment.systemPackages = with pkgs; [
    curl
    vim
    wget
    seatd
  ];

  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-serif
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
    };
  };

  hardware.opengl.enable = true;

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    firewall.enable = false;
    hostName = "smb374-nix";
    networkmanager.enable = true;
  };

  programs = {
    fish = {
      enable = true;
      useBabelfish = true;
    };
    gnupg.agent = {
      enable = true;
      enableBrowserSocket = true;
      enableExtraSocket = true;
      enableSSHSupport = true;
      pinentryFlavor = "qt";
    };
    mtr.enable = true;
    zsh.enable = true;
  };

  security = {
    polkit.enable = true;
    rtkit.enable = true;
  };
  
  services = {
    openssh.enable = true;
    pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };
    printing.enable = true;
    qemuGuest.enable = true;
  };
  
  sound.enable = true;

  time.timeZone = "Asia/Taipei";

  users = {
    users.poyehchen = {
      extraGroups = [ "audio" "video" "wheel" ];
      hashedPassword = "$y$j9T$uTRwFenSvkZiogU8HWzp60$KLVK0CLXxBa1iwi2BJp3s59VwH1.1GKJWOOLy5iPjsC";
      isNormalUser = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEhr2XitKqLvfKw400fXTf1Oa1WKO26OVSvs3LDCYnNW openpgp:0x36134CDE"
      ];
      shell = pkgs.fish;
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
