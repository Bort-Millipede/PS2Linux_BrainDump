# mpg123 0.66

**Note:** Precompiled Binaries ([mpg123-0.66.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/mpg123-0.66.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)! Consult [Installing on PS2 Linux (as root)](#installing-on-ps2-linux-as-root) for installation instructions.

[Source link](https://src.rrz.uni-hamburg.de/files/src/mpg123/mpg123-0.66.tar.gz) (available under LGPL v2.1)
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Building

Extract source archive
```bash
tar xzf mpg123-0.66.tar.gz
cd mpg123-0.66
```

&nbsp;  
Set necessary environment variables
```bash
export PREFIX=/usr/local
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host.
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
```

&nbsp;
Configure and build source.
```bash
./configure --host=mipsEEel-linux --prefix=$PREFIX --with-optimization=3 --with-audio=oss
make
```

&nbsp;  
Install to current directory and create installation archive
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf mpg123-0.66.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer **mpg123-0.66.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/mpg123-0.66.mipsEEel-linux.tar.gz
```

