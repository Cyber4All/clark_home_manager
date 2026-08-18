{ ... }:
{
  flake.homeModules."direnv" =
    { ... }:
    {
      programs.direnv = {
        enable = true;
        silent = true;
      };
    };
}
