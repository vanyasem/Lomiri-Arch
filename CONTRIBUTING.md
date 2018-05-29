First of all, let me thank you for your interest in **Unity8-Arch**!

As the project is in it's early stage, you contribution is very important.

### Packaging
You can help us by packaging the components of Unity8.

Start off by reading the [AUR](https://wiki.archlinux.org/index.php/Aur) wiki page. Make yourself familiar with [PKGBUILDs](https://wiki.archlinux.org/index.php/PKGBUILD).

All packages are listed in the [README](https://github.com/vanyasem/Unity8-Arch#progress) of this repository. They split into 2 categories: `cmake` and `qmake` ones.

Try to build it, make a PKGBUILD for it. Even if it fails to build, PR the PKGBUILD here, and open an issue on the upstream repository. Don't forget to include that issue in your PR.

### Testing

If you know what you're doing, you can add the WIP repo to your system, and help by testing individual packages on your system.

If something breaks, open an issue both upstream and in this repository.

### Patching

If you have some coding knowledge, you can take a look at the issues list in the [README](https://github.com/vanyasem/Unity8-Arch#progress).

Try to fix as many things as possible. PR a patch upstream, and PR a patch in this repository. A packager will include your patch at compile time until the upstream PR is merged.
