{ ... }:
{
  flake.homeModules."javascript" =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.nodejs_24
        pkgs.typescript-go
        pkgs.vtsls
        pkgs.pnpm
      ];
    };
}
