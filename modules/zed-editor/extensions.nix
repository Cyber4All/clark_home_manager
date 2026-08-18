{ ... }:
{
  flake.homeModules."zed-editor" =
    { ... }:
    {
      programs.zed-editor.extensions = [
        "fleet-themes"
        "kanagawa themes"
        "catppucin-icons"
        "catppucin"
        "nix"
      ];
    };
}
