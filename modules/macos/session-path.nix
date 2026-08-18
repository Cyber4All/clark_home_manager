{ ... }:
{
  flake.homeModules.macos = {
    imports = [
      (
        { config, ... }:
        {
          home.sessionPath = [
            "/opt/homebrew/bin"
            "${config.home.homeDirectory}/.local/bin"
          ];
        }
      )
    ];
  };
}
