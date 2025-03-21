{pkgs, ...}:

{
  programs.nixvim.plugins= {
  
    # Language server
    lsp = {
      enable = true;
      servers = {
        # Average webdev LSPs
        # ts-ls.enable = true; # TS/JS
        ts_ls.enable = true; # TS/JS
        cssls.enable = true; # CSS
        tailwindcss.enable = true; # TailwindCSS
        html.enable = true; # HTML
        marksman.enable = true; # Markdown
        dockerls.enable = true; # Docker
        bashls.enable = true; # Bash
        yamlls.enable = true; # YAML
        lua_ls = { # Lua
          enable = true;
          settings.telemetry.enable = false;
        };
      };
    };

    snacks = {
      enable = true;
      autoLoad = true; 
    };
  };
}
