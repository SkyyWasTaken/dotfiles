{ config, pkgs, ... }:

let 
  vars = import ../variables.nix;
in
{
  home.username = vars.defaultUser;
  home.homeDirectory = "/home/${vars.defaultUser}";
  home.packages = with pkgs; [
    alacritty
    bitwarden-desktop
    discord
    gcr  # gnome keyring
    grimblast
    hyprcursor
    killall
    krita
    pavucontrol
    prismlauncher
    (olympus.override { celesteWrapper = "steam-run";})
    onlyoffice-desktopeditors
    rose-pine-cursor
    rose-pine-hyprcursor
    spotify
    steam
    telegram-desktop
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = vars.gitUsername;
      user.email = vars.gitEmail;
      init.defaultBranch = "main";
    };
  };

  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
    ];
  };

  programs.waybar = import ./hyprland/waybar.nix;
  
  # Hyprland configuration
  programs.kitty.enable = true;
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = import ./hyprland/hyprland.nix;

  services.gnome-keyring.enable = true;

  programs.rofi = {
    enable = true;
    font = "sans-serif";
    package = pkgs.rofi;
    modes = [
      "drun"
      "run"
      "window"
      "ssh"
    ];
    extraConfig = {
      show-icons = true;
    };
  };
  
  # Recommended defaults
  programs.bash.enable = true;

  home.stateVersion = "25.11";
}
