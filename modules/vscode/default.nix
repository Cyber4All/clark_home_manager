{ ... }:
{
  flake.homeModules.vscode =
    { pkgs, ... }:
    {
      programs.vscode = {
        enable = true;
        profiles.default.extensions = with pkgs.vscode-extensions; [
          angular.ng-template
          dbaeumer.vscode-eslint
          esbenp.prettier-vscode
          yoavbls.pretty-ts-errors
        ];
      };
    };
}
