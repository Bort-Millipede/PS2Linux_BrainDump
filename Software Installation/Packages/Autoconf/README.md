# Autoconf 2.53

**Note:** Precompiled Binaries ([autoconf-2.53.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/autoconf-2.53.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)! Consult [Installing on PS2 Linux (as root)](#installing-on-ps2-linux-as-root) and [Usage Notes](#usage-notes) for installation and usage instructions.

[Source link](https://ftp.gnu.org/gnu/autoconf/autoconf-2.53.tar.bz2) (available under GPL v2)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Prerequisites

PS2 Linux comes with Autoconf 2.13 pre-installed, but building certain software natively on PS2 Linux requires a newer Autoconf version. The procedure below will not replace the pre-installed Autoconf 2.13 on PS2 Linux, but will instead install alongside it.

## Building for PS2 Linux

Extract source archive
```bash
tar xjf autoconf-2.53.tar.bz2
cd autoconf-2.53
```

&nbsp;  
Set necessary environment variables.
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
Configure and build source
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux
make
```

&nbsp;  
Install to current directory and create additional binaries (filenames appended with ```-2.53```), then create installation archive.
```bash
rm -rf usr
make DESTDIR=`pwd` install
cd usr/local/bin
for f in `ls *`; do cp "$f" "${f}-2.53"; done
cd ../../..
tar czf autoconf-2.53.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer **autoconf-2.53.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/autoconf-2.53.mipsEEel-linux.tar.gz
```

## Usage notes

To use this updated Autoconf version when building software natively on PS2 Linux, configuration and build scripts must be edited to call the ```*-2.53``` binaries directly.

