{ ... }:
{
  flake.homeModules."zoxide" =
    { config, lib, ... }:
    {
      programs.zoxide = {
        enable = true;
        enableFishIntegration = true;
        enableZshIntegration = true;
      };

      programs.fish = lib.mkIf (config.myHost.defaultShell == "fish") {
        shellAbbrs = {
          cd = "z";
        };
      };

      programs.zsh = lib.mkIf (config.myHost.defaultShell == "zsh") {
        shellAliases = {
          cd = "z";
        };
      };
    };
}
