{ inputs, ... }:
{
  flake.homeModules."alacritty" =
    { config, pkgs, ... }:
    let
      themes = inputs.alacritty-themes;
      useMultiplexer = config.myHost.multiplexer != "none";
    in
    {
      programs.alacritty = {
        enable = true;
        settings = {
          terminal.shell = {
            program = "${pkgs.${config.myHost.defaultShell}}/bin/${config.myHost.defaultShell}";
            args =
              if useMultiplexer then
                [
                  "--login"
                  "--interactive"
                  "-c"
                  config.myHost.multiplexer
                ]
              else
                [
                  "--login"
                  "--interactive"
                ];
          };
          window = {
            padding = {
              x = 10;
              y = 8;
            };
            startup_mode = "Windowed";
            dynamic_padding = true;
            dynamic_title = true;
            option_as_alt = "Both";
            decorations = "Buttonless";
            decorations_theme_variant = "Dark";
          };
          font = {
            normal = {
              family = "ZedMono Nerd Font";
              style = "Light";
            };
            size = 14;
          };
          selection.save_to_clipboard = true;
          general.import = [ "${config.xdg.configFile."alacritty/theme.toml".source}" ];
        };
      };

      xdg.configFile."alacritty/theme.toml".source =
        let
          themeName = "hatsunemiku";
          ext = "toml";
        in
        "${themes}/themes/${themeName}.${ext}";
    };
}
