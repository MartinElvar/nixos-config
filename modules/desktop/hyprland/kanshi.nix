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
            criteria = "Iiyama *";
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
      {
        profile.name = "mirror-hdmi";
        profile.outputs = [
          {
            criteria = "eDP-1";
            status = "enable";
            position = "0,0";
            mode = "1920x1080";
          }
          {
            criteria = "HDMI-A-1";
            status = "enable";
            position = "1920,0";
            mode = "1920x1080";
          }
        ];
        profile.exec = "exec wl-present mirror eDP-1 --fullscreen-output HDMI-A-1 --fullscreen";
      }
    ];
  };
}
