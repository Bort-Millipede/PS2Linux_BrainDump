# wxWindows 2.5.1 (20031222)

[Source link](http://download.videolan.org/pub/videolan/vlc/0.7.2/contrib/wxWindows-20031222.tar.gz)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

### Building/Installing for Cross-Compiling Environment

Extract source archive.
```bash
tar xzf wxWindows-20031222.tar.gz
cd wxWindows-20031222
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
Configure and build source.
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --x-includes=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include --x-libraries=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib --enable-shared --enable-optimise --with-x
make
```

&nbsp;  
Install to cross-compiling environment (as root or via sudo).
```bash
make install
```

### Building for PS2 Linux

Extract source archive (if using the same extracted directory as above, this should be skipped)
```bash
tar xzf wxWindows-20031222.tar.gz
cd wxWindows-20031222
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
export GTK_CONFIG=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin/gtk-config
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
Configure and build source.
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --x-includes=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include --x-libraries=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib --enable-shared --enable-optimise --with-x
make
```

&nbsp;  
Install to current directory and create installation archive.
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf wxWindows-20031222.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer **wxWindows-20031222.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/wxWindows-20031222.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

