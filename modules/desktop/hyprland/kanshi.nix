{ ... }:

{
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    profiles = {
      home_office = {
        outputs = [
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
      };

      undocked = {
        outputs = [
          {
            criteria = "eDP-1";
            scale = 1.0;
            mode = "1920x1080@60.03Hz";
            status = "enable";
          }
        ];
      };
    };
  };
}
