# PlayStation Broadband Navigator (PSBBN)

Playstation Broadband Navigator (PSBBN) is a software that can be installed to the HDD on Japanese Playstation 2 consoles. PSBBN is initially installed from an official Sony-issued disc, but launches automatically on the console without the disc after installation.

PSBBN offers a variety of features that will not be covered at length or in detail here.

Under the surface, PSBBN is actually a heavily scaled-back installation of PS2 Linux. Because of this, the author also spent recent time tinkering with PSBBN. The author specifically explored PSBBN 0.30, and also PSBBN 0.20 to a much lesser extent.

## General Information

Several versions of PSBBN were released by Sony during its lifetime. The different PSBBN versions shipped with different Linux Kernel versions installed:

* **PSBBN 0.10**: 2.2.19_ps2-5
* **PSBBN 0.20**: 2.2.19_ps2-23
* **PSBBN 0.30**: 2.4.17_ps2-22
* **PSBBN 0.31**: 2.4.17_ps2-26
* **PSBBN 0.32**: 2.4.17_ps2-26

## Installed Package Comparison

As indicated above, PSBBN is a heavily scaled-back installation of PS2 Linux. While it shares some software packages with full PS2 Linux installations, it also includes some packages that are exclusive to PSBBN.

### Differences:

For packages that are installed on both PS2 Linux Release (not Beta) and PSBBN:
* Some package versions are identical:
  * Example: ```grep-2.0_jp-5``` is installed on both PS2 Linux and PSBBN.
* For others, the package versions are almost identical (with PSBBN using packages with release numbers slightly higher than PS2 Linux):
  * Example: ```glibc-2.2.2-4``` is installed on PS2 Linux, while ```glibc-2.2.2-8``` is installed on PSBBN.

For some packages installed on both PSBBN 0.20 and 0.30, the package versions appear to be mostly identical (including build numbers).
* Example: ```samba-2.0.10_ja_1.1-1``` on both 0.20 and 0.30.

The only package that appears to be exclusive to PSBBN 0.30, but not 0.20, is ```ps2kinst-1.0-1```.

PSBBN also has some exclusive packages that are not installed on any version of PS2 Linux. Examples:
* ```postgresql-7.1.3-4```
* ```reiserfsprogs-3.x.0j-1```
* ```zzzzscescripts-1.0-1```

### [Full PSBBN Installed Package Comparison (between 0.20 and 0.30)](Installed&#32;Packages)

## Additional PSBBN Information

* PSBBN-specific Tips and Tricks:
  * [Mounting PSBBN Partitions From PS2 Linux (WIP)](Tips&#32;and&#32;Tricks/Mounting&#32;PSBBN&#32;Partitions)
  * [chrooting Into PSBBN From PS2 Linux (WIP)](Tips&#32;and&#32;Tricks/chrooting&#32;Into&#32;PSBBN)
  * [Adding System Users to PSBBN (WIP)](Tips&#32;and&#32;Tricks/Adding&#32;System&#32;Users)
  * [Installing Additional Software in PSBBN (WIP)](Tips&#32;and&#32;Tricks/Software&#32;Installation)
  * [Booting PS2 Linux From PSBBN (without PS2 Linux DVD) (WIP)](Booting&#32;PS2&#32;Linux&#32;From&#32;PSBBN)






