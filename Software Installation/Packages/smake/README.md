# smake (schily-make) 1.2

[Source link](https://mirrors.dotsrc.org/schilytools/OLD/smake/smake-1.2.tar.gz)  
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

