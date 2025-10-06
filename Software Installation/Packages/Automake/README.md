# Automake

**Note:** Precompiled Binaries ([automake-1.5.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/automake-1.5.mipsEEel-linux.tar.gz) and [automake-1.6.3.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/automake-1.6.3.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)! Consult [Installing on PS2 Linux (as root)](#installing-on-ps2-linux-as-root) ([1.5](#15) and [1.6.3](#163)) and [Usage notes](#usage-notes) for installation and usage instructions.

Source links:  
* [automake-1.5.tar.gz](https://ftp.gnu.org/gnu/automake/automake-1.5.tar.gz) (available under GPL v2)
* [automake-1.6.3.tar.gz](https://ftp.gnu.org/gnu/automake/automake-1.6.3.tar.gz) (available under GPL v2)

**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Prerequisites

PS2 Linux comes with Automake 1.4 pre-installed, but building certain software natively on PS2 Linux requires a newer Automake version. The procedure below will not replace the pre-installed Automake 1.4 on PS2 Linux, but will instead install alongside it.

## Building for PS2 Linux

### Automake 1.5

Extract source archive.
```bash
tar xzf automake-1.5.tar.gz
cd automake-1.5
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
Install to current directory and create additional binaries (filenames appended with ```-1.5```), then create installation archive.
```bash
rm -rf usr
make DESTDIR=`pwd` install
cd usr/local/bin
for f in `ls *`; do cp "$f" "${f}-1.5"; done
cd ../../..
tar czf automake-1.5.mipsEEel-linux.tar.gz usr
```

### Automake 1.6.3

Extract source archive.
```bash
tar xzf automake-1.6.3.tar.gz
cd automake-1.6.3
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
Install to current directory and create installation archive.
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf automake-1.6.3.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

### 1.5

Transfer **automake-1.5.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf automake-1.5.mipsEEel-linux.tar.gz
```

### 1.6.3

Transfer **automake-1.6.3.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf automake-1.6.3.mipsEEel-linux.tar.gz
```

## Usage notes

To use these updated Automake versions when building software natively on PS2 Linux, configuration and build scripts must be edited to call the ```*-1.5``` or ```*-1.6``` binaries directly.

