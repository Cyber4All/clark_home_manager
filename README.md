# Home Manager Configuration

This repository contains a flake-based Home Manager configuration for the
`secured-macbook` host.


> If you want to version control your own changes, feel free to fork this repository.

> You do not need to be a nix expert to be able to make your changes.

> Happy hacking!

## Directory Structure

```text
.
├── flake.nix
├── flake.lock
└── modules
    ├── <module-name>
    │   ├── default.nix
    │   └── README.md
    ├── global-options
    │   └── default.nix
    ├── hosts
    │   └── secured-macbook
    │       ├── default.nix
    │       ├── packages.nix
    │       └── README.md
    └── macos
        ├── fonts.nix
        └── session-path.nix
```

`flake.nix` defines the flake inputs and imports everything under `modules/`
with `import-tree`.

`modules/<module-name>/default.nix` defines one reusable Home Manager module.
Most modules expose themselves as `flake.homeModules."<module-name>"`.

`modules/global-options/default.nix` defines shared host options under
`myHost`, such as Git identity, default shell, and terminal multiplexer
settings.

`modules/hosts/secured-macbook/default.nix` defines the active Home Manager
configuration. Its `modules = [ ... ];` list decides which reusable modules are
enabled for this host.

`modules/hosts/secured-macbook/packages.nix` defines extra packages that are
specific to this host and exposes them as `hm."secured-macbook-packages"`.

## Modify a Module

To change an existing module, edit its `default.nix` file under `modules/`.

For example, Git settings live in:

```text
modules/git/default.nix
```

That module reads shared values from `config.myHost.git`:

```nix
programs.git.settings.user = {
  email = config.myHost.git.email;
  name = config.myHost.git.name;
};
```

Host-specific values for those options are set in:

```text
modules/hosts/secured-macbook/default.nix
```

Use that host file when a value should differ per machine. Use the module file
when the behavior should apply anywhere that module is imported.

## Add a New Module

Create a new directory under `modules/` with a `default.nix` file:

```text
modules/example/default.nix
```

Define the module with the same `flake.homeModules` pattern used elsewhere:

```nix
{ ... }:
{
  flake.homeModules.example =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        hello
      ];
    };
}
```

If the module name contains a dash, quote the attribute name:

```nix
flake.homeModules."zed-editor" = { ... }: {
  programs.zed-editor.enable = true;
};
```

After creating the module, import it from the host by adding `hm.example` or
`hm."<module-name>"` to the host's `modules = [ ... ];` list.

## Pick Modules for a Host

The active module list for this machine is in:

```text
modules/hosts/secured-macbook/default.nix
```

Inside that file, `hm` is an alias for `inputs.self.homeModules`:

```nix
let
  hm = inputs.self.homeModules;
in
{
  flake.homeConfigurations."secured-macbook" =
    inputs.home-manager.lib.homeManagerConfiguration {
      modules = [
        hm."global-options"
        hm.fish
        hm.git
      ];
    };
}
```

To enable a module, add it to the `modules = [ ... ];` list:

```nix
hm.zoxide
```

To disable a module, remove it from the list or comment it out:

```nix
# hm.zoxide
```

Quoted module names are required when the attribute contains a dash:

```nix
hm."zed-editor"
hm."peon-ping"
hm."secured-macbook-packages"
```

Keep `hm."global-options"` near the top of the list. Other modules rely on the
`myHost` options it defines.

If you change `myHost.defaultShell`, make sure the matching shell module is also
included. For example, `defaultShell = "fish";` requires `hm.fish`.

## Apply Configuration Changes

If Home Manager is not available on your path yet, you can run it through the
flake input:

```sh
nix run home-manager -- switch --flake .#secured-macbook
```

After editing modules or host settings, apply the configuration with:

```sh
home-manager switch --flake .#secured-macbook
```

Run this command from the repository root.

## Common Workflows

Change host identity or defaults:

1. Edit the inline `myHost = { ... };` block in
   `modules/hosts/secured-macbook/default.nix`.
2. Run `home-manager switch --flake .#secured-macbook`.

Change a tool setting:

1. Edit the tool module under `modules/<tool>/default.nix`.
2. Confirm the module is listed in `modules/hosts/secured-macbook/default.nix`.
3. Run `home-manager switch --flake .#secured-macbook`.

Add a host-specific package:

1. Edit `modules/hosts/secured-macbook/packages.nix`.
2. Add the package to `home.packages`.
3. Confirm `hm."secured-macbook-packages"` is listed in the host module list.
4. Run `home-manager switch --flake .#secured-macbook`.

