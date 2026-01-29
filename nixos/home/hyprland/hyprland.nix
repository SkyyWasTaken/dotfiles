let 
  vars = import ../../variables.nix;
in
{
  "$mod" = "SUPER";
  monitor = [
    "DP-3, 1920x1080@144, 0x0, 1"
    "HDMI-A-1, 1920x1080@60, 1920x0, 1"
    "DP-2, 1920x1080@60, 3840x0, 1"
  ];
  bind = [
    "$mod, X, exit"
    "$mod, space, exec, rofi -show drun -show-icons"
    "$mod, Return, exec, alacritty"
    "$mod, C, exec, hyprctl dispatch dpms on"
    "$mod, R, exec, hyprctl dispatch dpms off"
    "CTRLALT, semicolon, killactive,"
    "CTRLALTSHIFT, semicolon, exec, hyprctl kill"
    "$mod, F, fullscreen"
    "$mod SHIFT, S, exec, grimblast copy area"

    # Workspaces
    "$mod, 1, workspace, 1"
    "$mod, 2, workspace, 2"
    "$mod, 3, workspace, 3"
    "$mod, 4, workspace, 4"
    "$mod, 5, workspace, 5"
    "$mod, 6, workspace, 6"
    "$mod, 7, workspace, 7"
    "$mod, 8, workspace, 8"
    "$mod, 9, workspace, 9"
    "$mod, 0, workspace, 10"

    # Move to workspace
    "$mod SHIFT, 1, movetoworkspacesilent, 1"
    "$mod SHIFT, 2, movetoworkspacesilent, 2"
    "$mod SHIFT, 3, movetoworkspacesilent, 3"
    "$mod SHIFT, 4, movetoworkspacesilent, 4"
    "$mod SHIFT, 5, movetoworkspacesilent, 5"
    "$mod SHIFT, 6, movetoworkspacesilent, 6"
    "$mod SHIFT, 7, movetoworkspacesilent, 7"
    "$mod SHIFT, 8, movetoworkspacesilent, 8"
    "$mod SHIFT, 9, movetoworkspacesilent, 9"
    "$mod SHIFT, 0, movetoworkspacesilent, 10"
  ];
  bindm = [
    "$mod, mouse:272, movewindow"  # left click
    "$mod, mouse:273, resizewindow" # right click
  ];
  input = {
    kb_layout = vars.kbLayout;
    kb_variant = vars.kbVariant;
    accel_profile = "flat";
    force_no_accel = true;
    sensitivity = 0;
  };
  workspace = [
    "1,monitor:DP-3"
    "2,monitor:DP-3"
    "3,monitor:DP-3"
    "4,monitor:DP-3"
    "5,monitor:DP-3"
    "6,monitor:HDMI-A-1"
    "7,monitor:HDMI-A-1"
    "8,monitor:HDMI-A-1"
    "9,monitor:HDMI-A-1"
    "10,monitor:HDMI-A-1"
  ];
  general = {
    gaps_in = 4;
    gaps_out = 3;
    border_size = 2;
    "col.active_border" = "rgba(5533ffaa) rgba(4433ffaa) 45deg";
    "col.inactive_border" = "rgba(595959aa)";

    layout = "dwindle";
  };
  decoration = {
    rounding = 4;
	
    blur = {
      enabled = "yes";
      size = 3;
      passes = 1;
      new_optimizations = "on";
    };
  };
  animations = {
    enabled = "yes";
    bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
    animation = [
      "windows, 1, 7, myBezier"
      "windowsOut, 1, 7, default, popin 80%"
      "border, 1, 10, default"
      "borderangle, 1, 8, default"
      "fade, 1, 7, default"
      "workspaces, 1, 6, default"
    ];
  };
  dwindle = {
    pseudotile = "yes";
    preserve_split = "yes";
    smart_split = "yes";
  };
  misc = {
    disable_hyprland_logo = false;
    vfr = false;
  };
  exec-once = [
    "gsettings set org.gnome.desktop.interface cursor-theme BreezeX-RosePine-Linux"
    "gsettings set org.gnome.desktop.interface cursor-size 28"
    "waybar"
  ];
  env = [
    "HYPRCURSOR_THEME,rose-pine-hyprcursor"
    "HYPRCURSOR_SIZE,28"
    "EDITOR,code --wait"
  ];
  windowrulev2 = [
    "tile, class:^steam$"
  ];
}