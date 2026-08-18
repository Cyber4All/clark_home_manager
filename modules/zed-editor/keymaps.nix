{ ... }:
{
  flake.homeModules."zed-editor" =
    { ... }:
    {
      programs.zed-editor.userKeymaps = [
        {
          context = "Editor && vim_mode == normal && vim_operator == none && !VimWaiting";
          bindings = {
            "space f s" = "workspace::Save";
            "space f f" = "file_finder::Toggle";
            "space t z" = "workspace::ToggleCenteredLayout";
            "space w s" = "pane::SplitHorizontal";
            "space t w" = "workspace::ToggleZoom";
            "space w v" = "pane::SplitVertical";
            "space b d" = "pane::CloseActiveItem";
            "space w d" = [
              "pane::CloseCleanItems"
              { close_pinned = false; }
            ];
            "space w l" = "workspace::ActivatePaneRight";
            "space w h" = "workspace::ActivatePaneLeft";
            "space w j" = "workspace::ActivatePaneDown";
            "space w k" = "workspace::ActivatePaneUp";
            tab = "pane::ActivateNextItem";
            "shift-tab" = "pane::ActivatePreviousItem";
            "space c a" = "editor::ToggleCodeActions";
            "space ." = "editor::ToggleCodeActions";
            "space c r" = "editor::Rename";
            "space s l" = "vim::PushToggleComments";
            "g d" = "editor::GoToDefinition";
            "g D" = "editor::GoToDefinitionSplit";
            "g i" = "editor::GoToImplementation";
            "g I" = "editor::GoToImplementationSplit";
            "g t" = "editor::GoToTypeDefinition";
            "g T" = "editor::GoToTypeDefinitionSplit";
            "g r" = "editor::FindAllReferences";
            "] e" = "editor::GoToDiagnostic";
            "[ e" = "editor::GoToPreviousDiagnostic";
            "space x x" = "diagnostics::Deploy";
          };
        }
        {
          context = "VimControl && !menu && vim_mode != operator";
          bindings = {
            w = "vim::NextSubwordStart";
            b = "vim::PreviousSubwordStart";
            "g e" = "vim::PreviousSubwordEnd";
          };
        }
        {
          context = "vim_mode == normal";
          bindings = {
            s = "vim::PushSneak";
          };
        }
        {
          context = "Editor && vim_mode == visual && !VimWaiting && !VimObject";
          bindings = {
            "shift-s" = "vim::PushAddSurrounds";
          };
        }
        {
          bindings = {
            "space b b" = "tab_switcher::ToggleAll";
          };
        }
      ];
    };
}
