# smake (schily-make) 1.2

**Note:** Precompiled Binaries ([smake-1.2.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/smake-1.2.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)! Consult [Installing on PS2 Linux (as root or via sudo)](#installing-on-ps2-linux-as-root-or-via-sudo) for installation instructions.

[Source link](https://mirrors.dotsrc.org/schilytools/OLD/smake/smake-1.2.tar.gz) (available under GPL v2, LGPL v2.1, CDDL 1.0)  
**Build type:** native (directly on PS2 Linux)

## Building on PS2 Linux

Extract source archive:
```bash
tar xzf smake-1.2.tar.gz
cd smake-1.2
```

&nbsp;  
Build source.
```bash
make
```

&nbsp;  
Install to current directory and create installation archive (for easy installation onto future PS2 Linux installs)
```bash
make INS_BASE=`pwd`/usr/local install
tar czf smake-1.2.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root or via sudo)

### From Built Source Above

From the source directory above, install to PS2 Linux.
```bash
make INS_BASE=/usr/local install
```

### From Installation Archive

Transfer **smake-1.2.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/smake-1.2.mipsEEel-linux.tar.gz
```

