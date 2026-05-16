{ config, pkgs, ... }:

let 
  vars = import ../variables.nix;
in
{
  home.username = vars.defaultUser;
  home.homeDirectory = "/home/${vars.defaultUser}";
  home.packages = with pkgs; [
    hyprland
    alacritty
    bitwarden-desktop
    discord
    gcr  # gnome keyring
    git-credential-manager
    grimblast
    hyprcursor
    killall
    krita
    nodejs_24
    pavucontrol
    prismlauncher
    (olympus.override { celesteWrapper = "steam-run";})
    onlyoffice-desktopeditors
    qbittorrent
    rose-pine-cursor
    rose-pine-hyprcursor
    spotify
    telegram-desktop
    unzip
    protontricks
    vlc
    jdk21
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = vars.gitUsername;
      user.email = vars.gitEmail;
      init.defaultBranch = "main";
      credential = {
      helper = "manager";
      "https://github.com".username = "SkyyWasTaken";
      credentialStore = "cache";
      };
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
  wayland.windowManager.hyprland.configType = "hyprlang";

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
  
  gtk = {
    enable = true;
    colorScheme = "dark";
    cursorTheme = {
      package = pkgs.rose-pine-cursor;
      name = "BreezeX-RosePine-Linux";
      size = 28;
    };
    iconTheme = {
      package = pkgs.rose-pine-icon-theme;
      name = "rose-pine-dawn";
    };
    theme = {
      package = pkgs.rose-pine-gtk-theme;
      name = "rose-pine-dawn";
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    name = "BreezeX-RosePine-Linux";
    size = 28;
    package = pkgs.rose-pine-cursor;
  };

  # Recommended defaults
  programs.bash.enable = true;

  home.stateVersion = "25.11";
}
