{ ... }:
{
  flake.homeModules."starship" =
    { ... }:
    {
      programs.starship = {
        enable = true;
        settings = {
          directory.truncation_length = 2;
          command_timeout = 100000;
          add_newline = false;
          scan_timeout = 30;
          nix_shell.symbol = "❄ ";
          git_metrics.disabled = false;
          package.disabled = true;
          git_branch = {
            truncation_length = 20;
            format = "[$symbol$branch(:$remote_branch)]($style) ";
          };
          fill.symbol = " ";
          shell = {
            fish_indicator = "🐟";
            zsh_indicator = "Z";
            nu_indicator = "Nu";
            style = "dimmed";
            disabled = false;
          };
        };
      };
    };
}
