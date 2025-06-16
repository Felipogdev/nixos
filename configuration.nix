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
    extraGroups = [ "networkmanager" "wheel" ];
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
  neofetch
  waybar
  chafa
  bun
  neovim
  git
  steam

];

  services.tlp = {
  enable = true;
  settings =  {
     CPU_SCALING_GOVERNOR_ON_AC = "powersave";
     CPU_SCALING_GOVERNOR_ON_BAR = "powersave";

     CPU_ENERGY_PERF_POLICY_ON_BAR = "power";
     CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

     CPU_MIN_PERF_ON_AC = 0;
     CPU_MAX_PERF_ON_AC= 100;
     CPU_MIN_PERF_ON_BAT = 0;
     CPU_MAX_PERF_ON_BAR = 20;

     START_CHARGE_THRESH_BAT0 = 40;
     STOP_CHARGE_THRESH_BAT0= 80;
   };
  };

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
  host all postgres 127.0.0/32 md5
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
