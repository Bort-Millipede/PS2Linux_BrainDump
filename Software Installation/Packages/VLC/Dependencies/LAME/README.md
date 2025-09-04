# LAME 3.96

**Note:** Precompiled Binaries ([lame-3.96.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/lame-3.96.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)! Consult [Installing on PS2 Linux (as root)](#installing-on-ps2-linux-as-root) for installation instructions.

[Source link](http://download.videolan.org/pub/videolan/vlc/0.7.2/contrib/lame-3.96.tar.gz) (available under GPL v2)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Building/Installing for Cross-Compiling Environment

Extract source archive.
```bash
tar xzf lame-3.96.tar.gz
cd lame-3.96
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
export GTK_CONFIG=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin/gtk-config
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
./configure --host=mipsEEel-linux --prefix=$PREFIX --enable-shared --disable-gtktest
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
tar xzf lame-3.96.tar.gz
cd lame-3.96
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
export GTK_CONFIG=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin/gtk-config
```

Modify autoconf files to include mipsEEel-linux host. (If using the same extracted directory as above, this should be skipped)
```bash
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
./configure --host=mipsEEel-linux --prefix=$PREFIX --enable-shared --disable-gtktest
make
```

&nbsp;  
Install to current directory, then create installation archive.
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf lame-3.96.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer **lame-3.96.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/lame-3.96.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

