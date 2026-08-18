{ ... }:
{
  flake.homeModules."markdown" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        marksman
        pandoc
        python314Packages.grip
      ];
    };
}
