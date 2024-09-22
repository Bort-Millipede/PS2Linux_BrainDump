# PS2 Linux Brain Dump

A compilation of info, notes, and scripts put together during recent stints tinkering with the official (Beta and Release) Playstation 2 Linux Kit and Playstation Broadband Navigator (PSBBN).

## Disclaimer

The author assumes that the reader has a baseline knowledge of Linux usage in general. This is not intended to be an all-inconclusive document, but the utmost effort has been made to provide as much information as possible. The author makes no promises that all required information is contained within.

Additionally, the author provides all information for free without warranty, and assumes no responsibility for any damage caused to any systems by leveraging the information. It is the responsibility of the reader to abide by all local, state and federal laws while digesting and using the information.

Digest and use this at your own risk!!!

## Table of Contents

* [Installing Software on PS2 Linux](Software&#32;Installation)
  * [Setting Up Cross-Compiling Environment](Software&#32;Installation/Toolchain)
  * Specific Software Packages:
    * [Abuse](Software&#32;Installation/Packages/Abuse)
    * [Autoconf 2.53](Software&#32;Installation/Packages/Autoconf)
    * [Automake 1.5/1.6.3](Software&#32;Installation/Packages/Automake)
    * [cdrtools 1.10/2.0/2.01.01a36](Software&#32;Installation/Packages/cdrtools)
    * [Firefox 0.8](Software&#32;Installation/Packages/Firefox)
    * [FreeType 2.1.2](Software&#32;Installation/Packages/FreeType)
    * [GCC 2.95.2](Software&#32;Installation/Packages/GCC)
    * [libgcj 2.95.1](Software&#32;Installation/Packages/libgcj)
    * [Libtool 1.4.2](Software&#32;Installation/Packages/Libtool)
    * [Maelstrom 3.0.6](Software&#32;Installation/Packages/Maelstrom)
    * [mpg123 0.66](Software&#32;Installation/Packages/mpg123)
    * [Netcat 1.10](Software&#32;Installation/Packages/Netcat)
    * [pkg-config 0.12.0](Software&#32;Installation/Packages/pkg-config)
    * [Popt 1.7](Software&#32;Installation/Packages/Popt)
    * [ps2fs](Software&#32;Installation/Packages/ps2fs)
    * [pv (pipe viewer) 0.6.4](Software&#32;Installation/Packages/pv)
    * [Quake](Software&#32;Installation/Packages/Quake)
    * [Reiserfsprogs 3.x.0j](Software&#32;Installation/Packages/Reiserfsprogs)
    * [SDL 1.2.5/SDL_net 1.2.2](Software&#32;Installation/Packages/SDL)
    * [smake (schily-make) 1.2](Software&#32;Installation/Packages/smake)
    * [star (schily-tar) 1.4.3](Software&#32;Installation/Packages/star)
    * [Stella 1.2](Software&#32;Installation/Packages/Stella)
    * [VLC 0.7.2](Software&#32;Installation/Packages/VLC)
      * [a52dec 0.7.4](Software&#32;Installation/Packages/VLC/Dependencies/a52dec)
      * [FAAD2 2.0](Software&#32;Installation/Packages/VLC/Dependencies/FAAD2)
      * [FFmpeg 20040520](Software&#32;Installation/Packages/VLC/Dependencies/FFmpeg)
      * [LAME 3.96](Software&#32;Installation/Packages/VLC/Dependencies/LAME)
      * [libcdio 0.71](Software&#32;Installation/Packages/VLC/Dependencies/libcdio)
      * [libdvbpsi3 0.1.4](Software&#32;Installation/Packages/VLC/Dependencies/libdvbpsi3)
      * [libdvdcss 1.2.8](Software&#32;Installation/Packages/VLC/Dependencies/libdvdcss)
      * [libdvdnav 0.1.10](Software&#32;Installation/Packages/VLC/Dependencies/libdvdnav)
      * [libdvdplay 1.0.1](Software&#32;Installation/Packages/VLC/Dependencies/libdvdplay)
      * [libdvdread (20030812)](Software&#32;Installation/Packages/VLC/Dependencies/libdvdread)
      * [libMAD 0.15.1b](Software&#32;Installation/Packages/VLC/Dependencies/libMAD)
      * [libxml2 2.6.4](Software&#32;Installation/Packages/VLC/Dependencies/libxml2)
      * [LIVE555 (2004.04.23)](Software&#32;Installation/Packages/VLC/Dependencies/LIVE555)
      * [mpeg2dec 0.4.0](Software&#32;Installation/Packages/VLC/Dependencies/mpeg2dec)
      * [vcdimager 0.7.21](Software&#32;Installation/Packages/VLC/Dependencies/vcdimager)
    * [wxWindows 2.5.1 (20031222)](Software&#32;Installation/Packages/wxWindows)
  * [Linux Kernels](Software&#32;Installation/Kernels):
    * [2.2.1_ps2-6](Software&#32;Installation/Kernels/2.2.1_ps2-6) (for PS2 Linux Beta Release 1)
    * [2.2.1_ps2-7](Software&#32;Installation/Kernels/2.2.1_ps2-7) (for PS2 Linux Release 1.0)
    * [2.2.19_ps2-5](Software&#32;Installation/Kernels/2.2.19_ps2-5) (for PS2 Linux Beta Release 1 and PS2 Linux Release 1.0)
    * [2.4.17_ps2-22](Software&#32;Installation/Kernels/2.4.17_ps2-22) (for PS2 Linux Beta Release 1)
    * [2.4.17_ps2-26](Software&#32;Installation/Kernels/2.4.17_ps2-26) (for PS2 Linux Release 1.0)
* [USB Devices](USB&#32;Devices)
  * [Floppy and Zip Drives](USB&#32;Devices/Floppy-Zip&#32;Drives)
  * [Flash Drives](USB&#32;Devices/Flash&#32;Drives)
  * [Optical Drives](USB&#32;Devices/Optical&#32;Drives)
  * [Dial-Up Modems](USB&#32;Devices/Modems)
* [Scripts](Scripts)
  * [kernel-switch](Scripts/kernel-switch)
  * [load-usb-modules](Scripts/load-usb-modules)
* [Tips and Tricks for PS2 Linux](Tips&#32;and&#32;Tricks)
  * [Soft-Rebooting PS2 Linux with AKMem](Tips&#32;and&#32;Tricks/AKMem)
  * [Backing Up and Restoring PS2 Linux](Tips&#32;and&#32;Tricks/Backup-Restore)
  * [PC-DC Server for Sega Dreamcast](Tips&#32;and&#32;Tricks/PC-DC&#32;Server)
* [PS2 Linux Kit Comparison (Beta Release 1 and Release 1.0)](Kit&#32;Comparisons)
  * [Full Installed Packages Comparison](Kit&#32;Comparisons/Installed&#32;Packages)
* [Playstation Broadband Navigator](Broadband&#32;Navigator)
  * [Full Installed Packages Comparison](Broadband&#32;Navigator/Installed&#32;Packages)

## PS2 Linux References

* [playstation2-linux.com](http://ps2linux.no-ip.info/playstation2-linux.com/) (site backup)
* [http://achurch.org/ps2/](http://achurch.org/ps2/)
* [http://www.geocities.jp/ps2linux_net/](https://web.archive.org/web/20181105024308/http://www.geocities.jp/ps2linux_net/)
* [http://hp.vector.co.jp/authors/VA008536/ps2linux/](https://web.archive.org/web/20210613000210/http://hp.vector.co.jp/authors/VA008536/ps2linux/)
* [http://www.peanuts.gr.jp/2005/03/pslinux/index.html.ja](https://web.archive.org/web/20190114054744/http://www.peanuts.gr.jp/2005/03/pslinux/index.html.ja)

## Linux References

* [https://linuxconfig.org/in-depth-howto-on-linux-kernel-configuration](https://linuxconfig.org/in-depth-howto-on-linux-kernel-configuration): Linux Kernel Configuration Tutorial

