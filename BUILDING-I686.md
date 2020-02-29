# The following file is severely outdated and not officially supported as of now. Follow the project updates to be the first one to know when it gets implemeneted.

## (Advanced) Configure a local repository / build the packages

The following instructions assume that you're building `i686` packages on a `x86_64` host.

You might want to take a look at [building ARM packgages on `x86_64`](BUILDING-ARM.md), and [building `x86_64` packgages on `x86_64`](README.md).

Add the package repository to `/etc/pacman.conf`:

_You can add my repository, or you could specify your own local repo that you will create in the next step. Read more [on the wiki](https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Custom_local_repository). You have to trust my GPG key on the host system prior to building the chroot if you decide to go with my server._

```
[lomiri]
SigLevel = Required
Server = https://lomiri.mynameisivan.ru/$repo/os/$arch
```
_or_
```
[lomiri]
SigLevel = Required
Server = file:///your/path/$repo/os/$arch
```

Assemble the build enviroment:

_Don't forget to configure PACKAGER in /etc/makepkg.conf_

_If you want to cross-compile packages for `i686`, then follow the guide [on the wiki](https://wiki.archlinux.org/index.php/Building_32-bit_packages_on_a_64-bit_system). But as Arch doesn't officially support i686 now, use the [mirrorlist](https://raw.githubusercontent.com/archlinux32/packages/master/core/pacman-mirrorlist/mirrorlist) of the ArchLinux32 project. You will also need to trust 2 GPG keys: `255A76DB9A12601A` and `C8E8F5A0AF9BA7E7` prior to the chroot creation same way as desribed above with my key._

```
sudo pacman -S devtools
mkdir chroot-i686
sudo mkdir -p /var/cache/pacman-i686/pkg/
sudo mkarchroot -C /etc/pacman.conf.i686 -M /etc/makepkg.conf.i686 -c /var/cache/pacman-i686/pkg/ ./chroot-i686/root base base-devel git
mkdir -p lomiri sources logs PKGBUILDs
```

_Your Arch repository will settle in the `lomiri` folder._

Clone this repo's PKGBUILDs:
```
cd PKGBUILDs
git clone https://github.com/vanyasem/Lomiri-Arch.git ./
git submodule init
git submodule update
cd ..
```

Sync the databases:
```
sudo arch-chroot chroot-i686/root
pacman -Syyu
pacman -S python python2 python-setuptools python2-setuptools # Those are needed // TODO IVAN MAYBE MAKE METAPACKAGE WITH CI DEPS?
exit
```

Install Arch repository manager ([guzuta](https://github.com/eagletmt/guzuta)):
```
sudo pacman -S cargo
cargo install guzuta
```

Configure guzuta:
```
cat > .guzuta.yml
name: lomiri
package_key: YOUR_GPG_KEY
repo_key: YOUR_GPG_KEY
srcdest: sources
logdest: logs
pkgbuild: PKGBUILDs
builds:
  i686:
    chroot: ./chroot-i686
```

Build the packages:

Run `rebuild-repo.sh` from the PKGBUILDs directory. Make sure to configure sudo timeout for your build user, as it defaults to 5 minutes.
 
