# Reiserfsprogs 3.x.0j

[Source link](http://kernel.nic.funet.fi/pub/linux/kernel/people/jeffm/reiserfsprogs/v3.x.0j/reiserfsprogs-3.x.0j.tar.gz)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Preliminary Considerations

Reiserfsprogs should build successfully against all available kernels (2.2.1, 2.2.19, 2.4.17_mvl21). However, the 2.2.1 Kernel likely cannot actually mount or interact with ReiserFS partitions.

## Building for PS2 Linux

Extract source archive
```bash
tar xzf reiserfsprogs-3.x.0j.tar.gz
cd reiserfsprogs-3.x.0j
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
tar czf reiserfsprogs-3.x.0j.mipsEEel-linux.tar.gz usr
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

## Installing on PS2 Linux (as root)

Transfer **reiserfsprogs-3.x.0j.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf reiserfsprogs-3.x.0j.mipsEEel-linux.tar.gz
```

## Usage Notes

The 2.2.1 Kernel likely cannot actually mount or interact with ReiserFS partitions. Therefore it is recommended to only use this package with Kernels 2.2.19 or 2.4.17_mvl21.

