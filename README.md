# i3/X11 configuration

This includes general configuration for X11 apps (including .Xresources and
xterm), as well as configuration for `i3` itself and `i3status`.

## Prerequisites

- i3 & i3blocks
- xss-lock & i3lock (for screen saver)
- xterm
- rofi
- pianobar
- dunst (for notifications)
- dex (for desktop autostart)
- feh (for wallpaper)
- [greenclip][greenclip] (for clipboard history)
- barrier (for KVM support)
- nextcloud-client (duh)

## Setup

Set the font sizes for use by X applications:

```bash
cp $HOME/.Xresources.d/font-sizes.example $HOME/.Xresources.d/font-sizes
```

Link applications to auto-start:
```bash
ln -sf /usr/share/applications/barrier.desktop $HOME/.config/autostart/
ln -sf /usr/share/applications/com.nextcloud.desktopclient.nextcloud.desktop $HOME/.config/autostart/
```

By default, wallpaper and lock screen are set via 2 symlinks in `$HOME/Documents/Backgrounds`:
```bash
ln -sf <some image file> $HOME/Documents/Backgrounds/wallpaper
ln -sf <some image file> $HOME/Documents/Backgrounds/lock
```

[greenclip]: https://github.com/erebe/greenclip
