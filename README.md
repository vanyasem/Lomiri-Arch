Lomiri for Arch
===============

This project aims to bring [Lomiri](https://unity8.io/) (former Unity8) DE to Arch GNU/Linux.

Builds are provided for `x86_64`.

`i686`, `armv7h`, and `aarch64` builds are planned.

## Resources

- [Packaging status](STATUS.md)
- [Telegram News Channel](https://t.me/Unity8_Arch)
- [Project's Patreon](https://www.patreon.com/vanyasem)

## Live USB image

**You can grab a pre-made iso image from https://lomiri.mynameisivan.ru/iso/**

Flash it to any usb flashdrive (>= 2 Gb) (you can use [Etcher](https://www.balena.io/etcher/) for that)

Boot from it. You should see a tty with a shell. Don't worry, that's expected.

You can connect to the internet via networkmanager cli gui by running `nmtui` if you wish.

Run `./unity8.sh` to launch Lomiri.

As it's an alpha build, it takes around 5-10 minutes to start (you should see an empty black screen with no splashscreen, please be patient).

The default user is `unity8` with no password. My custom repository is already included.

It's expected to crash a lot, it's purpose is to showcase progress of Lomiri on Arch.

## Installing

Add the Lomiri repository to `/etc/pacman.conf`:
```
[lomiri]
SigLevel = Required TrustAll
Server = https://lomiri.mynameisivan.ru/$repo/os/$arch
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

Install Lomiri and some important packages _(TODO: metapackage)_:
```
sudo pacman -S unity8-git qt5-wayland qterminal qtmir-git
```

Skip the greeter (not used on desktops, broken):
```
mkdir -p $HOME/.config/ubuntu-system-settings
touch $HOME/.config/ubuntu-system-settings/wizard-has-run
```

Launch Lomiri with (either from a tty or from a terminal):
```
QT_WAYLAND_DISABLE_WINDOWDECORATION=true MIR_SERVER_CURSOR=null QT_QPA_PLATFORM=mirserver unity8
```

It should not work on nvidia proprietary, it's a limitation of Mir.

As it's an alpha build, it takes around 5-10 minutes to start (you should see an empty black screen with no splashscreen, please be patient).

## Building

Building instructions were moved to [a separate document](BUILDING.md).

## Contributing

Please follow the [contributing guide](CONTRIBUTING.md).

## License

Copyright (C) 2018-2020 Ivan Semkin

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program. If not, see <https://www.gnu.org/licenses/>.
