{ lib, ... }:
{
  flake.homeModules."global-options" =
    { config, ... }:
    {
      options.myHost = {
        git = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "Global Git name";
            default = "User";
          };
          email = lib.mkOption {
            type = lib.types.str;
            description = "Global Git email";
            default = "user@email.com";
          };
          githubUserName = lib.mkOption {
            type = lib.types.str;
            description = "Github username";
            default = "Github user";
          };
        };
        defaultShell = lib.mkOption {
          type = lib.types.str;
          default = "fish";
          description = "The default shell to enable across the host";
        };
        multiplexer = lib.mkOption {
          type = lib.types.str;
          default = "none";
          description = "Terminal multiplexer. `none` is default";
        };
      };

      config = {
        assertions = [
          {
            assertion = config.programs.${config.myHost.defaultShell}.enable == true;
            message = "The default shell '${config.myHost.defaultShell}' is not enabled. Please ensure you imported hm.${config.myHost.defaultShell} in your host's modules array!";
          }
        ];
      };
    };
}
