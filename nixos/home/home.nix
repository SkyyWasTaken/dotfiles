{ config, pkgs, ... }:

{
  imports = [
    ../variables.nix
  ];
  home.username = config.defaultUser;
  home.homeDirectory = "/home/${config.defaultUser}";
  home.packages = with pkgs; [
    alacritty
    bitwarden-desktop
    discord
    gcr  # gnome keyring
    grimblast
    hyprcursor
    killall
    krita
    rose-pine-cursor
    rose-pine-hyprcursor
    spotify
    steam
    pavucontrol
    prismlauncher
    brave
    firefox
    musescore
    muse-sounds-manager
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = config.gitUsername;
      user.email = config.gitEmail;
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
