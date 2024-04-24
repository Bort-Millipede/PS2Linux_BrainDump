# libdvdread (20030812)

[Source link](http://download.videolan.org/pub/videolan/vlc/0.7.2/contrib/libdvdread-20030812.tar.bz2)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Building/Installing for Cross-Compiling Environment

Extract source archive.
```bash
tar xjf libdvdread-20030812.tar.bz2
cd libdvdread-20030812
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
```

&nbsp;  
Execute ```bootstrap``` script and modify autoconf files to include mipsEEel-linux host.
```bash
./bootstrap
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
```

&nbsp;  
Configure and build source.
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

Extract source archive. (if using the same extracted directory as above, this should be skipped)
```bash
tar xjf libdvdread-20030812.tar.bz2
cd libdvdread-20030812
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
```

&nbsp;  
Execute ```bootstrap``` script and modify autoconf files to include mipsEEel-linux host. (if using the same extracted directory as above, this should be skipped)
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-* /" "$f"; done
```

&nbsp;  
Completely clear previous build (if using a new extracted directory and not the same one as used above, this can be skipped)
```
make distclean
```

&nbsp;  
Configure and build source.
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --enable-shared
make
```

&nbsp;  
Install to current directory, then create installation archive.
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf libdvdread-20030812.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer **libdvdread-20030812.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/libdvdread-20030812.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

