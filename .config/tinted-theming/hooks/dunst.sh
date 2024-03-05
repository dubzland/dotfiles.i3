#!/usr/bin/env bash

# Hook script to update dunst theme when base16 theme switches.
# Run in a subshell to avoid mangling the parent.
(

	# Enable tracing if the DEBUG environment variable is set
	if [[ ${DEBUG} =~ ^1|yes|true$ ]]; then
		set -o xtrace
	fi

	set -o errexit
	set -o nounset
	set -o pipefail

	function die() {
		if [[ $# -eq 1 ]]; then
			printf '%s\n' "$1"
			exit 1
		fi

		if [[ ${2-} =~ ^[0-9]+$ ]]; then
			printf '%b\n' "$1"
			exit $2
		fi
	}

	XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

	# base16-dunst theme directory
	dunst_themes_dir="$XDG_CONFIG_HOME/tinted-theming/base16-dunst/themes"
	[[ -d "${dunst_themes_dir}" ]] || die "dunst themes directory not found"

	# dunst configuration directory
	dunst_config_dir="$XDG_CONFIG_HOME/dunst"
	[[ -d "${dunst_config_dir}" ]] || die "dunst config directory not found"

	# i3 configuration drop-in directory
	dunst_config_dropins="$dunst_config_dir/dunstrc.d"
	[[ -d "${dunst_config_dropins}" ]] || die "dunst dropin directory not found"

	# Current base16 theme
	[[ -n "${BASE16_THEME}" ]] || die "No base16 theme set"

	# Grab the dunst theme file matching the current theme
	dunst_theme_file="${dunst_themes_dir}/base16-${BASE16_THEME}.dunstrc"
	[[ -r "${dunst_theme_file}" ]] || die "Theme file ${dunst_theme_file} not found."

	ln -sf "${dunst_theme_file}" "${dunst_config_dropins}/base16.conf"

	# kill dunst to pick up the new theme
	if pidof dunst >/dev/null; then
		killall dunst
	fi
)
