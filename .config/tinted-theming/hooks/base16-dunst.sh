#!/usr/bin/env bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

function die() {
	printf "%s\n" "$*" >&2
}

# base16-dunst theme directory
DUNST_THEMES_DIR="$XDG_CONFIG_HOME/tinted-theming/base16-dunst/themes"
[[ -d "${DUNST_THEMES_DIR}" ]] || die "dunst themes directory not found"

# dunst configuration directory
DUNST_CONFIG_DIR="$XDG_CONFIG_HOME/dunst"
[[ -d "${DUNST_CONFIG_DIR}" ]] || die "dunst config directory not found"

# i3 configuration drop-in directory
DUNST_CONFIG_DROPINS="$DUNST_CONFIG_DIR/dunstrc.d"
[[ -d "${DUNST_CONFIG_DROPINS}" ]] || die "dunst dropin directory not found"

# Current base16 theme
[[ -n "${BASE16_THEME}" ]] || die "No base16 theme set"

# Grab the dunst theme file matching the current theme
DUNST_THEME_FILE="${DUNST_THEMES_DIR}/base16-${BASE16_THEME}.dunstrc"
[[ -r "${DUNST_THEME_FILE}" ]] || die "Theme file ${DUNST_THEME_FILE} not found."

ln -sf "${DUNST_THEME_FILE}" "${DUNST_CONFIG_DROPINS}/base16.conf"

# kill dunst to pick up the new theme
if pidof dunst >/dev/null; then
	killall dunst
fi
