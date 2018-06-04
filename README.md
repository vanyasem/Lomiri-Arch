# Unity8 for Arch GNU/Linux project

## About
This project aims to bring [Unity8](https://github.com/ubports/unity8-build) DE to Arch GNU/Linux.

It is built for `x86_64`, `i686`, `armv7h`, and `aarch64`. ARM builds are experimental.

### Progress
_Clickable icons:_

- 🌍 - Available in the repository
- ✅ - Available in the AUR
- 😜 - Git version is available in the AUR
- ⛔️ - Unresolved issues
- 🆗 - Resolved issues

**Mir packages:**
- [x] `lcov` submodule
- [x] `gcovr` submodule
- [x] `python-dbusmock` [🌍](https://github.com/vanyasem/Unity8-Arch/tree/master/python-dbusmock) [✅](https://aur.archlinux.org/packages/python-dbusmock/) [😜](https://aur.archlinux.org/packages/mir-git)
- [x] `mir` [🌍](https://github.com/vanyasem/Unity8-Arch/tree/master/mir) [😜](https://aur.archlinux.org/packages/mir-git) | [🆗](https://github.com/MirServer/mir/commit/e6ba0de363320feab9359821c96d69ff61a7f121)

**Unity8 packages:**
- [x] `cmake-extras` [🌍](https://github.com/vanyasem/Unity8-Arch/tree/master/cmake-extras-git) | [⛔️](https://github.com/ubports/cmake-extras/issues/2)
- [x] `libqtdbustest` [🌍](https://github.com/vanyasem/Unity8-Arch/tree/master/libqtdbustest-git) | [⛔️](https://github.com/ubports/libqtdbustest/issues/1)
- [x] `dbus-test-runner` [🌍](https://github.com/vanyasem/Unity8-Arch/tree/master/dbus-test-runner) | [⛔️](https://aur.archlinux.org/pkgbase/dbus-test-runner/flag-comment/)
- [x] `unity-api`[🌍](https://github.com/vanyasem/Unity8-Arch/tree/master/unity-api-git) | [⛔️](https://github.com/ubports/unity-api/issues/2)
- [x] `libertine` [🌍](https://github.com/vanyasem/Unity8-Arch/tree/master/libertine-git) | [⛔️](https://github.com/ubports/libertine/issues/3)
- [ ] `ubuntu-download-manager` [⛔️](https://github.com/ubports/ubuntu-download-manager/issues/2) [⛔️](https://github.com/ubports/ubuntu-download-manager/issues/3) [🆗](https://github.com/ubports/ubuntu-download-manager/issues/4) [⛔️](https://github.com/ubports/ubuntu-download-manager/issues/6)
- [ ] `url-dispatcher`
- [ ] `thumbnailer`
- [ ] `settings-components`
- [ ] `history-service`
- [ ] `ubuntu-ui-toolkit`
- [ ] `ubuntu-app-launch`
- [ ] `content-hub`
- [ ] `qtmir`
- [ ] `trust-store`
- [ ] `location-service`
- [ ] `platform-api`
- [ ] `qtubuntu`
- [ ] `libusermetrics`
- [ ] `keyboard-component`
- [ ] `system-settings`
- [ ] `unity8`
- [ ] Probably more

**Halium packages (`armv7h`, `aarch64`):**
- [x] `hybris-usb` submodule [⛔️](https://aur.archlinux.org/pkgbase/hybris-usb/?comments=all)
- [ ] `android-headers` submodule
- [ ] `libhybris-git` submodule
- [ ] `lxc-android` submodule

## Install Unity8 (not implemented, boilerplate text)
### Option 1:
You can install precompiled packages from my personal repository.

Add the repository to /etc/pacman.conf:
```
[unity8]
SigLevel = Required
Server = https://unity8.mynameisivan.ru/$repo/os/$arch
```

Trust my GPG key:
```
sudo pacman-key --recv-keys --keyserver hkps://hkps.pool.sks-keyservers.net F3A621DFD4328CC4
sudo pacman-key --lsign-key F3A621DFD4328CC4
```

Refresh the local pacman database:
```
sudo pacman -Syyu
```

Install Unity8 packages:
```
sudo pacman -S !!!TBD!!!
```

### Option 2:
You can compile the packages yourself from the AUR.

You can either do it manually for each dependency:

_There is a helper script (`build-packages.sh`) in the root of this repository that will build all packages for you._
```
PACKAGE = !!!TBD!!!
git clone https://aur.archlinux.org/$PACKAGE.git
cd $PACKAGE
makepkg -sic
```

Or use an AUR helper of your choice:
```
pacaur -S !!!TBD!!!
```

## (Advanced) Configure a local repository / build the packages

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

_If your decided to use your local repo, you have to build packages in this specific order, as some packages depend on each other_

Run `rebuild-repo.sh` from the PKGBUILDs directory. Make sure to configure sudo timeout for your build user, as it defaults to 5 minutes.
