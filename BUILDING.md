Building
========

You can build the packages on [Windows via WSL](https://github.com/yuk7/ArchWSL) if you wish.

Trust a few GPG keys:
```
gpg --recv-keys E932D120BC2AEC444E558F0106CA9F5D1DCF2659 # ofono
gpg --recv-keys 4DE16D68FDBFFFB8 # systemtap
```

Clone this repo's PKGBUILDs:
```
git clone https://github.com/vanyasem/Lomiri-Arch.git
cd Lomiri-Arch
git submodule init
git submodule update
```

You can [compile the packages](https://wiki.archlinux.org/index.php/Makepkg#Usage) yourself by running `makepkg -sic` in their folders.

There is a helper script (`build-packages.sh`) in the root of this repository that will build all the packages for you in the right order (some packages are required to build other packages, and they are not in official Arch repos yet).

```
./build-packages.sh -b
```

## (Advanced) Configure a [local repository](https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Custom_local_repository)

The following instructions assume that you're building `x86_64` packages on a `x86_64` host.

You might want to take a look at [building ARM packgages on `x86_64`](BUILDING-ARM.md), and [building `i686` packgages on `x86_64`](BUILDING-I686.md).

First of all, trust a few GPG keys mentioned above in the Building section of this document.

Add the package repository to `/etc/pacman.conf`:

_Comment it out for now, as it doesn't exist yet:_
```
#[lomiri]
#SigLevel = Required
#Server = http://localhost:8000/$repo/os/$arch
```

Assemble the build enviroment:

_Don't forget to configure `PACKAGER` in `/etc/makepkg.conf`_

```
sudo pacman -S devtools
mkdir -p chroot-x86_64 cache/pacman-x86_64/pkg lomiri sources logs PKGBUILDs
sudo mkarchroot -C /etc/pacman.conf -M /etc/makepkg.conf -c $(pwd)/cache/pacman-x86_64/pkg/ ./chroot-x86_64/root base base-devel nano
```

_Your Arch repository will settle in the `lomiri` folder. This is the only folder that needs to be exposed to the public if you decide to host your repo._

Clone this repo's PKGBUILDs:
```
cd PKGBUILDs
git clone https://github.com/vanyasem/Lomiri-Arch.git ./
git submodule init
git submodule update
cd ..
```

Install Arch repository manager ([guzuta](https://github.com/eagletmt/guzuta)):
```
sudo pacman -S cargo
cargo install guzuta
```

Configure guzuta:
```
echo "
name: lomiri
package_key: YOUR_GPG_KEY
repo_key: YOUR_GPG_KEY
srcdest: sources
logdest: logs
pkgbuild: PKGBUILDs
builds:
  x86_64:
    chroot: ./chroot-x86_64
" > .guzuta.yml
```

Set up a webserver (any will do):

_This is required due to the fact you cannot use local paths from inside the chroot. You don't need to expose it to the public._
```
python -m http.server 8000`
```

Uncomment the repo from inside the chroot:
```
arch-nspawn ./chroot-x86_64/root nano /etc/pacman.conf
```

Sync the databases inside the chroot:
```
arch-nspawn ./chroot-x86_64/root pacman -Syyu
```

Build the packages:

_Make sure to configure sudo timeout for your build user, as it defaults to 5 minutes._
```
cd PKGBUILDs
./rebuild-repo.sh
```
