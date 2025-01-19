#!/bin/bash

set -e

echo "Installing Zsh..."
sudo dnf install zsh -y

echo "Setting Zsh as the default shell..."
chsh -s "$(which zsh)"

echo "Custom: $ZSH_CUSTOM"

if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zsh is already installed."
else
    echo "Installing Oh My Zsh..." 
    sh -x -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

if [ -z "$ZSH_CUSTOM" ]; then
	ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"	
fi

if [ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    echo "zsh-autosuggestions are already installed."
else
    echo "Installing zsh-autosuggestions..."
    sudo git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

if [ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    echo "zsh-syntax-highlighting is already installed."
else
    echo "Installing zsh-syntax-highlighting..."
    sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

if [ -d "$ZSH_CUSTOM/themes/powerlevel10k" ]; then
    echo "powerlevel10k is already installed."
else
    echo "Installing Powerlevel10k theme..."
    sudo git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$ZSH_CUSTOM/themes/powerlevel10k"
fi
