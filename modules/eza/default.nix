{ ... }:
{
  flake.homeModules."eza" =
    { config, lib, ... }:
    {
      programs.eza = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
        git = true;
        icons = "auto";
      };

      programs.fish = lib.mkIf (config.myHost.defaultShell == "fish") {
        shellAbbrs = {
          ls = "eza";
        };
      };

      programs.zsh = lib.mkIf (config.myHost.defaultShell == "zsh") {
        shellAliases = {
          ls = "eza";
        };
      };
    };
}
