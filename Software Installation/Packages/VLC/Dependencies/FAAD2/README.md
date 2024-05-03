# FAAD2 2.0

[Source link](http://download.videolan.org/pub/videolan/vlc/0.7.2/contrib/faad2-2.0.tar.bz2)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Building/Installing for Cross-Compiling Environment

Extract source archive and rename source directory.
```bash
tar xjf faad2-2.0.tar.bz2
mv faad2-2.0 faad2-2.0_crosspc
cd faad2-2.0
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host.
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
```

&nbsp;  
Configure source and patch indentation errors in Makefile. Notes about passed options:  
* ```--without-xmms```: Do not build XMMS plugins, as this is likely not installed into the cross-compiling environment.
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --enable-shared --without-xmms
perl -i.bak -pe "s/^       m/\tm/" Makefile
perl -i -pe "s/^       \\$/\t\\$/" Makefile
perl -i -pe "s/^       r/\tr/" Makefile
```

&nbsp;  
Build source
```bash
make
```

&nbsp;  
Install to cross-compiling environment (as root or via sudo).
```bash
make install
```

## Building for PS2 Linux

Re-extract source archive. Do NOT use the same extracted directory as was used above.
```bash
tar xjf faad2-2.0.tar.bz2
cd faad2-2.0
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host.
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
```

&nbsp;  
Configure source and patch indentation errors in Makefile. Notes about passed options:  
* ```--without-xmms```: Do not build XMMS plugins, as XMMS is likely not installed into the cross-compiling environment.
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --enable-shared --without-xmms
perl -i.bak -pe "s/^       m/\tm/" Makefile
perl -i -pe "s/^       \\$/\t\\$/" Makefile
perl -i -pe "s/^       r/\tr/" Makefile
```

&nbsp;  
Build source
```bash
make
```

&nbsp;  
Install to current directory, then create installation archive.
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf faad2-2.0.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer **faad2-2.0.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/faad2-2.0.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

