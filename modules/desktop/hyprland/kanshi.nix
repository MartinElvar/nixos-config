{ ... }:

{
  services.kanshi = {
    enable = true;
    # hyprland-session.target is gone (hyprland.systemd.enable = false);
    # uwsm reaches graphical-session.target instead
    systemdTarget = "graphical-session.target";

    settings = [
      {
        profile.name = "home_office";
        profile.outputs = [
          {
            criteria = "Samsung *";
            position = "0,0";
            mode = "3440x1440@59.99Hz";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      }
      {
        profile.name = "work";
        profile.outputs = [
          {
            criteria = "iiyama *";
            position = "0,0";
            mode = "3440x1440@59.97Hz";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      }
      {
        profile.name = "work_dell";
        profile.outputs = [
          {
            criteria = "Dell *";
            position = "0,0";
            mode = "3440x1440@59.97Hz";
          }
          {
            criteria = "eDP-1";
            status = "disable";
          }
        ];
      }
      # {
      #   profile.name = "undocked_leaf";
      #   profile.outputs = [
      #     {
      #       criteria = "BOE *";
      #       scale = 1.5;
      #       mode = "2880x1920@120.00Hz";
      #       status = "enable";
      #     }
      #   ];
      # }
      {
        profile.name = "undocked";
        profile.outputs = [
          {
            criteria = "eDP-1";
            scale = 1.0;
            mode = "1920x1080@60.03Hz";
            status = "enable";
          }
        ];
      }
      # Mirroring is handled manually via `hypr-mirror` (SUPER+P / XF86Display),
      # see modules/desktop/hyprland/scripts/toggle_mirror.sh. A "mirror-hdmi"
      # kanshi profile used to live here, but since it literally matched
      # "HDMI-A-1" it would race the "work" profile above on every HDMI
      # hotplug (Iiyama's EDID isn't always populated yet when the head first
      # appears), sometimes winning and mirroring instead of extending.
    ];
  };
}
