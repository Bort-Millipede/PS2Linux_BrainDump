# Installing Software on PS2 Linux

In order to install new software (such as shared libraries or newer Linux kernel versions) on PS2 Linux, these must first be built from source code. This can be accomplished one of the following ways:  
* [Cross-Compile](https://en.wikipedia.org/wiki/Cross_compiler) software on another system and then install onto PS2 Linux afterwards.
* Compile and install directly on PS2 Linux itself using included tools (such as gcc and g++).
* Install prebuilt binaries from the defunct playstation2-linux.com community

### Advantages/Disadvantages of cross-compiling software

* Advantage: Building software takes significantly less time
* Disadvantage: Properly configuring software for cross-compiling can be complex, and in some cases is not even possible.

### Advantages/Disadvantages of building/installing directly on PS2 Linux:

* Advantage: Configuring source code for building is simple and straightforward.
* Disadvantage: Building large codebases (such as the Linux Kernel or Mozilla Firefox) takes a LONG time.

### Prebuilt PS2 Linux Binaries

On top of those included in the Linux kits, some prebuilt software packages for PS2 Linux do exist from the playstation2-linux.com community (closed in 2009). Many of these can be found on the backup site, [hosted here](http://ps2linux.no-ip.info/playstation2-linux.com/), under "Projects"
* Advantage: Software is already built and ready to install
* Disadvantage: Software may not be configured in the way that is desired by the current user (some features may be enabled, others disabled)

## [Setting Up Cross-Compiling Environment](Toolchain)

The section describes and references setting up a dedicated system for cross-compiling software to be installed and run on PS2 Linux.

## General Tips & Tricks

* In keeping with generally-accepted [Linux directory conventions](https://www.linuxfromscratch.org/blfs/view/stable/introduction/position.html), it is recommended that any software compiled (either cross-compiled or natively-compiled) and installed on PS2 Linux be installed to the ```/usr/local``` directory and NOT to the ```/usr``` directory. Therefore, when configuring software for compiling via the included ```configure``` script, the ```--prefix=/usr/local``` command-line option should be passed.
* Because of the above point, the ```/usr/local/lib``` directory needs to be added to the ```/etc/ld.so.conf``` file on PS2 Linux. This will ensure that all shared libraries installed to ```/usr/local/lib``` are properly linked and cached via the ```ldconfig``` command.

## Cross-Compiling Tips & Tricks

* Shared libraries that have been cross-compiled and are intended to be linked to future software being cross-compiled will need to be installed to the cross-compiling environment as well as to PS2 Linux. This usually requires building/installing the software twice: once for the cross-compiling environment and once for PS2 Linux.
  * This is clearly outlined in specific package build instructions below where building/installing twice is required.
* Common options passed to included ```configure``` scripts to configure software for cross-compiling:
  * ```--host=mipsEEel-linux```: configure software to be cross-compiled for PS2 Linux (MIPS Endian little system with an Emotion Engine processor). This host value is not included by default, but can be trivially added to the necessary ```config.sub``` file(s) via sed/perl commands (included in most specific package tutorials linked below).
  * ```--prefix=/usr/mipsEEel-linux/mipsEEel-linux/usr```: For installing software to the cross-compiling environment.
  * ```--prefix=/usr/local```: For installing software directly to PS2 Linux.
* In cases where passing the ```--host=mipsEEel-linux``` option is insufficient to fully configure the software for cross-compiling (example: SDL/SDL_net), the individual compilation components (```mipsEEel-linux-gcc``` and ```mipsEEel-linux-ld```, for example) should be specified via environment variables before executing the ```configure``` scripts.
* To cross-compile software against a specific kernel version, recreate the ```/usr/mipsEEel-linux/mipsEEel-linux/usr/src/linux``` symbolic link to reference the kernel source directory for the desired version. The ```/usr/mipsEEel-linux/mipsEEel-linux/usr/src/linux``` link is set to 2.2.1_ps2-7 by default.
* Some software, sadly, refuses to be cross-compiled (examples are Mozilla Firefox specifically configured with SSL/TLS support, or the XMMS media player). This, unfortuately, can only be evaluated on a case-by-case basis.

## Building Specific Packages

**NOTE:** To avoid any possible headaches conforming to specific license agreements and/or dealing with conflicting licensing agreements, prebuilt binaries for those listed below will not be distributed. Thankfully the documentation SHOULD be detailed enough to allow readers to build their own binaries.

* [FreeType 2.1.2](Packages/FreeType)
* [Libtool 1.4.2](Packages/Libtool)
* [mpg123 0.66](Packages/mpg123)
* [Netcat 1.10](Packages/Netcat)
* [pkg-config 0.12.0](Packages/pkg-config)
* [Popt 1.7](Packages/Popt)
* [pv (pipe viewer) 0.6.4](Packages/pv)
* [SDL/SDL_net](Packages/SDL)




