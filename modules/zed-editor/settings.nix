{ ... }:
{
  flake.homeModules."zed-editor" =
    { ... }:
    {
      programs.zed-editor.userSettings = {
        # editorUiSettings
        preview_tabs.enabled = false;
        show_whitespaces = "trailing";
        inlay_hints.enabled = false;

        icon_theme = {
          light = "Catppuccin Latte";
          dark = "Catppuccin Mocha";
        };
        theme = {
          light = "Fleet Light";
          dark = "Kanagawa Dragon";
        };

        indent_guides = {
          enabled = true;
          coloring = "indent_aware";
        };
        soft_wrap = "editor_width";
        scrollbar.show = "auto";

        cursor_blink = false;
        relative_line_numbers = "enabled";

        ui_font_size = 15;
        ui_font_family = ".ZedSans";
        buffer_font_family = "ZedMono Nerd Font Mono";
        buffer_font_size = 13.0;
        buffer_font_weight = 350;
        buffer_font_features.liga = true;

        # formattingSettings
        format_on_save = "on";
        formatter = "auto";

        # vimSettings
        vim_mode = true;
        vim = {
          use_system_clipboard = "always";
          toggle_relative_line_numbers = true;
        };

        # panelSettings
        git_panel.dock = "left";
        project_panel.dock = "right";

        git = {
          inline_blame.delay_ms = 2000;
          show_commit_summary = true;
        };

        tabs = {
          file_icons = true;
          git_status = true;
          show_diagnostics = "errors";
        };

        tab_bar = {
          show_nav_history_buttons = false;
          show = false;
        };

        # terminalSettings
        terminal = {
          shell.program = "fish";
          font_family = "ZedMono Nerd Font Mono";
          font_size = 13;
          option_as_meta = true;
          working_directory = "current_project_directory";
        };

        # predictionSettings
        edit_predictions = {
          provider = "none";
          mode = "subtle";
        };

        # agentSettings
        agent = {
          default_profile = "ask";
          profiles.edit = {
            name = "Edit";
            tools = {
              diagnostics = true;
              read_file = true;
              create_directory = false;
              edit_file = true;
            };
            enable_all_context_servers = false;
            context_servers = { };
          };
          single_file_review = true;
          dock = "left";
        };

        # telemetrySettings
        telemetry = {
          diagnostics = false;
          metrics = false;
        };

        # fileScanSettings
        file_scan_exclusions = [
          "**/.git"
          "**/.svn"
          "**/.hg"
          "**/CVS"
          "**/.DS_Store"
          "**/Thumbs.db"
          "**/.classpath"
          "**/.settings"
          "**/out"
          "**/dist"
          "**/.husky"
          "**/.turbo"
          "**/.vscode-test"
          "**/.vscode"
          "**/.next"
          "**/.storybook"
          "**/.tap"
          "**/.nyc_output"
          "**/report"
          "**/node_modules"
        ];
      };
    };
}
