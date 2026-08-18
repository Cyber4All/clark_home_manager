{ ... }:
{
  flake.homeModules."emacs" =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      cfg = config.myHost.emacs;
    in
    {
      options.myHost.emacs = {
        profile = lib.mkOption {
          type = lib.types.enum [
            "doom"
            "minimal"
          ];
          default = "doom";
          description = "Emacs configuration flavor (doom or minimal)";
        };
      };

      config = lib.mkMerge [
        {
          programs.emacs = {
            enable = true;
          };

          # BUG: emacs daemon doesn't respect the proper colorscheme
          services.emacs = {
            enable = false;
            client = {
              enable = true;
              arguments = [ "-nw" ];
            };
            defaultEditor = true;
            startWithUserSession = "graphical";
          };

          programs.fish.shellAbbrs = {
            e = "emacs -nw .";
          };

          home.packages = [ pkgs.emacs-lsp-booster ];
        }
        (lib.mkIf (cfg.profile == "doom") {
          xdg.configFile."doom".source = ./doom/config;
          home.sessionPath = [
            "${config.home.homeDirectory}/.config/emacs/bin"
          ];
        })
        (lib.mkIf (cfg.profile == "minimal") {
          xdg.configFile."emacs".source = ./minimal/config;
        })
      ];
    };
}
