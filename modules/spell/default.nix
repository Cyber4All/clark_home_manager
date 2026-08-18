{ ... }:
{
  flake.homeModules."spell" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ hunspell ];
    };
}
