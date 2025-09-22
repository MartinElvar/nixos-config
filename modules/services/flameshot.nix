{ user, ... }:

{
  services = {
    flameshot = {
      enable = true;
      settings = {
        General = {
          # Settings
          savePath = "/home/${user}/screenshots";
          saveAsFileExtension = ".png";
          uiColor = "#2d0096";
          showHelp = "false";
          useGrimAdapter = true;
        };
      };
    };
  };
}
