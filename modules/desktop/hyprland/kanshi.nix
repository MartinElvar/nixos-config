{ ... }:

{
  services.kanshi = {
    enable = true;
    systemdTarget = "hyprland-session.target";

    profiles = {
      home_office = {
        outputs = [
          {
            criteria = "Samsung Electric Company SE790C";
            position = "0,0";
            mode = "3440x1440@60Hz";
          }
          {
            criteria = "Lenovo Group Limited 0x40A9";
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
            # status = "enable";
          }
        ];
      };
    };
  };
}
