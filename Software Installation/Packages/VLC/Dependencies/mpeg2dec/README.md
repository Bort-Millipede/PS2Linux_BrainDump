# mpeg2dec 0.4.0

**Note:** Precompiled Binaries ([mpeg2dec-0.4.0.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/mpeg2dec-0.4.0.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)! Consult [Installing on PS2 Linux (as root)](#installing-on-ps2-linux-as-root) for installation instructions.

[Source link](http://download.videolan.org/pub/videolan/vlc/0.7.2/contrib/mpeg2dec-0.4.0.tar.gz) (available under GPL v2)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Building/Installing for Cross-Compiling Environment

Extract source archive.
```bash
tar xzf mpeg2dec-0.4.0.tar.gz
cd mpeg2dec-0.4.0
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host, then edit ```configure``` script files to reference cross-compiled ```sdl-config``` script.
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
perl -i.bak -pe "s/\`sdl-config/\`\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/bin\/sdl-config/" configure
perl -i.bak -pe "s/\`sdl-config/\`\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/bin\/sdl-config/" libvo/configure.incl
```

&nbsp;  
Configure and build source
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --x-includes=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include --x-libraries=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib --with-x --enable-shared
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
tar xzf mpeg2dec-0.4.0.tar.gz
cd mpeg2dec-0.4.0
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host, then edit ```configure``` script files to reference cross-compiled ```sdl-config``` script. (if using the same extracted directory as above, this should be skipped)
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
perl -i.bak -pe "s/\`sdl-config/\`\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/bin\/sdl-config/" configure
perl -i.bak -pe "s/\`sdl-config/\`\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/bin\/sdl-config/" libvo/configure.incl
```

&nbsp;  
Completely clear previous build (if using a new extracted directory and not the same one as used above, this can be skipped)
```
make distclean
```

&nbsp;  
Configure and build source
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --x-includes=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include --x-libraries=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib --with-x --enable-shared
make
```

&nbsp;  
Install to current directory, then create installation archive.
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf mpeg2dec-0.4.0.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer **mpeg2dec-0.4.0.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/mpeg2dec-0.4.0.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

