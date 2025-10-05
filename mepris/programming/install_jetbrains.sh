#!/bin/bash
set -e

# Usage: ./install_jetbrains.sh <product_name> <version> <download_url>
# Example:
# ./install_jetbrains.sh rider 2024.1.4 "https://download-cdn.jetbrains.com/rider/JetBrains.Rider-2024.1.4.tar.gz"

PRODUCT_NAME="$1"
VERSION="$2"
DOWNLOAD_URL="$3"

if [ -z "$PRODUCT_NAME" ] || [ -z "$VERSION" ] || [ -z "$DOWNLOAD_URL" ]; then
  echo "Usage: $0 <product_name> <version> <download_url>"
  exit 1
fi

ARCHIVE="${PRODUCT_NAME}-${VERSION}.tar.gz"

wget -c --progress=bar:force -O "$ARCHIVE" "$DOWNLOAD_URL"

EXTRACTED_NAME=$(tar -tf "$ARCHIVE" | head -n1 | cut -d'/' -f1)

if [ -z "$EXTRACTED_NAME" ]; then
  echo "Failed to determine extracted directory name from $ARCHIVE" >&2
  exit 1
fi

echo "Extracting to /opt/jetbrains..."
sudo mkdir -p /opt/jetbrains
sudo tar -xzf "$ARCHIVE" -C /opt/jetbrains

sudo ln -sfn "/opt/jetbrains/$EXTRACTED_NAME" "/opt/jetbrains/$PRODUCT_NAME"

rm -f "$ARCHIVE"

DESKTOP_FILE="$HOME/.local/share/applications/${PRODUCT_NAME}.desktop"
mkdir -p "$(dirname "$DESKTOP_FILE")"

cat > "$DESKTOP_FILE" <<EOL
[Desktop Entry]
Version=1.0
Type=Application
Name=$(echo "$PRODUCT_NAME" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')
Exec=/opt/jetbrains/${PRODUCT_NAME}/bin/${PRODUCT_NAME}
Icon=/opt/jetbrains/${PRODUCT_NAME}/bin/${PRODUCT_NAME}.png
Categories=Development;IDE;
Terminal=false
EOL

echo "$PRODUCT_NAME installation completed successfully."
