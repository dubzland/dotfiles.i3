# i3/X11 configuration

This includes general configuration for X11 apps (including .Xresources and
xterm), as well as configuration for `i3` itself and `i3status`.

## Prerequisites

- i3 & i3status
- xterm
- rofi
- pianobar
- dunst (for notifications)
- dex (for desktop autostart)
- feh (for wallpaper)
- parcellite (for clipboard history)
- barrier (for KVM support)
- nextcloud-client (duh)

## Setup

```bash
# Set font sizes in .Xresources
cp $HOME/.Xresources.d/font-sizes.example $HOME/.Xresources.d/font-sizes

# Link autostarts
ln -sf /usr/share/applications/barrier.desktop $HOME/.config/autostart/
ln -sf /usr/share/applications/com.nextcloud.desktopclient.nextcloud.desktop $HOME/.config/autostart/
ln -sf /usr/share/applications/xscreensaver.desktop $HOME/.config/autostart/
```
