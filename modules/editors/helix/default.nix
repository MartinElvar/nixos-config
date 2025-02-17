{ pkgs, ... }:

{
  programs = {
    helix = {
      enable = true;
      package = pkgs.helix;

      settings = {
        theme = "catppuccin_macchiato";
      };

      languages = {
        language-server.gpt = {
          command = "helix-gpt"; 
        };

        language-server.solargraph.config = {
           diagnostics = true;
           formatting = true; 
           documentFormatting = true;
        };
      
        language = [
          {
            name = "elixir";
            scope = "source.elixir";
            injection-regex = "elixir";
            file-types = ["ex" "exs" "html.heex"];
            roots = ["mix.exs"];
            auto-format = true;
            diagnostic-severity = "hint";
            comment-token = "#";
            indent = {tab-width = 2; unit = " ";};
            language-servers = ["elixir-ls" "gpt"];
          }
          {
            name = "ruby";
            language-servers = ["solargraph" "gpt"];
          }
        ];
      };
    };
  };
}
