#!/usr/bin/env bash

# Hook script to update .Xresources colors when base16 theme switches.
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
			exit 0
		fi

		if [[ ${2-} =~ ^[0-9]+$ ]]; then
			printf '%b\n' "$1"
			exit $2
		fi
	}

	XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

	# base16-xresources theme directory
	xresources_themes_dir="$XDG_CONFIG_HOME/tinted-theming/base16-xresources/xresources"
	[[ -d "${xresources_themes_dir}" ]] || die "Xresources themes directory not found" 1

	# .Xresources.d directory
	xresources_config_dir="$HOME/.Xresources.d"
	[[ -d "${xresources_config_dir}" ]] || die "Xresources config dropin directory not found" 1

	# Current base16 theme
	[[ -n "${BASE16_THEME}" ]] || die "No base16 theme set" 1

	# Grab the Xresources theme file matching the current theme
	xresources_theme_file="${xresources_themes_dir}/base16-${BASE16_THEME}-256.Xresources"
	[[ -r "${xresources_theme_file}" ]] || die "Theme file ${xresources_theme_file} not found." 1

	# Update theme symlink
	ln -sf "${xresources_theme_file}" "${xresources_config_dir}/colors"

	# Reload xresources
	if [[ -v DISPLAY ]]; then
		xrdb -merge "${xresources_config_dir}/colors"
	fi
)
