{ ... }:
{
  flake.homeModules."yaml" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [ yaml-language-server ];
    };
}
