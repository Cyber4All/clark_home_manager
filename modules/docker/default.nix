{ ... }:
{
  flake.homeModules."docker" =
    { lib, pkgs, ... }:
    {
      home.packages =
        with pkgs;
        [ lazydocker ] ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [ orbstack ];
    };
}
