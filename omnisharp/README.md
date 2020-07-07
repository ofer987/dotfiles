# How to instal OmniSharp server and vim Plugin

## Required

- Run `:OmniSharpInstall` in **vim** according to https://github.com/OmniSharp/Omnisharp-vim#server

## Optional

- Move `~/.omnisharp` to `/.yadr/vim/omnisharp/<major.minor.patch>`
- Symlink `~/.yadr/vim/omnisharp/<major.minor.patch>` back to `~/.omnisharp`, e.g., 
  ```bash
  ln -s ~/.yadr/omnisharp/1.35.3 ~/.omnisharp
  ```
