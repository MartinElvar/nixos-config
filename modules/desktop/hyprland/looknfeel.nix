{
  config,
  ...
}:
let
  hexToRgba = hex: alpha: "rgba(${hex}${alpha})";

  activeBorder = hexToRgba config.colorScheme.palette.base08 "aa";

in
{
  wayland.windowManager.hyprland.settings = {
    config = {
      general = {
        gaps_in = 5;
        gaps_out = 5;
        border_size = 3;

        col.active_border = activeBorder;

        resize_on_border = false;

        allow_tearing = false;

        layout = "master";
      };

      decoration = {
        rounding = 4;

        shadow = {
          enabled = false;
          range = 30;
          render_power = 3;
          color = "rgba(00000045)";
        };

        blur = {
          enabled = false;
          size = 5;
          passes = 2;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true; # yes, please :)
      };

      master = {
        orientation = "center"; # master in the middle
        mfact = 0.7; # 50% width for master
        allow_small_split = true;
        slave_count_for_center_master = 2;
        new_on_top = true;
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };
    };

    curve = [
      {
        _args = [
          "easeOutQuint"
          {
            type = "bezier";
            points = [
              [
                0.23
                1
              ]
              [
                0.32
                1
              ]
            ];
          }
        ];
      }
      {
        _args = [
          "easeInOutCubic"
          {
            type = "bezier";
            points = [
              [
                0.65
                0.05
              ]
              [
                0.36
                1
              ]
            ];
          }
        ];
      }
      {
        _args = [
          "linear"
          {
            type = "bezier";
            points = [
              [
                0
                0
              ]
              [
                1
                1
              ]
            ];
          }
        ];
      }
      {
        _args = [
          "almostLinear"
          {
            type = "bezier";
            points = [
              [
                0.5
                0.5
              ]
              [
                0.75
                1.0
              ]
            ];
          }
        ];
      }
      {
        _args = [
          "quick"
          {
            type = "bezier";
            points = [
              [
                0.15
                0
              ]
              [
                0.1
                1
              ]
            ];
          }
        ];
      }
    ];

    animation = [
      {
        leaf = "global";
        enabled = true;
        speed = 10;
        bezier = "default";
      }
      {
        leaf = "border";
        enabled = true;
        speed = 5.39;
        bezier = "easeOutQuint";
      }
      {
        leaf = "windows";
        enabled = true;
        speed = 4.79;
        bezier = "easeOutQuint";
      }
      {
        leaf = "windowsIn";
        enabled = true;
        speed = 4.1;
        bezier = "easeOutQuint";
        style = "popin 87%";
      }
      {
        leaf = "windowsOut";
        enabled = true;
        speed = 1.49;
        bezier = "linear";
        style = "popin 87%";
      }
      {
        leaf = "fadeIn";
        enabled = true;
        speed = 1.73;
        bezier = "almostLinear";
      }
      {
        leaf = "fadeOut";
        enabled = true;
        speed = 1.46;
        bezier = "almostLinear";
      }
      {
        leaf = "fade";
        enabled = true;
        speed = 3.03;
        bezier = "quick";
      }
      {
        leaf = "layers";
        enabled = true;
        speed = 3.81;
        bezier = "easeOutQuint";
      }
      {
        leaf = "layersIn";
        enabled = true;
        speed = 4;
        bezier = "easeOutQuint";
        style = "fade";
      }
      {
        leaf = "layersOut";
        enabled = true;
        speed = 1.5;
        bezier = "linear";
        style = "fade";
      }
      {
        leaf = "fadeLayersIn";
        enabled = true;
        speed = 1.79;
        bezier = "almostLinear";
      }
      {
        leaf = "fadeLayersOut";
        enabled = true;
        speed = 1.39;
        bezier = "almostLinear";
      }
      {
        leaf = "workspaces";
        enabled = false;
        speed = 0;
        bezier = "ease";
      }
    ];
  };
}
