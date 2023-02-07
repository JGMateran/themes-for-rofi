#! /bin/bash

DIR=`pwd`

ROFI_CONFIG_DIR="${HOME}/.config/rofi"
FONTS_DIR="${HOME}/.local/share/fonts"

ROFI_THEMES_DIR="${HOME}/.local/share/rofi/themes"

install_themes () {
  if [[ ! -d "$ROFI_THEMES_DIR" ]]; then
    echo "Creating theme directory"
    mkdir -p "$ROFI_THEMES_DIR"
  fi

  copied_themes_counter=0

  for FILE in $DIR/themes/*; do
    theme_basename="$(basename "${FILE}")"

    if [[ ! -f "${ROFI_THEMES_DIR}/${theme_basename}" ]]; then
      copied_themes_counter=$((copied_themes_counter+1))

      cp -rf "$FILE" "$ROFI_THEMES_DIR"
    fi
  done

  if [[ $copied_themes_counter == 0 ]]; then
    echo "All themes already installed"
  else
    echo "Installed themes: ${copied_themes_counter}"
  fi
}

install_fonts () {
  if [[ ! -d "$FONTS_DIR" ]]; then
    echo "Creating font directory"
    mkdir -p $FONTS_DIR
  fi

  cp -rf $DIR/configuration/fonts/* "$FONTS_DIR"

  fc-cache -fv
}

install_configuration () {
  if [[ ! -d "$ROFI_CONFIG_DIR" ]]; then
    echo "Creating configuration folder"
    mkdir -p "$ROFI_CONFIG_DIR"
  fi

  config_dir_with_file="$ROFI_CONFIG_DIR/config.rasi"

  if [[ -f "$config_dir_with_file" ]]; then
    echo "Creating backup"
    cp "$config_dir_with_file" "$config_dir_with_file.bak"
  fi

  echo "Creating configuration file"
  cp "$DIR/configuration/config.rasi" "$ROFI_CONFIG_DIR"
}

install_configuration
install_fonts
install_themes
