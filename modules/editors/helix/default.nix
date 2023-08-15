{ pkgs, ... }:

{
  programs = {
    helix = {
      enable = true;

      settings = {
        theme = "default";
      };

      languages.language = [{
        name = "elixir";
        scope = "source.elixir";
        injection-regex = "elixir";
        file-types = ["ex" "exs" "html.heex"];
        roots = ["mix.exs"];
        auto-format = true;
        diagnostic-severity = "Hint";
        comment-token = "#";
        indent = {tab-width = 2; unit = " ";};
        language-server = {command = "elixir-ls";};
      }];
    };
  };
}
