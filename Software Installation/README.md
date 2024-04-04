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

## Contents
* [Setting Up Cross-Compiling Environment](Toolchain)
* Building Specific Packages
  * [a](Packages/a)

