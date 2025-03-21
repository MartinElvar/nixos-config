{pkgs, ...}:

{
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>gg";
      action = ":lua Snacks.lazygit.open()<CR>";
      options = {
        desc = "Open LazyGit";
      };
    }
  ];
}
