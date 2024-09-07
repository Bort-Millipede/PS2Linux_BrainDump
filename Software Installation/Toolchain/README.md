# Setting Up Cross-Compiling Environment

This section describes and references setting up a dedicated system for cross-compiling software to be installed and run on PS2 Linux.

## Setting Up Environment

### Choosing System and Installing Operating System

It is recommended that a virtual machine be created for this. A VM with 1 CPU, 512MB RAM, and a 20GB Hard disk seems to be sufficient. The most successful operating system for this seems to be RedHat (not RHEL) 8. ISOs for this can be downloaded from [here](https://legacy.redhat.com/pub/redhat/linux/8.0/en/iso/i386/) (only discs 1-3 should be required).

When installing RedHat 8, it is recommended to install a console-based system with X installed but not Gnome or KDE. This system can then be accessed via SSH. Installing this kind of system can be accomplished by selecting ```Custom``` as the installation type. Packages from the following categories will likely be selected:
* Development Tools
* Dialup Networking Support
* Editors
* FTP Server
* GNOME Software Development
* KDE Software Development
* Kernel Development
* Sound and Video
* System Tools
* Text-based Internet
* Web Server
* Windows File Server
* X Software Development

A full list of packages installed by the author on their VM during this most recent PS2 Linux tinkering stint is [here](redhat8_packages.txt). Note that this VM was also configured for things besides PS2 Linux cross-compiling, and so not all of these categories/packages may actually be necessary.

### Building Toolchain

A detailed and straightforward tutorial for building the toolchain was published by the playstation2-linux.com community in 2004. Links:
* Local backup [here](moz_cross_1.0.1.html) or rendered [here](https://html-preview.github.io/?url=https://github.com/Bort-Millipede/PS2Linux_BrainDump/blob/main/Software%20Installation/Toolchain/moz_cross_1.0.1.html)
* [Backup site](http://ps2linux.no-ip.info/playstation2-linux.com/download/mozilla-ps2/moz_cross_1.0.1.html)

The tutorial relies on the availability of Disc 2 of the PS2 Linux Kit Release 1.0. ISOs of these for each region can be found here:
* [Japan](https://archive.org/download/sony_playstation2_l/Linux%20%28for%20PlayStation%202%29%20Release%201.0%20%28Japan%29%20%28Disc%202%29%20%28Software%20Packages%29.zip)
* [USA](https://archive.org/download/sony_playstation2_l/Linux%20%28for%20PlayStation%202%29%20Release%201.0%20%28USA%29%20%28Disc%202%29%20%28Software%20Packages%29.zip)
* [Europe](https://archive.org/download/sony_playstation2_l/Linux%20%28for%20PlayStation%202%29%20Release%201.0%20%28Europe%29%20%28Disc%202%29%20%28Software%20Packages%29.zip)

After completing the tutorial, various ```mipsEEel-linux-*``` binaries (namely the C cross-compiler ```mipsEEel-linux-gcc``` and the C++ cross-compiler ```mipsEEel-linux-g++```) will be installed to the /usr/mipsEEel-linux/bin directory. This directory should be added to the user's PATH variable.

## Additional Recommended Steps For Setting Up Usable Environment

* The 2.2.1 kernel source from Release 1.0 is installed to ```/usr/mipsEEel-linux/mipsEEel-linux/usr/src/2.2.1_ps2``` as part of the tutorial. It is recommended that additional kernel sources also be installed to this directory:
  * 2.2.1 kernel source for Beta Release 1. Recommend renaming the directory to ```2.2.1_ps2-6```. Directions for installing to the cross-compiling environment are [available here](../Kernels/2.2.1_ps2-6).
  * 2.2.19 kernel source from Broadband Navigator 0.10. Recommend renaming the directory to ```2.2.19_ps2-5```. Directions for installing to the cross-compiling environment are [available here](../Kernels/2.2.19_ps2-5).
  * 2.4.17_mvl21 kernel source from Broadband Navigator 0.30 for Beta Release 1, or 2.4.17_mvl21 kernel source from Broadband Navigator 0.31 and 0.32 for Release 1.0.
    * Recommend renaming the directory for Beta Release 1 to ```2.4.17_ps2-22```. Directions for installing to the cross-compiling environment are [available here](../Kernels/2.4.17_ps2-22).
    * Recommend renaming the directory for Release 1.0 to ```2.4.17_ps2-26```. Directions for installing to the cross-compiling environment are [available here](../Kernels/2.4.17_ps2-26).
* The [setup-xrpms.sh](setup-xrpms.sh) script created/used in the tutorial does not go far enough in editing the ```*-config``` scripts installed to ```/usr/mipsEEel-linux/mipsEEel-linux/usr/bin``` (for example: ```esd-config``` is not edited) to reference ```/usr/mipsEEel-linux/mipsEEel-linux/usr/*``` directories. These should be manually inspected and edited:
  * ```/usr/include``` should be changed to ```/usr/mipsEEel-linux/mipsEEel-linux/usr/include```.
  * ```/usr/lib``` should be changed to ```/usr/mipsEEel-linux/mipsEEel-linux/usr/lib```.
  * ```/usr/X11R6/include``` should be changed to ```/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include```.
  * ```/usr/X11R6/lib``` should be changed to ```/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib```.
* Various ```*Conf.sh``` files in ```/usr/mipsEEel-linux/mipsEEel-linux/usr/lib``` reference ```/usr/lib``` and ```/usr/X11R6/lib```. These should be manually inspected and edited:
  * ```/usr/lib``` should be changed to ```/usr/mipsEEel-linux/mipsEEel-linux/usr/lib```.
  * ```/usr/X11R6/lib``` should be changed to ```/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib```.
* Various ```*.la``` files in ```/usr/mipsEEel-linux/mipsEEel-linux/usr/lib``` reference ```/usr/lib``` and ```/usr/X11R6/lib```. These should be manually inspected and edited:
  * ```/usr/lib``` should be changed to ```/usr/mipsEEel-linux/mipsEEel-linux/usr/lib```.
  * ```/usr/X11R6/lib``` should be changed to ```/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib```.

The above items could also be accomplished in a shell using sed/perl commands, but performing the edits manually is definitely a safer option.

## Additional Cross-Compilers

**NOTE:** All cross-compilers outlined below have only been used by the author to compile simple "hello world" binaries. Results may vary when attempting to compile more complex binaries.

Besides C and C++, additional cross-compilers can be built and installed with relative ease. This is accomplished by re-issuing the final GCC build/install command with additional option(s) for the LANGUAGES variable. 
 easily be built for the following languages:
* **Fortran 77**: ```make LANGUAGES="f77" install```
* **[CHILL](https://en.wikipedia.org/wiki/CHILL)**: ```make LANGUAGES="CHILL" install```

A Java binary compiler ```mipsEEel-linux-gcj``` can be successfully built and installed using ```make LANGUAGES="java" install```, but this compiler does not actually work due to a ```libgcj.spec: No such file or directory``` error. The compiler relies on libgcj, and building this for successful cross-compiling has not been completed at time of writing. A native version of ```gcj``` can be built and installed directly on PS2 Linux, as well as a native version of libgcj-2.95.1. However, preliminary testing showed issues with compiled binaries resulting in an "Illegal Instruction" error.

![](../Packages/libgcj/gcj_illegal_instruction_error.png?raw=true)  
*Illegal Instruction error when executing Java binary compiled with gcj*

Objective-C support can be included in ```mipsEEel-linux-gcc``` using ```make LANGUAGES="objc" install```. Preliminary testing showed issues with linking cross-compiled Objective-C based binaries. The ```gcc``` version pre-installed on PS2 Linux appears to include working Objective-C support (see below).

![](objc_linker_failure.png?raw=true)  
*Linker errors when compiling Objective-C code with mipsEEel-linux-gcc*

### Test Binaries

* [C](Testbin/hello.c): ```mipsEEel-linux-gcc -o hello-c hello.c```
* [C++](Testbin/hello.cpp): ```mipsEEel-linux-g++ -o hello-cpp hello.cpp```
* [Fortran 77](Testbin/hello.f): ```mipsEEel-linux-g77 -o hello-g77 hello.f```
* [CHILL](Testbin/hello.ch): ```mipsEEel-linux-chill -o hello-chill hello.ch```
* [Objective-C](Testbin/hello.m) (on PS2 Linux): ```gcc -o hello-objc hello.m -lobjc```

