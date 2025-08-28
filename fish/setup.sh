#!/bin/bash
set -e

echo "Setting Fish as the default shell..."
sudo chsh -s "$(which fish)" $USER

if [ -d "$HOME/.local/share/omf" ]; then
  echo "Oh My Fish is already installed."
else
  echo "Installing Oh My Fish..."
  curl -L https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
fi

fish -c "omf install fzf"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ln -sf "$SCRIPT_DIR/config.fish" "$HOME/.config/fish/config.fish"
echo "Created symlink for config.fish"
