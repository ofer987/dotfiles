# OmniSharp

## Prerequisites

1. Mono (>= 5.4.1.6)
2. NeoVim 0.2.0
3. python3 and pip3
4. neovim python library
  - `pip3 install --upgrade neovim`

## Instructions

1. Install [vim plugin](https://github.com/OmniSharp/Omnisharp-vim)
  - Preferably my version from ofer987/Omnisharp-vim
2. Install OmniSharp Roslyn server:
  - Download archive at https://github.com/OmniSharp/omnisharp-roslyn/releases
    - Make sure you get the one named http for your platform
    - untar it to local directory
  - Set server path as `let g:OmniSharp_server_path = 'mono C:\OmniSharp\omnisharp.http-win-x64\OmniSharp.exe'`
