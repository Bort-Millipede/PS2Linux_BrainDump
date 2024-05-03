# libdvdcss 1.2.8

[Source link](https://download.videolan.org/pub/videolan/vlc/0.7.2/contrib/libdvdcss-1.2.8.tar.gz)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Prerequisites

libdvdcss must be built against kernel 2.2.19 (recommended) or 2.4.17_mvl21. It CANNOT be built against kernel 2.2.1. As such, the 2.2.19 kernel source and/or 2.4.17_mvl21 kernel source will need to be installed to the cross-compiling environment (2.2.19 [outlined here](../../../../Kernels/2.2.19_ps2-5); 2.4.17_mvl21 for PS2 Linux Beta Release 1 [outlined here](../../../../Kernels/2.4.17_ps2-22); 2.4.17_mvl21 for PS2 Linux Release 1.0 [outlined here](../../../../Kernels/2.4.17_ps2-22)).

Additionally, the ```/usr/mipsEEel-linux/mipsEEel-linux/usr/src/linux``` symbolic link will need to be recreated to reference one of the above kernels:
* ```2.2.19_ps2-5```: Kernel 2.2.19
* ```linux-2.4.17_ps2-22```: Kernel 2.4.17_mvl21 for PS2 Linux Beta Release 1
* ```linux-2.4.17_ps2-26```: Kernel 2.4.17_mvl21 for PS2 Linux Release 1.0

## Building/Installing for Cross-Compiling Environment

Extract source archive.
```bash
tar xzf libdvdcss-1.2.8.tar.gz
cd libdvdcss-1.2.8
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
```

&nbsp;  
Execute ```bootstrap``` script and ```aclocal```, then modify autoconf files to include mipsEEel-linux host.
```bash
./bootstrap
aclocal
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
```

&nbsp;  
Modify the configuration include file template to specify that DVD_STRUCT is defined in the ```linux/cdrom.h``` file.
```bash
perl -i.bak -pe "s/^\#undef DVD_STRUCT_IN_LINUX_CDROM_H/\#define DVD_STRUCT_IN_LINUX_CDROM_H 1/" config.h.in
```

&nbsp;  
Configure and build source.
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --enable-shared
make
```

&nbsp;  
Install to cross-compiling environment (as root or via sudo).
```bash
make install
```

## Building for PS2 Linux

Extract source archive. (if using the same extracted directory as above, this should be skipped)
```bash
tar xzf libdvdcss-1.2.8.tar.gz
cd libdvdcss-1.2.8
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
```

&nbsp;  
Execute ```bootstrap``` script and ```aclocal```, then modify autoconf files to include mipsEEel-linux host. (if using the same extracted directory as above, these should be skipped)
```bash
./bootstrap
aclocal
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
```

&nbsp;  
Modify the configuration include file template to specify that DVD_STRUCT is defined in the ```linux/cdrom.h``` file.  (if using the same extracted directory as above, this should be skipped)
```bash
perl -i.bak -pe "s/^\#undef DVD_STRUCT_IN_LINUX_CDROM_H/\#define DVD_STRUCT_IN_LINUX_CDROM_H 1/" config.h.in
```

&nbsp;  
Completely clear previous build (if using a new extracted directory and not the same one as used above, this can be skipped)
```
make distclean
```

&nbsp;  
Configure and build source.
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --enable-shared
make
```

&nbsp;  
Install to current directory, then create installation archive.
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf libdvdcss-1.2.8.mipsEEel-linux.tar.gz usr
```

### (RECOMMENDED) Post-Build Cleanup

The ```/usr/mipsEEel-linux/mipsEEel-linux/usr/src/linux``` symbolic link should be recreated to reference the 2.2.1 Kernel source.

## Installing on PS2 Linux (as root)

Transfer **libdvdcss-1.2.8.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/libdvdcss-1.2.8.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

