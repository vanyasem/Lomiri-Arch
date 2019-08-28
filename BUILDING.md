Building
========

Clone this repo's PKGBUILDs:
```
git clone https://github.com/vanyasem/Unity8-Arch.git
cd Unity8-Arch
git submodule init
git submodule update
```

You can compile the packages yourself. Dependencies: `sudo pacman -S git binutils patch make`

There is a helper script (`build-packages.sh`) in the root of this repository that will build all the packages for you in the right order (some packages are required to build other packages, and you cannot satisfy this dependency, as it's not in Arch repos yet).

```
./build-packages.sh -b
```

You will also need to trust a few GPG keys:
```
gpg --recv-keys 3ECDCBA5FB34D254961CC53F6689E64E3D3664BB # For apparmor
gpg --recv-keys E932D120BC2AEC444E558F0106CA9F5D1DCF2659 # For ofono
```

## (Advanced) Configure a local repository

The following instructions assume that you're building `x86_64` packages on a `x86_64` host.

You might want to take a look at [building ARM packgages on `x86_64`](BUILDING-ARM.md), and [building `i686` packgages on `x86_64`](BUILDING-I686.md).

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

```
sudo pacman -S devtools
mkdir chroot-x86_64
sudo mkdir -p /var/cache/pacman-x86_64/pkg/
sudo mkarchroot -C /etc/pacman.conf -M /etc/makepkg.conf -c /var/cache/pacman-x86_64/pkg/ ./chroot-x86_64/root base base-devel git
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
sudo arch-chroot chroot-x86_64/root
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
name: unity8
package_key: YOUR_GPG_KEY
repo_key: YOUR_GPG_KEY
srcdest: sources
logdest: logs
pkgbuild: PKGBUILDs
builds:
  x86_64:
    chroot: ./chroot-x86_64
```

Build the packages:

Run `rebuild-repo.sh` from the PKGBUILDs directory. Make sure to configure sudo timeout for your build user, as it defaults to 5 minutes.
