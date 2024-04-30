#!/usr/bin/env bash

# Hook script to update i3 colors when base16 theme switches.
# Run in a subshell to avoid mangling the parent.
(
	sourced=1
	if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
		sourced=0
	fi

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
			if [[ $sourced -eq 0 ]]; then
				exit "$2"
			fi
			exit 0
		fi
	}

	XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"

	# base16-i3 colors directory
	i3_colors_dir="$XDG_CONFIG_HOME/tinted-theming/base16-i3/colors"
	[[ -d "${i3_colors_dir}" ]] || die "i3 colors directory not found" 1

	# i3 configuration directory
	i3_config_dir="$XDG_CONFIG_HOME/i3"
	[[ -d "${i3_config_dir}" ]] || die "i3 config directory not found" 1

	# i3 configuration drop-in directory
	i3_config_dropins="$i3_config_dir/conf.d"
	[[ -d "${i3_config_dropins}" ]] || die "i3 dropin directory not found" 1

	# Current base16 theme
	[[ -n "${BASE16_THEME}" ]] || die "No base16 theme set" 1

	# Grab the i3 colors file matching the current theme
	i3_colors_file="${i3_colors_dir}/base16-${BASE16_THEME}.config"
	[[ -r "${i3_colors_file}" ]] || die "Colors file ${i3_colors_file} not found." 1

	ln -sf "${i3_colors_file}" "${i3_config_dir}/conf.d/colors.conf"
	if command -v i3-merge-config > /dev/null; then
		i3-merge-config -f
		if pidof i3 >/dev/null; then
			# i3 is running
			if [[ -v I3SOCK && -S "$I3SOCK" ]]; then
				i3-msg reload >/dev/null
			fi
		fi
	fi
)
