#!/usr/bin/env bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

function die() {
	printf "%s\n" "$*" >&2
}

# base16-rofi theme directory
ROFI_THEME_DIR="$XDG_CONFIG_HOME/tinted-theming/base16-rofi/themes"
[[ -d "${ROFI_THEME_DIR}" ]] || die "rofi theme directory not found"

# rofi configuration directory
ROFI_CONFIG_DIR="$XDG_CONFIG_HOME/rofi"
[[ -d "${ROFI_CONFIG_DIR}" ]] || die "rofi config directory not found"

# Current base16 theme
[[ -n "${BASE16_THEME}" ]] || die "No base16 theme set"


# Make sure a matching theme exists
ROFI_THEME_FILE="${ROFI_THEME_DIR}/base16-${BASE16_THEME}.rasi"
[[ -r "${ROFI_THEME_FILE}" ]] || die "rofi theme ${ROFI_THEME_FILE} not found"

echo "@theme \"base16-${BASE16_THEME}\"" > "${ROFI_CONFIG_DIR}/base16-theme.rasi"
