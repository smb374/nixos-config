{ config, pkgs, ... }:

{
  wayland.windowManager.sway = {
    enable = true;
    config = rec {
      modifier = "Mod4";
      terminal = "foot";
      input = {
        "type:keyboard" = {
          xkb_layout = "us";
          repeat_delay = "150";
          repeat_rate = "50";
        };
        "type:touchpad" = {
          tap = "enabled";
          pointer_accel = "0.4";
        };
      };
    };
  };
}
