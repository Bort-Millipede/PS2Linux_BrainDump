# Popt 1.7

[Source link](https://web.archive.org/web/20070321192844/http://gd.tuwien.ac.at/utils/rpm.org/dist/rpm-4.1.x/popt-1.7.tar.gz)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Building/Installing for Cross-Compiling Environment

Extract source archive
```bash
tar xzf popt-1.7.tar.gz
cd popt-1.7
```

&nbsp;  
Set necessary environment variables
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
```

&nbsp;  
Configure and build source
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --enable-shared
make
```

Install to cross-compiling environment (as root or via sudo).
```
make install
```

## Building for PS2 Linux

Extract source archive (if using the same extracted directory as above, this should be skipped)
```bash
tar xzf popt-1.7.tar.gz
cd popt-1.7
```

&nbsp;  
Set necessary environment variables
```bash
export PREFIX=/usr/local
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host (if using the same extracted directory as above, this should be skipped)
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
```

&nbsp;  
Completely clear previous build (if using a new extracted directory and not the same one as used above, this can be skipped)
```bash
make distclean
```

&nbsp;  
Configure and build source
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --enable-shared
make
```

&nbsp;  
Install to current directory and create installation archive
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf popt-1.7.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer **popt-1.7.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/popt-1.7.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

