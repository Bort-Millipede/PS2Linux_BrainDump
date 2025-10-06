# Automake

**Note:** Precompiled Binaries ([heme-0.4.2.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/heme-0.4.2.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)! Consult [Installing on PS2 Linux (as root)](#installing-on-ps2-linux-as-root) for installation instructions.

[Source link](https://github.com/UplinkCoder/heme/archive/refs/heads/master.zip) (available under GPL v2; renamed to heme-0.4.2.zip)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Building for PS2 Linux

Extract source archive.
```bash
unzip heme-0.4.2.zip
mv heme-master heme-0.4.2
cd heme-0.4.2
```

&nbsp;  
Modify Makefile to add DESTDIR support and to disable incorrect binary stripping during install.
```bash
perl -i.bak -pe "s/\\$\(INSTALL_PREFIX\)\/bin/\\$\(DESTDIR\)\\$\(INSTALL_PREFIX\)\/bin/" Makefile
perl -i -pe "s/\\$\(INSTALL_PREFIX\)\/man\/man1/\\$\(DESTDIR\)\\$\(INSTALL_PREFIX\)\/man\/man1/" Makefile
perl -i -pe "s/^\tinstall -s -m 0755/\tmkdir -p \\$\(DESTDIR\)\\$\(INSTALL_PREFIX\)\/bin\n\tmkdir -p \\$\(DESTDIR\)\\$\(INSTALL_PREFIX\)\/man\/man1\n\tinstall -m 0755/" Makefile
```

&nbsp;  
Build source, install to current directory, strip binary, and create installation archive.
```bash
CC=mipsEEel-linux-gcc make
CC=mipsEEel-linux-gcc make DESTDIR=`pwd` install
mipsEEel-linux-strip usr/local/bin/heme
tar czf heme-0.4.2.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer **heme-0.4.2.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf heme-0.4.2.mipsEEel-linux.tar.gz
```

