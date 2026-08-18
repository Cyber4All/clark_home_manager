{ ... }:
{
  flake.homeModules."ghostty" =
    { config, pkgs, ... }:
    let
      useMultiplexer = config.myHost.multiplexer != "none";
      cmd =
        if useMultiplexer then
          "${
            pkgs.${config.myHost.defaultShell}
          }/bin/${config.myHost.defaultShell} --login --interactive -c ${config.myHost.multiplexer}"
        else
          "${pkgs.${config.myHost.defaultShell}}/bin/${config.myHost.defaultShell} --login --interactive";
    in
    {
      xdg.configFile."ghostty/config".text = ''
        command = ${cmd}
        font-family = JetBrains Mono
        font-size = 13
        window-theme = auto

        window-padding-x = 5
        window-padding-y = 2
        window-inherit-working-directory = true

        theme = Lovelace

        shell-integration-features = no-cursor
        cursor-style = block

        quick-terminal-position = center
        quick-terminal-screen = mouse
        window-new-tab-position = end

        macos-icon = official
        macos-titlebar-style = transparent
        macos-titlebar-proxy-icon = hidden
        macos-non-native-fullscreen = false
        macos-option-as-alt = true
        macos-window-shadow = true
      '';
    };
}
