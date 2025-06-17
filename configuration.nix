{ config, pkgs, ... }:

{
  imports =
    [  
    ./hardware-configuration.nix
    ./hyprland.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [

  ];
  
  hardware.opentabletdriver.enable = true;  
  hardware.opentabletdriver.daemon.enable = true;
  virtualisation.docker.enable = true;

  networking.hostName = "nixos";

  services.xserver.enable = true;

  networking.networkmanager.enable = true;
  networking.nameservers = ["1.1.1.1" "8.8.8.8" ];

  time.timeZone = "Europe/Lisbon";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  services.displayManager.sddm.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "alt-intl";
  };

  console.keyMap = "dvorak";

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
};

  users.users.felipog = {
    isNormalUser = true;
    description = "Felipog";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [
      kdePackages.kate
    #  thunderbird
    ];
  };

  programs.firefox.enable = true;
  programs.thunar.enable = true;

  nixpkgs.config.allowUnfree = true;

  programs.hyprland.enable = true;
  environment.systemPackages = with pkgs; [
  discord
  #Programming Tools
  jetbrains.idea-ultimate
  jetbrains.phpstorm
  neofetch
  waybar
  chafa
  bun
  neovim
  git
  steam
  auto-cpufreq
  cpufrequtils
  prismlauncher
  code-cursor
  osu-lazer
  opentabletdriver
  icu
  appimage-run
];

  services.auto-cpufreq.enable = true;

 
  # DNS
  services.resolved.enable = true;
  services.resolved.extraConfig = ''
  DNS=8.8.8.8 1.1.1.1
   FallbackDNS=8.8.4.4
  '';

  services.postgresql = {
  enable = true;
  authentication = pkgs.lib.mkOverride 10 ''
  #type databae Dbuser auth method
  local all all trust
  host all postgres 127.0.0.1/32 md5
  '';
  };


  #initialScript = pkgs.writeText "pk-init.sql" ''
  #CREATE USER postgres WITH PASSWORD 'password';
  #'';
  #};

  hardware.graphics = {
  enable = true;
  enable32Bit = true;
  };

  system.stateVersion = "25.05";
  }
