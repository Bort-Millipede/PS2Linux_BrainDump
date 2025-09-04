# smake (schily-make) 1.2

**Note:** Precompiled Binaries ([smake-1.2.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/smake-1.2.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)!

[Source link](https://mirrors.dotsrc.org/schilytools/OLD/smake/smake-1.2.tar.gz) (available under GPL v2, LGPL v2.1, CDDL 1.0)  
**Build type:** native (directly on PS2 Linux)

## Building/Installing on PS2 Linux

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

&nbsp;  
Install to PS2 Linux (as root or via sudo)
```bash
make INS_BASE=/usr/local install
```

