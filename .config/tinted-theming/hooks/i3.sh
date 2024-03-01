#!/usr/bin/env bash

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

function die() {
	printf "%s\n" "$*" >&2
}

# base16-i3 colors directory
I3_COLORS_DIR="$XDG_CONFIG_HOME/tinted-theming/base16-i3/colors"
[[ -d "${I3_COLORS_DIR}" ]] || die "i3 colors directory not found"

# i3 configuration directory
I3_CONFIG_DIR="$XDG_CONFIG_HOME/i3"
[[ -d "${I3_CONFIG_DIR}" ]] || die "i3 config directory not found"

# i3 configuration drop-in directory
I3_CONFIG_DROPINS="$I3_CONFIG_DIR/conf.d"
[[ -d "${I3_CONFIG_DROPINS}" ]] || die "i3 dropin directory not found"

# Current base16 theme
[[ -n "${BASE16_THEME}" ]] || die "No base16 theme set"

# Grab the i3 colors file matching the current theme
I3_COLORS_FILE="${I3_COLORS_DIR}/base16-${BASE16_THEME}.config"
[[ -r "${I3_COLORS_FILE}" ]] || die "Colors file ${I3_COLORS_FILE} not found."

ln -sf "${I3_COLORS_FILE}" "${I3_CONFIG_DIR}/conf.d/colors.conf"
if command -v i3-merge-config > /dev/null; then
	i3-merge-config -f
	if pidof i3 >/dev/null; then
		i3-msg reload >/dev/null
	fi
fi