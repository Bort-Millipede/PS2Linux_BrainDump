# star (schily-tar) 1.4.3

[Source link](https://mirrors.dotsrc.org/schilytools/OLD/star/star-1.4.3.tar.gz)  
**Build type:** native (directly on PS2 Linux)

## Prerequisites

It is recommended to set the ```/usr/src/linux``` symbolic link to reference the kernel 2.2.1 source directory. This is so the star binary can be used when booting the initfs.gz ramdisk.

### Dependencies

* [smake](smake)

## Building/Installing on PS2 Linux

Extract source archive
```bash
tar xzf star-1.4.3.tar.gz
cd star-1.4.3
```

&nbsp;  
Install to current directory and create installation archive (for easy installation onto future PS2 Linux installs)
```bash
smake
rm -rf usr
smake INS_BASE=`pwd`/usr/local install
tar czf star-1.4.3.mipsEEel-linux.tar.gz usr
```

&nbsp;  
Install to PS2 Linux (as root or via sudo)
```bash
smake INS_BASE=/usr/local install
```

### (RECOMMENDED) Post-Build "cleanup"

If [cdrtools-2.0 or cdrtools-2.01.01a36](cdrtools) was installed prior to building/installing star, it is recommended that cdrtools be re-installed from source (if the original source archive is still available) or via installation archive.

