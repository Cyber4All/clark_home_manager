{ ... }:
{
  flake.homeModules."zed-editor" =
    { ... }:
    {
      programs.zed-editor.userSettings.languages = {
        Python = {
          formatter.language_server.name = "ruff";
          language_servers = [
            "ty"
            "ruff"
          ];
        };

        Nix.language_servers = [ "nixd" ];
      };
    };
}
