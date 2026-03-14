#!/bin/bash

install_packages() {
  local installer=$1
  local pkgfile=$2

  echo "Installing packages from $pkgfile..."
  while IFS= read -r package; do
    # Skip empty lines and comments
    if [[ -n "$package" && ! "$package" =~ ^# ]]; then
      echo "Installing $package"
      $installer -S --noconfirm "$package"
    fi
  done <"$pkgfile"
}

if ! command -v yay &>/dev/null; then
  echo "Installing yay..."
  sudo pacman -S --noconfirm yay
fi

install_packages "sudo pacman" "pkgcore.txt"

install_packages "yay" "pkgaur.txt"

# Install zap-zsh
zsh <(curl -s https://raw.githubusercontent.com/zap-zsh/zap/master/install.zsh) --branch release-v1

echo "Package installation complete!"

echo "Installing Waybar pomodoro module..."

mkdir -p "$HOME/.local/bin"

TMP_DIR=$(mktemp -d)
echo "Cloning repository into $TMP_DIR..."
git clone https://github.com/Andeskjerf/waybar-module-pomodoro.git "$TMP_DIR"

cd "$TMP_DIR"
echo "Building release..."
cargo build --release

echo "Copying binary to ~/.local/bin..."
cp target/release/waybar-module-pomodoro "$HOME/.local/bin/"

echo "Removing temporary build directory..."
cd ~
rm -rf "$TMP_DIR"

echo "waybar-module-pomodoro installed successfully!"
