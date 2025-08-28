self: super: with super; {
  # override the elixir-ls that's inside the beamMinimal28Packages set
  beamMinimal28Packages = super.beamMinimal28Packages // {
    "elixir-ls" = super.beamMinimal28Packages."elixir-ls".overrideAttrs (old: rec {
      pname = "elixir-ls";
      version = "0.29.3"; # change to whatever tag you want
      src = fetchFromGitHub {
        owner = "elixir-lsp";
        repo = "elixir-ls";
        rev = "v0.29.e"; # CHANGE to the tag you want
        sha256 = "1jwy188p95f8q75midqf0zbvzgdi93xnri3k64llbbj3v5lp8k4a";
      };
    });
  };
}
