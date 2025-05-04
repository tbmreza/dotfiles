dotfiles
========

My config files

## Using [stow](https://www.gnu.org/software/stow/)

1. Clone this repo to `$HOME`.
1. Each folder contains the things you want to link to. To link config for nvim: `stow nvim`.

By `stow`ing once, you'll see changes in `dotfiles` automatically reflected in `~/.config` (where apps actually read from).

## Native Windows notes

Using stow is tested to work perfectly in Windows WSL. I am not aware of an existing elegant solution that generalizes to native (non-WSL) Windows. The foreseeable issue with such solutions is you're not keen to use PowerShell (as PowerShell Core runs everywhere) when you're not on Windows; you don't get maximum dev happiness even in that timeline.

If you don't know where to start, type `%appdata%` in file explorer and hit enter. nvim reads from `~\AppData\Local\nvim\init.lua`, while Postman and VSCodium from `~\AppData\Roaming\`, for example.
