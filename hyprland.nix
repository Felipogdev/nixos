
{pkgs, config, ... }:

{
programs.hyprland.enable=true;

environment.systemPackages = with pkgs; [
grim
slurp
wl-clipboard
kitty
rofi
pavucontrol
hyprcursor
rose-pine-hyprcursor
hyprpaper
hyprlock
];
}
