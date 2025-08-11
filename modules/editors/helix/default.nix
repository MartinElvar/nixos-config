{ pkgs, ... }:

{
  programs = {
    helix = {
      enable = true;
      package = pkgs.helix;

      settings = {
        theme = "catppuccin_macchiato";
        keys.normal = {
          C-g = [":new" ":insert-output lazygit" ":buffer-close!" ":redraw"];
        };
      };


      languages = {
        language-server.solargraph.config = {
          diagnostics = true;
          formatting = true; 
          documentFormatting = true;
          command = "bundle";
          args = ["exec" "solargraph" "stdio"];
        };

        language-server.ruby = {
          config = {
            diagnostics = true;
            formatting = true; 
            documentFormatting = true;
          };
          command = "bundle";
          args = ["exec" "solargraph" "stdio"];
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
            language-servers = ["elixir-ls"];
          }
          {
            name = "ruby";
            file-types = ["rb" "rake" "rakefile" "irb" "gemfile" "gemspec" "Rakefile" "Gemfile" "rabl" "jbuilder" "jb" "builder"];
            language-servers = ["ruby"];
            # formatter = { command = "prettier"; args = ["--parser" "ruby"]; };
            auto-format = true;      
          }
        ];
      };
    };
  };
}
