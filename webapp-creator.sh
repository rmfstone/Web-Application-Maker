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
  while true; do
    echo "Figlet is not installed."
    read -p "Do you want to install figlet now? (y/n): " install_figlet
    if [[ "$install_figlet" =~ [Yy] ]]; then
      sudo pacman -S --noconfirm figlet
      break
    elif [[ "$install_figlet" =~ [Nn] ]]; then
      echo "Proceeding without figlet..."
      break
    else
      "Not a valid option, choose eather y or n!"
    fi
  done
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
    if [[ "$URL" =~ \  || "$URL" == "" ]]; then
      echo "Spaces are not allowed!"
      read -p "Enter your desired URL: " URL
    else
      break
    fi
  done

  read -p "Enter App Name: " APP
  FILE="$HOME/.local/share/applications/$APP.desktop"

  # download icon
  read -p "Do you want to use a icon? (y/n) : " use_icon

  if [[ "$use_icon" =~ "" ]]; then
    use_icon="y"
  fi

  if [[ "$use_icon" != [YyNn] ]]; then
    while true; do
      read -p "Do you want to use a icon? (y/n) : " use_icon
      if [[ "$use_icon" =~ [[YyNn] ]]; then
        break
      fi
    done
  fi

  read -p "Where do you want the icons to be saved? (default: ~/.local/share/icons/webicons): " icon_loaction
  while true; do
    if [[ "$icon_loaction" =~ "" ]]; then
      icon_loaction="$HOME/.local/share/icons/webicons"
      break
    elif [[ "$icon_loaction" = \  ]]; then
      read -p "Where do you want the icons to be saved? (default: ~/.local/share/icons): " icon_loaction
    else
      break
    fi
  done

  if [[ ! -d "$icon_loaction" ]]; then
    mkdir "$icon_loaction"
  fi

  if [[ "$use_icon" =~ [Yy] ]]; then
    read -p "Enter icon link (if nothing the script will try to download the favicon from the given URL): " custom_icon_link
    while true; do
      if [[ "$custom_icon_link" =~ "" ]]; then
        wget -O "$icon_loaction/$APP.png" "https://www.google.com/s2/favicons?domain=$URL&sz=128"
        break
      elif [[ "$custom_icon_link" =~ \  ]]; then
        echo "Spaces are not allowed!"
        read -p "Enter icon link (if nothing the script will try to download the favicon from the given URL): " custom_icon_link
      else
        wget -O "$icon_loaction/$APP.png" "$custom_icon_link"
        break
      fi
    done
  fi

  cat <<EOF >"$FILE"
[Desktop Entry]
Name=$APP
Exec=chromium --app=$URL
Terminal=false
Icon=$icon_loaction/$APP.png
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
