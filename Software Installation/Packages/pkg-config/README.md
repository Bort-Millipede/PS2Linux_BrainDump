# pkg-config 0.12.0

**Note:** Precompiled Binaries ([pkgconfig-0.12.0.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/pkgconfig-0.12.0.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)!

[Source link](https://pkgconfig.freedesktop.org/releases/pkgconfig-0.12.0.tar.gz) (available under GPL v2)  
**Build type:** native (directly on PS2 Linux)

## Building/Installing on PS2 Linux

Extract source archive:
```bash
tar xzf pkgconfig-0.12.0.tar.gz
cd pkgconfig-0.12.0
```

&nbsp;  
Set necessary environment variables
```bash
export PREFIX=/usr/local
```

&nbsp;  
Configure and build source
```bash
./configure --prefix=$PREFIX --enable-shared
make
```

&nbsp;  
Install to current directory and create installation archive (for easy installation onto future PS2 Linux installs)
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf pkgconfig-0.12.0.mipsEEel-linux.tar.gz usr
```

&nbsp;  
Install to PS2 Linux (as root or via sudo)
```bash
make install
```

