{ ... }:
{
  flake.homeModules."zsh" =
    { ... }:
    {
      programs.zsh = {
        enable = true;
        autocd = true;
        syntaxHighlighting.enable = true;
        completionInit = "autoload -Uz compinit && compinit";
        zplug = {
          enable = true;
          plugins = [
            { name = "zsh-users/zsh-autosuggestions"; }
            { name = "zsh-users/zsh-syntax-highlighting"; }
            { name = "zsh-users/zsh-history-substring-search"; }
          ];
        };
      };
    };
}
