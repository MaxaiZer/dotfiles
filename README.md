# dotfiles

## Installation

- Install stow (e.g. `sudo dnf install stow`)
- Clone repo
- Run `stow <package-name>` inside the repo folder  
For example, after running `stow kitty`, symlinks will be created in `~/.config/kitty`  

But if folder contains install.sh, just run it.

## Tips
- Don't forget to set profile MyProfile in Konsole after stow.
- If config file contains NAME_OF_THE_USER, run `./correct_username.sh <file>` to replace it with your username.
