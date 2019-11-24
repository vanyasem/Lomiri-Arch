Unity8 for Arch GNU/Linux
=========================

This project aims to bring [Unity8](https://github.com/ubports/unity8-build) DE to Arch GNU/Linux.

Builds are provided for `x86_64`.

`i686`, `armv7h`, and `aarch64` builds are planned.

## Resources

- [Packaging status](STATUS.md)
- [Telegram News Channel](https://t.me/unity8_port_notes)
- [Project's Patreon](https://www.patreon.com/vanyasem)

## Installation

Add the Unity8 repository to `/etc/pacman.conf`:
```
[unity8]
SigLevel = Required TrustAll
Server = https://unity8.mynameisivan.ru/$repo/os/$arch
```

Refresh the local pacman database:
```
sudo pacman -Syyu
```

If previous command failed to import my GPG key, do it manually:
```
sudo pacman-key --recv-keys --keyserver hkps://hkps.pool.sks-keyservers.net F3A621DFD4328CC4
sudo pacman-key --lsign-key F3A621DFD4328CC4
sudo pacman -Syyu
```

Install Unity8 and some important packages _(TODO: metapackage)_:
```
sudo pacman -S unity8-git qt5-wayland qterminal qtmir-git
```

Skip the greeter (not used on desktops, broken):
```
mkdir -p $HOME/.config/ubuntu-system-settings
touch $HOME/.config/ubuntu-system-settings/wizard-has-run
```

Launch Unity8 with (either from a tty or from a terminal):
```
QT_WAYLAND_DISABLE_WINDOWDECORATION=true MIR_SERVER_CURSOR=null QT_QPA_PLATFORM=mirserver unity8
```

It should not work on nvidia proprietary, it's a limitation of Mir.

As it's an alpha build, it takes around 5-10 minutes to start (please be patient).

## Building

Building instructions were moved to [a separate document](BUILDING.md).

## Contributing

Please follow the [contributing guide](CONTRIBUTING.md).

## License

Copyright (C) 2018-2019 Ivan Semkin

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
