{ ... }:
{
  flake.homeModules."core" =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        coreutils
        curl
        devenv
        gawkInteractive
        opencode
        hyperfine
        tokei
        tree
        unixtools.watch
        wget
        xh
        zstd
        ripgrep
        fd
        bat
        jq
      ];
    };
}
