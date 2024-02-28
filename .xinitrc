#!/usr/bin/env bash

# Source system init scripts
if [[ -d /etc/X11/xinit/xinitrc.d ]]; then
	for f in /etc/X11/xinit/xinitrc.d/?*; do
		[[ -x "$f" ]] && source "$f"
	done
	unset f
fi

# Load .Xresources
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Load Base16 theme
DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}"
if [[ -n "${BASE16_THEME}" ]]; then
	THEME_FILE="${DATA_DIR}/base16-xresources/xresources/base16-${BASE16_THEME}-256.Xresources"
	[[ -r "${THEME_FILE}" ]] && xrdb -merge "$THEME_FILE"
fi

# Generate the i3 configuration file
i3-merge-config

exec i3
