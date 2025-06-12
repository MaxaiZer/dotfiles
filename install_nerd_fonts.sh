#!/bin/bash

set -e

LATEST_VERSION=$(curl -s https://api.github.com/repos/ryanoasis/nerd-fonts/releases/latest | jq -r '.tag_name')
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/download/${LATEST_VERSION}/JetBrainsMono.zip"
TMP_DIR="/tmp/jetbrainsmono-nerdfont"
FONT_INSTALL_DIR="/usr/share/fonts/nerd-fonts"

mkdir -p "$TMP_DIR"

echo "Downloading JetBrainsMono Nerd Font..."
curl -L -o "$TMP_DIR/JetBrainsMono.zip" "$FONT_URL"

echo "Extracting fonts..."
unzip -o "$TMP_DIR/JetBrainsMono.zip" -d "$TMP_DIR"

sudo mkdir -p "$FONT_INSTALL_DIR"

echo "Installing fonts to $FONT_INSTALL_DIR..."
sudo cp -v "$TMP_DIR"/*.ttf "$FONT_INSTALL_DIR/"

echo "Refreshing font cache..."
sudo fc-cache -fv

echo "Cleaning up..."
rm -rf "$TMP_DIR"

echo "JetBrainsMono Nerd Font installed successfully!"
