# cdrtools

Source links:  
* [cdrtools-1.10.tar.gz](https://mirrors.dotsrc.org/schilytools/OLD/cdrecord/cdrtools-1.10.tar.gz)
* [cdrtools-2.0.tar.gz](https://src.fedoraproject.org/repo/pkgs/cdrtools/cdrtools-2.0.tar.gz/2e94010d6f746c187352223b8ea50d64/cdrtools-2.0.tar.gz)
* [cdrtools-2.01.01a36.tar.gz](https://mirror.sobukus.de/files/src/cdrtools/cdrtools-2.01.01a36.tar.gz)

**Build type:** native (directly on PS2 Linux)

## Prerequisites

In general for any operations requiring the use of an optical drive, the built-in PS2 drive will not work (due to the "locked down" state of the drive in PS2 Linux). Therefore, a [USB optical drive](../../../USB&#32;Devices/Optical&#32;Drives) will be required. These devices only work under the 2.2.19 and 2.4.17_mvl21 kernels with the necessary kernel modules loaded (as root or via sudo): 
```bash
/sbin/insmod cdrom
/sbin/insmod sd_mod
/sbin/insmod sr_mod
/sbin/insmod usb-storage
```

**NOTE:** The ```cdrom``` module is usually built into Kernel 2.4.17_mvl21 by default, and therefore does not need to be loaded.

For burning CDs/DVDs via ```cdrecord```, this appears to only be available under kernel 2.4.17_mvl21 with specific sub-modules of the usb-storage module enabled.

Because of the reason outlined above, cdrtools can only be used under kernel 2.4.17_mvl21 (recommended) or 2.2.19. As such, the software should be built against one of these kernel versions by recreating the ```/usr/src/linux``` to reference one of the following:  
* ```2.4.17_ps2```: 2.4.17_mvl21 from Broadband Navigator 0.30, for Beta Release 1; or 2.4.17_mvl21 from Broadband Navigator 0.31 and 0.32, for Release 1.0
* ```2.2.19_ps2```: 2.2.19 kernel from Broadband Navigator 0.10

### Dependencies

* [smake](../smake)

## Building/Installing on PS2 Linux

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

