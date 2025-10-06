# cdrtools

**Note:** Precompiled Binaries ([cdrtools-1.10.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/cdrtools-1.10.mipsEEel-linux.tar.gz), [cdrtools-2.0.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/cdrtools-2.0.mipsEEel-linux.tar.gz), and [cdrtools-2.01.01a36.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/cdrtools-2.01.01a36.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)!

Source links:  
* [cdrtools-1.10.tar.gz](https://mirrors.dotsrc.org/schilytools/OLD/cdrecord/cdrtools-1.10.tar.gz) (available under GPL v2)
* [cdrtools-2.0.tar.gz](https://src.fedoraproject.org/repo/pkgs/cdrtools/cdrtools-2.0.tar.gz/2e94010d6f746c187352223b8ea50d64/cdrtools-2.0.tar.gz) (available under GPL v2)
* [cdrtools-2.01.01a36.tar.gz](https://mirror.sobukus.de/files/src/cdrtools/cdrtools-2.01.01a36.tar.gz) (available under GPL v2, LGPL v2.1, CDDL 1.0)

**Build type:** native (directly on PS2 Linux)

### Dependencies

* [2.2.19 and/or 2.4.17_mvl21 Kernel Source](../Kernel&#32;Source)
* [smake](../smake)

## Prerequisites

In general for any operations requiring the use of an optical drive, the built-in PS2 drive will not work (due to the "locked down" state of the drive in PS2 Linux). Therefore, a [USB optical drive](../../../USB&#32;Devices/Optical&#32;Drives) will be required. These devices only work under the 2.2.19 and 2.4.17_mvl21 kernels with the necessary kernel modules loaded (as root or via sudo): 
```bash
/sbin/insmod cdrom
/sbin/insmod sd_mod
/sbin/insmod sr_mod
/sbin/insmod usb-storage
```

**NOTE:** The ```cdrom``` module is usually built into Kernel 2.4.17_mvl21 by default, and therefore does not need to be loaded. However, even in this case the ```/sbin/insmod cdrom``` command above will not cause any sort of harm.

For burning CDs/DVDs via ```cdrecord```, this appears to only be available under kernel 2.4.17_mvl21 with specific sub-modules of the usb-storage module enabled (outlined on the [USB optical drive](../../../USB&#32;Devices/Optical&#32;Drives) page).

Because of the reason outlined above, cdrtools can only be used under kernel 2.4.17_mvl21 (recommended) or 2.2.19. As such, the software should be built against one of these kernel versions by recreating the ```/usr/src/linux``` to reference one of the following:  
* ```2.4.17_ps2```: 2.4.17_mvl21 from Broadband Navigator 0.30, for Beta Release 1; or 2.4.17_mvl21 from Broadband Navigator 0.31 and 0.32, for Release 1.0
* ```2.2.19_ps2```: 2.2.19 kernel from Broadband Navigator 0.10



## Building/Installing on PS2 Linux

Only a single cdrtools version may be installed to the system at one time.

### cdrtools 1.10

Extract source archive
```bash
tar xzf cdrtools-1.10.tar.gz
cd cdrtools-1.10
```

&nbsp;  
Build source
```bash
smake
```

&nbsp;  
Install to current directory and create installation archive (for easy installation onto future PS2 Linux installs)
```bash
smake INS_BASE=`pwd`/usr/local install
tar czf cdrtools-1.10.mipsEEel-linux.tar.gz usr
```

&nbsp;  
Install to PS2 Linux (as root or via sudo)
```bash
smake INS_BASE=/usr/local install
```

### cdrtools 2.0

Extract source archive
```bash
tar xzf cdrtools-2.0.tar.gz
cd cdrtools-2.0
```

&nbsp;  
Build source
```bash
smake
```

&nbsp;  
Install to current directory and create installation archive (for easy installation onto future PS2 Linux installs)
```bash
smake INS_BASE=`pwd`/usr/local install
tar czf cdrtools-2.0.mipsEEel-linux.tar.gz usr
```

&nbsp;  
Install to PS2 Linux (as root or via sudo)
```bash
smake INS_BASE=/usr/local install
```

### cdrtools 2.01.01a36

Extract source archive
```bash
tar xzf cdrtools-2.01.01a36.tar.gz
cd cdrtools-2.01.01
```

&nbsp;  
Build source
```bash
smake
```

&nbsp;  
Install to current directory and create installation archive (for easy installation onto future PS2 Linux installs)
```bash
smake INS_BASE=`pwd`/usr/local install
tar czf cdrtools-2.01.01a36.mipsEEel-linux.tar.gz usr
```

&nbsp;  
Install to PS2 Linux (as root or via sudo)
```bash
smake INS_BASE=/usr/local install
```

### (RECOMMENDED) Post-Build

If installing cdrtools 2.0 or 2.01.01a36, it is recommended that the build directory be retained in case cdrtools needs to be re-installed later (example: if [star](../star) is installed after first installing cdrtools). If this is not available, the installation archive created above can be used for re-installation instead.

## Usage Notes

![](mkisofs_versions.png?raw=true)  
*Multiple mkisofs versions installed*

PS2 Linux ships with mkisofs-1.12b5 installed. In order to use the exact ```mkisofs``` command installed with cdrtools above, either:
1. Execute the command via an absolute path: ```/usr/local/bin/mkisofs```; or
2. Uninstall mkisofs-1.12b5:
    * PS2 Linux Beta Release 1: ```rpm -vv -e mkisofs-1.12b5-7```
    * PS2 Linux Release 1.0: ```rpm -vv -e mkisofs-1.12b5-8```

## Usage Examples

![](cdrecord_dc_first_session_1.png?raw=true)  
*Burning first session of Dreamcast backup disc with cdrecord 2.01.01a36 from PS2 Linux*

![](cdrecord_dc_first_session_2.png?raw=true)  
*First session of Dreamcast backup disc burned successfully*

![](cdrecord_dc_second_session_1.png?raw=true)  
*Burning second session of Dreamcast backup disc with cdrecord 2.01.01a36 from PS2 Linux*

![](cdrecord_dc_second_session_2.png?raw=true)  
*Second session of Dreamcast backup disc burned successfully*

