SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
sudo mkdir -p /usr/share/backgrounds
sudo cp -r "$SCRIPT_DIR"/* /usr/share/backgrounds/
