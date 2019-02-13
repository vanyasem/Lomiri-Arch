Contributing
============

First of all, let me thank you for your interest in **Unity8-Arch**!

**Special thanks to:**
- [Abhishek](https://www.patreon.com/abhishekzz) for the idea of the project
- [Rodney (aka dobey)](https://www.patreon.com/dobey/) for guiding me when I felt lost
- Marius and Florian from the UBports Dev Team for merging my PRs and motivating me
- William Wold for patching Mir for Arch
- [Alex](https://www.patreon.com/WarumLinuxBesserIst) for former financial support on Patreon ($40 total). He has a German YouTube channel about Linux: [WarumLinuxBesserIst](https://youtube.com/user/WarumLinuxBesserIst), and a recently created English YouTube channel: [eDrive](https://goo.gl/UFVh4S)
- [Jeroen Bots](https://www.patreon.com/user?u=251509) for financial support on Patreon ($150 total)

As the project is in it's alpha stage, your contribution is very important.

### Packaging
You can help us by packaging the components of Unity8.

Start off by reading the [AUR](https://wiki.archlinux.org/index.php/Aur) wiki page. Make yourself familiar with [PKGBUILDs](https://wiki.archlinux.org/index.php/PKGBUILD).

All packages are listed in the [STATUS](STATUS.md) of this repository. They split into 2 categories: `cmake` and `qmake` ones.

Try to build it, make a PKGBUILD for it. Even if it fails to build, PR the PKGBUILD here, and open an issue on the upstream repository. Don't forget to include that issue in your PR.

### Testing

You can install Unity8 on your system, and help by testing individual packages.

If something doesn't feel right, open an issue both upstream and in this repository.

### Patching

If you have some coding knowledge, you can take a look at the issues list in the [STATUS](STATUS.md).

Try to fix as many things as possible. PR a patch upstream, and PR a patch in this repository. A packager will include your patch at compile time until the upstream PR is merged.
