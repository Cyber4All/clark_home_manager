{ ... }:
{
  flake.homeModules."fzf" =
    { ... }:
    {
      programs.fzf = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };
    };
}
