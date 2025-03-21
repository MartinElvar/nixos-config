{
  # Import all your configuration modules here
  imports = [
    ./plugins.nix
    ./options.nix
    ./keymappings.nix
  ];
  
  programs.nixvim = {
    enable = true;
    viAlias = false;
    vimAlias = true;
  };
}
