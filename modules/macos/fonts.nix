{ ... }:
{
  flake.homeModules.macos = {
    imports = [
      (
        { pkgs, ... }:
        {
          home.packages = with pkgs; [
            nerd-fonts.fira-code
            nerd-fonts.jetbrains-mono
            nerd-fonts.roboto-mono
            nerd-fonts.zed-mono
            nerd-fonts.dejavu-sans-mono
            borg-sans-mono
            alegreya
            julia-mono
            ioskeley-mono.normal
          ];
        }
      )
    ];
  };
}
