{ ... }:
{
  flake.homeModules."secured-macbook-packages" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        mongodb-compass
        slack
        codex
        awscli2
        uv
        gh-dash
        openspec
      ];
    };
}
