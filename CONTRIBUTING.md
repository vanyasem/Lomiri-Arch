Contributing
============

First of all, let me thank you for your interest in **Lomiri-Arch**!

**Special thanks to:**
- [Abhishek](https://www.patreon.com/abhishekzz) for the idea of the project
- [Rodney (aka dobey)](https://www.patreon.com/dobey/) for guiding me when I felt lost
- Marius and Florian from the UBports Dev Team for merging my PRs and motivating me
- William Wold for helping with Mir and for the financial support on Patreon ($80 total)
- [Alex](https://www.patreon.com/WarumLinuxBesserIst) for former financial support on Patreon ($40 total). He has a German YouTube channel about Linux: [WarumLinuxBesserIst](https://youtube.com/user/WarumLinuxBesserIst), and a recently created English YouTube channel: [eDrive](https://goo.gl/UFVh4S)
- [Jeroen Bots](https://www.patreon.com/user?u=251509) for financial support on Patreon ($1050 total)
- [z3ntu](https://github.com/z3ntu) for helping with updating and patching packages

As the project is in it's alpha stage, your contribution is very important.

### Packaging
You can help us by packaging the components of Lomiri.

Start off by reading the [AUR](https://wiki.archlinux.org/index.php/Aur) wiki page. Make yourself familiar with [PKGBUILDs](https://wiki.archlinux.org/index.php/PKGBUILD).

All packages are listed in the [STATUS](STATUS.md) of this repository. They split into 2 categories: `cmake` and `qmake` ones.

Try to build one of them, make a PKGBUILD for it. Even if it fails to build, PR the PKGBUILD here. Open an issue on the upstream repository if you think it's a bug. Don't forget to include the link to that issue in your PR.

### Testing

You can install Lomiri on your system, and help by testing individual packages.

If something doesn't feel right, open an issue both upstream and in this repository.

### Patching

If you have some coding knowledge, you can take a look at the issues list in the [STATUS](STATUS.md). There are also some undocumented issues to look for in [BROKEN.txt](BROKEN.txt).

Try to fix as many things as possible. PR a patch upstream, and PR a patch in this repository. A packager will include your patch at compile time until the upstream PR is merged.
