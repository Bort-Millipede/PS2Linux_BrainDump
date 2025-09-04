# libdvdnav 0.1.10

**Note:** Precompiled Binaries ([libdvdnav-0.1.10.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/libdvdnav-0.1.10.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)! Consult [Installing on PS2 Linux (as root)](#installing-on-ps2-linux-as-root) for installation instructions.

[Source link](https://sourceforge.net/projects/dvd/files/libdvdnav/0.1.10/libdvdnav-0.1.10.tar.gz/download) (available under GPL v2)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Building/Installing for Cross-Compiling Environment

Extract source archive.
```bash
tar xzf libdvdnav-0.1.10.tar.gz
cd libdvdnav-0.1.10
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
```

&nbsp;  
Generate initial Makefiles using ```autogen.sh``` and clear any prior build information, then modify autoconf files to include mipsEEel-linux host.
```
./autogen.sh
make distclean
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
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
tar xzf libdvdnav-0.1.10.tar.gz
cd libdvdnav-0.1.10
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
```

&nbsp;  
Generate initial Makefiles using ```autogen.sh``` and clear any prior build information, then modify autoconf files to include mipsEEel-linux host. (if using the same extracted directory as above, these should be skipped)
```bash
./autogen.sh
make distclean
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
```

&nbsp;  
Completely clear previous build (if using a new extracted directory and not the same one as used above, this can be skipped)
```bash
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
tar czf libdvdnav-0.1.10.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer **libdvdnav-0.1.10.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/libdvdnav-0.1.10.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

