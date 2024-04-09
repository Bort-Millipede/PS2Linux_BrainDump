# pv (pipe viewer) 0.6.4

[Source link](http://download.nust.na/pub2/openpkg1/sources/DST/pv/pv-0.6.4.tar.gz)  
**Build type:** cross-compiling (on system with mipsEEel-linux-* toolchain installed)

## Building for PS2 Linux

Extract archive
```bash
tar xzf pv-0.6.4.tar.gz
cd pv-0.6.4
```

&nbsp;  
Set necessary environment variables
```bash
export PREFIX=/usr/local
export LD=mipsEEel-linux-ld
```

&nbsp;  
Configure source. Set correct linker in Makefile and add DESTDIR support to Makefile
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux
perl -i.bak -pe "s/^LD = ld/LD = mipsEEel-linux-ld/" Makefile
perl -i -pe "s/\\$\(bindir\)/\\$\(DESTDIR\)\\$\(bindir\)/" Makefile
perl -i -pe "s/\\$\(mandir\)/\\$\(DESTDIR\)\\$\(mandir\)/" Makefile
perl -i -pe "s/\\$\(infodir\)/\\$\(DESTDIR\)\\$\(infodir\)/" Makefile
perl -i -pe "s/destdir=\\$\(gnulocaledir\)/destdir=\\$\(DESTDIR\)\\$\(gnulocaledir\)/" Makefile
perl -i -pe "s/destdir=\\$\(localedir\)/destdir=\\$\(DESTDIR\)\\$\(localedir\)/" Makefile
```

&nbsp;  
Build source
```bash
make
```

&nbsp;  
Install to current directory and create installation archive
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf pv-0.6.4.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer *pv-0.6.4.mipsEEel-linux.tar.gz* archive to PS2 Linux and install
```bash
cd /
tar xzf /path/to/pv-0.6.4.mipsEEel-linux.tar.gz
```

