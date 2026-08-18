# secured-macbook

Work-only M3 MacBook (Apple Silicon, `aarch64-darwin`).

Notes:

- Strictly for work.
- Home Manager config sets `home.username = "luis"` and `home.homeDirectory = "/Users/luis"`.
- macOS hosts import nixpkgs with the `emacs-lsp-booster` overlay.

Run:

```sh
home-manager build --flake .#secured-macbook
home-manager switch --flake .#secured-macbook
```
