# DOOM EMACS

I mainly use Emacs to write prose such as notes, papers (typst or latex) or quick file edits.

## Features
- LLM integration via [gptel](https://github.com/karthink/gptel)
- Non evil keybinds
- Custom org capture templates
- Auto light/dark theme

## Installation

Implementing nix overlays to patch Emacs to be in feature parity with [Emacs Plus](https://github.com/d12frosted/homebrew-emacs-plus) was too involved for my taste and it felt too janky with MacOS.

- `brew tap d12frosted/emacs-plus`
- `brew install emacs-plus`

### Doom Emacs

Install Doom Emacs according to its [README](https://github.com/doomemacs/doomemacs?tab=readme-ov-file#install).

> Path to the doom binary should be in env var PATH

## Misc. quirks

### [How to force emacs projectile to reinitialize a project?](https://stackoverflow.com/questions/40623499/how-to-force-emacs-projectile-to-reinitialize-a-project)

> Clears projectile cache so files that used to exists doesn't show up in `projectile-find-file`

`C-u C-c p f` or invoke `projectile-invalidate-cache`
