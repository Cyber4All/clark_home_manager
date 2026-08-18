{
  description = "securEd Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:vic/import-tree";

    emacs-lsp-booster.url = "github:slotThe/emacs-lsp-booster-flake";
    lazyvim.url = "github:pfassina/lazyvim-nix";

    alacritty-themes = {
      url = "github:alacritty/alacritty-theme";
      flake = false;
    };

    peon-ping.url = "github:PeonPing/peon-ping";
    herdr.url = "github:ogulcancelik/herdr/v0.7.5";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "aarch64-darwin"
      ];

      imports = [
        inputs.flake-parts.flakeModules.modules
        inputs.home-manager.flakeModules.home-manager

        (inputs.import-tree ./modules)
      ];
    };
}
