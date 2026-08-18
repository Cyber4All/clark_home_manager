{ ... }:
{
  flake.homeModules."zed-editor" =
    { ... }:
    {
      programs.zed-editor.userSettings.lsp = {
        biome = {
          settings.inline_config = {
            linter = {
              rules = {
                complexity = {
                  noStaticOnlyClass = "off";
                };
              };
            };
          };
        };
        nixd = {
          settings = {
            diagnostic = {
              suppress = [ "sema-extra-with" ];
            };
          };
        };
        vtsls = {
          settings = {
            typescript.updateImportsOnFileMove.enabled = "always";
            javascript.updateImportsOnFileMove.enabled = "always";
          };
          enable_lsp_tasks = true;
        };

        tinymist.settings = {
          exportPdf = "onSave";
          outputPath = "$root/$name";
        };
      };
    };
}
