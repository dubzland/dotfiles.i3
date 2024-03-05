#!/usr/bin/env bash

# Hook script to update rofi theme when base16 theme switches.
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

	# base16-rofi theme directory
	rofi_theme_dir="$XDG_CONFIG_HOME/tinted-theming/base16-rofi/themes"
	[[ -d "${rofi_theme_dir}" ]] || die "rofi theme directory not found"

	# rofi configuration directory
	rofi_config_dir="$XDG_CONFIG_HOME/rofi"
	[[ -d "${rofi_config_dir}" ]] || die "rofi config directory not found"

	# Current base16 theme
	[[ -n "${BASE16_THEME}" ]] || die "No base16 theme set"

	# Make sure a matching theme exists
	rofi_theme_file="${rofi_theme_dir}/base16-${BASE16_THEME}.rasi"
	[[ -r "${rofi_theme_file}" ]] || die "rofi theme ${rofi_theme_file} not found"

	echo "@theme \"base16-${BASE16_THEME}\"" > "${rofi_config_dir}/base16-theme.rasi"
)
