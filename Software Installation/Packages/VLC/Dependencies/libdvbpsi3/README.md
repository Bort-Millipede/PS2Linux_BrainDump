# libdvbpsi3 0.1.4

[Source link](http://download.videolan.org/pub/videolan/vlc/0.7.2/contrib/libdvbpsi3-0.1.4.tar.gz)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Building/Installing for Cross-Compiling Environment

Extract source archive.
```bash
tar xzf libdvbpsi3-0.1.4.tar.gz
cd libdvbpsi3-0.1.4
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
```

&nbsp;  
Execute ```bootstrap``` script and ```aclocal```, then modify autoconf files to include mipsEEel-linux host.
```bash
./bootstrap
aclocal
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
```

&nbsp;  
Configure and build source
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --enable-shared
make
```

&nbsp;  
Install to cross-compiling environment (as root or via sudo).
```bash
make install
```

## Building for PS2 Linux

Extract source archive (if using the same extracted directory as above, this should be skipped)
```bash
tar xzf libdvbpsi3-0.1.4.tar.gz
cd libdvbpsi3-0.1.4
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
```

&nbsp;  
Execute ```bootstrap``` script and ```aclocal```, then modify autoconf files to include mipsEEel-linux host. (If using the same extracted directory as above, this should be skipped)
```bash
./bootstrap
aclocal
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
```

&nbsp;  
Completely clear previous build (if using a new extracted directory and not the same one as used above, this can be skipped)
```
make distclean
```

&nbsp;  
Configure and build source
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --enable-shared
make
```

&nbsp;  
Install to current directory, then create installation archive.
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf libdvbpsi3-0.1.4.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer **libdvbpsi3-0.1.4.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/libdvbpsi3-0.1.4.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

