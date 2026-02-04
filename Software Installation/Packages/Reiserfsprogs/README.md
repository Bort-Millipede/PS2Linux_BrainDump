# Reiserfsprogs 3.x.0j

**Note:** Precompiled Binaries ([reiserfsprogs-3.x.0j-1.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/reiserfsprogs-3.x.0j-1.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)! Consult [Installing on PS2 Linux (as root or via sudo)](#installing-on-ps2-linux-as-root-or-via-sudo) and [Usage Notes](#usage-notes) for installation and usage instructions.

Source: reiserfsprogs-3.x.0j-1.src.rpm present on [Playstation BB Navigator 0.30 Disc](https://archive.org/download/sony_playstation2_p/PlayStation%20BB%20Navigator%20-%20Version%200.30%20%28Japan%29.zip (within ```source.tgz``` file under ```source/reiserfsprogs```):  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Preliminary Considerations

The publicly-available Reiserfsprogs builds and executes successfully on PS2 Linux. However, partitions formatted with ReiserFS (via ```mkreiserfs```) are not correctly recognized by PS2 Linux. Therefore, the Reiserfsprogs source archive available via PSBBN must be used for building.

Reiserfsprogs will build successfully against all available kernels (2.2.1, 2.2.19, 2.4.17_mvl21). However, using Reiserfsprogs with the 2.2.1 Kernel is not feasible, as the kernel lacks ReiserFS partition support. Therefore, Reiserfs should be built against the 2.2.19 (recommended) or the 2.4.17_mvl21 kernel. As such, the ```/usr/mipsEEel-linux/mipsEEel-linux/usr/src/linux``` symbolic link must be recreated to reference one of the following:
* ```linux-2.2.19_ps2-5```: 2.2.19 kernel from Broadband Navigator 0.10
* ```linux-2.4.17_ps2-22```: 2.4.17_mvl21 from Broadband Navigator 0.30, for Beta Release 1
* ```linux-2.4.17_ps2-26``` from Broadband Navigator 0.31 and 0.32, for Release 1.0

## Building for PS2 Linux

Extract and patch source, and remove all previous build information
```bash
rpm2cpio reiserfsprogs-3.x.0j-1.src.rpm | cpio -id
tar xzf reiserfsprogs-3.x.0j.tar.gz
cd reiserfsprogs-3.x.0j
patch -p1 < ../reiserfs.patch
make distclean
```

&nbsp;  
Set necessary environment variables. Reiserfsprogs requires that the individual compilation components be specified via environment variables prior to executing ```configure```.  
```bash
export PREFIX=/usr/local
export ARCH=mipsEEel
export CROSS_COMPILE=mipsEEel-linux-
export CC=mipsEEel-linux-gcc
export NM=mipsEEel-linux-nm
export LD=mipsEEel-linux-ld
export CXX=mipsEEel-linux-c++
export RANLIB=mipsEEel-linux-ranlib
export AR=mipsEEel-linux-ar
export AS=mipsEEel-linux-as
export OBJDUMP=mipsEEel-linux-objdump
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host.
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| ${ARCH} /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | ${ARCH}-* /" "$f"; done
```

&nbsp;  
Configure and build source
```bash
./configure --host=mipsEEel-linux --prefix=$PREFIX
make
```

&nbsp;  
Install to current directory and create installation archive
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf reiserfsprogs-3.x.0j-1.mipsEEel-linux.tar.gz usr
```

### (RECOMMENDED) Post-Build Cleanup

Unset build-related environment variables, in case other software are conducted subsequently in the same shell session
```bash
unset PREFIX
unset ARCH
unset CROSS_COMPILE
unset CC
unset NM
unset LD
unset CXX
unset RANLIB
unset AR
unset AS
unset OBJDUMP
```

## Installing on PS2 Linux (as root or via sudo)

Transfer **reiserfsprogs-3.x.0j-1.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/reiserfsprogs-3.x.0j-1.mipsEEel-linux.tar.gz
```

## Usage Notes

Under the 2.2.1 Kernel, Reiserfsprogs can be used to perform actions against ReiserFS partitions (formatting, etc.). However, the kernel lacks ReiserFS partition support and therefore 

Using Reiserfsprogs with the 2.2.1 Kernel may not be feasible, as the kernel lacks ReiserFS partition support and therefore cannot actually mount or interact with ReiserFS partitions after they have been created. Therefore, it is recommended to only use this package with Kernels 2.2.19 or 2.4.17_mvl21.

