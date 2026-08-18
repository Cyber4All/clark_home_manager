{ inputs, ... }:

{
  flake.homeModules.lazyvim =
    { ... }:
    {
      imports = [
        inputs.lazyvim.homeManagerModules.default
      ];
      programs.lazyvim = {
        enable = true;
        installCoreDependencies = true;

        config = { };

        extras = {
          coding.yanky = {
            enable = true;
          };

          lang.python = {
            enable = true;
          };

          lang.go = {
            enable = true;
          };

          lang.nix = {
            enable = true;
          };

          lang.typescript = {
            enable = true;
          };
        };
      };
    };
}
