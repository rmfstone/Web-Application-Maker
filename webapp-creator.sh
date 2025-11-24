#!/usr/bin/env bash
# Made by a Stone
# Check if chromium is installed
if ! command -V chromium >/dev/null 2>&1; then
  echo "Chromium is not installed, but is needed for the Web-Applications to work"
  read -p "Do you want to install chromium now? (y/n): " install_chromium
  if [[ "$install_chromium" =~ [Yy] ]]; then
    sudo pacman -S chromium
  else
    echo "You need to install chromium!"
    exit 1
  fi
fi

# Check if figlet is installed
if ! command -v figlet >/dev/null 2>&1; then
  echo "Figlet is not installed."
  read -p "Do you want to install figlet now? (y/n): " install_figlet
  if [[ "$install_figlet" =~ [Yy] ]]; then
    sudo pacman -S --noconfirm figlet
  else
    echo "Proceeding without figlet..."
  fi
fi

# Use figlet if available
if command -v figlet >/dev/null 2>&1; then
  figlet "Stone Util"
else
  echo "Stone Util"
fi

echo "Web-Application maker"
echo "Utility to make Web-Applications from URLs"

read -p "Do want to make or remove a Web-Application? (m/r): " makeOrRemove

while true; do
  if [[ "$makeOrRemove" != [MmRr] ]]; then
    echo "Choose from m/r"
    read -p "Do want to make or remove a Web-Application? (m/r): " makeOrRemove
  else
    break
  fi
done

# make a Web-Applications
if [[ "$makeOrRemove" == [Mm] ]]; then
  read -p "Enter your desired URL: " URL

  while true; do
    if [[ "$URL" =~ \  ]]; then
      echo "Spaces are not allowed!"
      read -p "Enter your desired URL: " URL
    else
      break
    fi
  done

  read -p "Enter App Name: " APP

  FILE="$HOME/.local/share/applications/$APP.desktop"

  cat <<EOF >"$FILE"
[Desktop Entry]
Name=$APP
Exec=chromium --app=$URL
Terminal=false
Type=Application
EOF

  chmod +x "$FILE"
  echo "Created $FILE"
fi

# remove Web-Application
if [[ "$makeOrRemove" == [Rr] ]]; then
  while true; do
    read -p "Enter your Application name to remove: " NAME
    FILE="$HOME/.local/share/applications/$NAME.desktop"
    if [[ -f "$FILE" ]]; then
      rm -i "$FILE"
      echo "Removed $FILE"
      break
    else
      echo "File does not exist. Try again."
    fi
  done
fi
