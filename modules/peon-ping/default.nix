{ inputs, ... }:
{
  flake.homeModules."peon-ping" =
    { config, pkgs, ... }:
    let
      peonPackage = inputs.peon-ping.packages.${pkgs.system}.default;
      agyAdapter = "bash ${peonPackage}/share/peon-ping/adapters/antigravity.sh";
      codexAdapter = "bash ${peonPackage}/share/peon-ping/adapters/codex.sh";
    in
    {
      imports = [ inputs.peon-ping.homeManagerModules.default ];

      programs.peon-ping = {
        enableZshIntegration = false;
        enable = true;
        package = peonPackage;
        settings = {
          default_pack = "glados";
          volume = 1.0;
          enabled = true;
          desktop_notifications = false;
          categories = {
            "session.start" = true;
            "task.complete" = true;
            "task.error" = true;
            "input.required" = true;
            "resource.limit" = true;
            "user.spam" = false;
          };
        };
        installPacks = [
          "glados"
          {
            name = "ad-libs";
            src = pkgs.fetchFromGitHub {
              owner = "garysheng";
              repo = "peonping-rapper-adlibs";
              rev = "main";
              sha256 = "sha256-MYQITWqHXZUcoQZbIYKu80k/okS9q677LuDivihDrfw=";
            };
          }
        ];
      };

      home.sessionPath = [
        "${config.home.homeDirectory}/.openpeon"
      ];

      home.file.".codex/hooks.json".text = builtins.toJSON {
        description = "Peon ping hook";
        hooks = {
          SessionStart = [
            {
              hooks = [
                {
                  type = "command";
                  command = codexAdapter;
                  timeout = 10;
                }
              ];
            }
          ];
          SessionEnd = [
            {
              hooks = [
                {
                  type = "command";
                  command = codexAdapter;
                  timeout = 3;
                }
              ];
            }
          ];
          SubagentStart = [
            {
              hooks = [
                {
                  type = "command";
                  command = codexAdapter;
                  timeout = 10;
                }
              ];
            }
          ];
          SubagentStop = [
            {
              hooks = [
                {
                  type = "command";
                  command = codexAdapter;
                  timeout = 10;
                }
              ];
            }
          ];
          UserPromptSubmit = [
            {
              hooks = [
                {
                  type = "command";
                  command = codexAdapter;
                  timeout = 10;
                }
              ];
            }
          ];
          Stop = [
            {
              hooks = [
                {
                  type = "command";
                  command = codexAdapter;
                  timeout = 10;
                }
              ];
            }
          ];
          PermissionRequest = [
            {
              hooks = [
                {
                  type = "command";
                  command = codexAdapter;
                  timeout = 10;
                }
              ];
            }
          ];
          PreToolUse = [
            {
              hooks = [
                {
                  type = "command";
                  command = codexAdapter;
                  timeout = 10;
                }
              ];
            }
          ];
          PostToolUse = [
            {
              hooks = [
                {
                  type = "command";
                  command = codexAdapter;
                  timeout = 10;
                }
              ];
            }
          ];
          PreCompact = [
            {
              hooks = [
                {
                  type = "command";
                  command = codexAdapter;
                  timeout = 10;
                }
              ];
            }
          ];
        };
      };

      home.file.".gemini/config/hooks.json".text = builtins.toJSON {
        peon-ping = {
          PreInvocation = [
            {
              matcher = "startup";
              hooks = [
                {
                  type = "command";
                  command = agyAdapter;
                  timeout = 10;
                }
              ];
            }
          ];
          PostInvocation = [
            {
              matcher = ".*";
              hooks = [
                {
                  type = "command";
                  command = agyAdapter;
                  timeout = 10;
                }
              ];
            }
          ];
          PreToolUse = [
            {
              matcher = "run_command";
              hooks = [
                {
                  type = "command";
                  command = agyAdapter;
                  timeout = 10;
                }
              ];
            }
          ];
          PostToolUse = [
            {
              matcher = ".*";
              hooks = [
                {
                  type = "command";
                  command = agyAdapter;
                  timeout = 10;
                }
              ];
            }
          ];
          Stop = [
            {
              matcher = ".*";
              hooks = [
                {
                  type = "command";
                  command = agyAdapter;
                  timeout = 10;
                }
              ];
            }
          ];
        };
      };
    };
}
