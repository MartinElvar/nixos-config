{ pkgs, fetchpatch, ... }:

{
  programs = {
    helix = {
      enable = true;
      package = pkgs.helix;

      settings = {
        theme = "catppuccin_macchiato";
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
        language-servers = ["elixir-ls"];
      }];
    };
  };
}
