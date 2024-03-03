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
THEMES_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/tinted-theming/base16-xresources/xresources"
if [[ -n "${BASE16_THEME}" ]]; then
	THEME_FILE="${THEMES_DIR}/base16-${BASE16_THEME}-256.Xresources"
	[[ -r "${THEME_FILE}" ]] && xrdb -merge "$THEME_FILE"
fi

# Set X screen saver arguments
# s noblank - do not blank screen when triggering screen saver
# s 300 - trigger screen saver after 5 minutes
# dpms 1200 1800 3600 - Monitor control timeouts (standby, suspend, off)
xset s noblank s 300 dpms 1200 1800 3600

# Generate the i3 configuration file
i3-merge-config >/dev/null

exec i3 -d all > /home/jdubz/i3.log
