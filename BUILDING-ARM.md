## (Advanced) Configure a local repository / build the packages

The following instructions assume that you're building ARM packages on a `x86_64` host.

You might want to take a look at [building `x86_64` packgages on `x86_64`](README.md), and [building `i686` packgages on `x86_64`](BUILDING-I686.md).

Add the package repository to `/etc/pacman.conf`:

_You can add my repository, or you could specify your own local repo that you will create in the next step. Read more [on the wiki](https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Custom_local_repository). You have to trust my GPG key on the host system prior to building the chroot if you decide to go with my server._

```
[unity8]
SigLevel = Required
Server = https://unity8.mynameisivan.ru/$repo/os/$arch
```
_or_
```
[unity8]
SigLevel = Required
Server = file:///your/path/$repo/os/$arch
```

Assemble the build enviroment:

_Don't forget to configure PACKAGER in /etc/makepkg.conf_

_The following commands use `aarch64` as an architecture. If you want to build packages for `armv7`, just replace `aarch64` with `armv7h`, and use `/usr/bin/qemu-arm-static` as a QEMU interpreter.

_Install `qemu-user-static` from AUR. Follow the same steps as you would for `i686`, but use the values from the [ArchLinuxArm project.](http://mirror.archlinuxarm.org/os/ArchLinuxARM-aarch64-latest.tar.gz). You will also need to edit `/usr/bin/makechrootpkg` to pass `-s` to every `arch-nspawn` call. Hack-ish, but it does the trick.
```
sudo pacman -S devtools
mkdir chroot-aarch64
sudo mkdir -p /var/cache/pacman-aarch64/pkg/
sudo mkarchroot -f /usr/bin/qemu-aarch64-static -C /etc/pacman.conf.aarch64 -M /etc/makepkg.conf.aarch64 -c /var/cache/pacman-aarch64/pkg/ ./chroot-aarch64/root base base-devel git
mkdir -p unity8 sources logs PKGBUILDs
```

_Your Arch repository will settle in the `unity8` folder._

Clone this repo's PKGBUILDs:
```
cd PKGBUILDs
git clone https://github.com/vanyasem/Unity8-Arch.git ./
git submodule init
git submodule update
cd ..
```

Sync the databases:
```
sudo arch-chroot chroot-aarch64/root
pacman -Syyu
pacman -S python python2 python-setuptools python2-setuptools # Those are needed // TODO IVAN MAYBE MAKE METAPACKAGE WITH CI DEPS?
exit
```

Build Arch repository manager ([guzuta](https://github.com/eagletmt/guzuta)):

_Latest released `guzuta` is missing ARM support, so you will need to manually compile it from upstream git repository._

```
git clone https://github.com/eagletmt/guzuta.git
cd guzuta
cargo build
cargo install --force
```

Configure guzuta:
```
cat > .guzuta.yml
name: unity8
package_key: YOUR_GPG_KEY
repo_key: YOUR_GPG_KEY
srcdest: sources
logdest: logs
pkgbuild: PKGBUILDs
builds:
  aarch64:
    chroot: ./chroot-aarch64
```

Build the packages:

Run `rebuild-repo.sh` from the PKGBUILDs directory. Make sure to configure sudo timeout for your build user, as it defaults to 5 minutes.
