# FreeType and FreeType Demos

Source links:  
* [freetype-2.1.2.tar.gz](https://sourceforge.net/projects/freetype/files/OldFiles/freetype-2.1.2.tar.gz/download)
* [ft2demos-2.1.2.tar.gz](https://sourceforge.net/projects/freetype/files/OldFiles/ft2demos-2.1.2.tar.gz/download) **(OPTIONAL)**

[Free Kochi Mincho TrueType fonts](https://web.archive.org/web/20020802093141/http://www.on.cs.keio.ac.jp/~yasu/linux/fonts/kochi-mincho-0.2.20020727.tar.bz2) **(OPTIONAL)**

**Build types:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## References

* [http://www.geocities.jp/ps2linux_net/make_install/freetype.html](https://web.archive.org/web/20181105102800/http://www.geocities.jp/ps2linux_net/make_install/freetype.html)

## FreeType 2.1.2

### Building/Installing for Cross-Compiling Environment

Extract source archive
```bash
tar xzf freetype-2.1.2.tar.gz
cd freetype-2.1.2
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
export AR=mipsEEel-linux-ar
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host.
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-* /" "$f"; done
```

&nbsp;  
Configure and build source.
```bash
./configure --host=mipsEEel-linux --prefix=/usr/mipsEEel-linux/mipsEEel-linux/usr
make
```

&nbsp;  
Install to cross-compiling environment (as root or via sudo)
```bash
make install
```

### Building for PS2 Linux

Extract source archive (if using the same extracted directory as above, this should be skipped)
```bash
tar xzf freetype-2.1.2.tar.gz
cd freetype-2.1.2
```
  
&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
export AR=mipsEEel-linux-ar
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host (if using the same extracted directory as above, this should be skipped)
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-* /" "$f"; done
```

&nbsp;  
Completely clear previous build (if using a new extracted directory and not the same one as used above, this can be skipped)
```bash
make distclean
```

&nbsp;  
Configure and build source.
```bash
./configure --host=mipsEEel-linux --prefix=$PREFIX
make
```

&nbsp;  
Add DESTFILE variable support to installation sub-Makefile.
```bash
perl -i.bak -pe "s/\\$\(libdir\)/\\$\(DESTDIR)\\$\(libdir\)/" builds/unix/install.mk
perl -i -pe "s/\\$\(includedir\)/\\$\(DESTDIR)\\$\(includedir\)/" builds/unix/install.mk
perl -i -pe "s/\\$\(bindir\)/\\$\(DESTDIR)\\$\(bindir\)/" builds/unix/install.mk
perl -i -pe "s/\\$\(prefix\)/\\$\(DESTDIR)\\$\(prefix\)/" builds/unix/install.mk
```

&nbsp;  
Install to current directory and create installation archive.
```bash
rm -rf usr
make DESTDIR=`pwd` install
cp builds/unix/install.mk.bak builds/unix/install.mk
tar czf freetype-2.1.2.mipsEEel-linux.tar.gz usr
```

### (RECOMMENDED) Post-Build Cleanup

Unset build-related environment variables, in case other software are conducted subsequently in the same shell session
```bash
unset PREFIX
unset AR
```

## (OPTIONAL) FreeType Demos 2.1.2

### Building for PS2 Linux

Extract source archive
```bash
tar xzf ft2demos-2.1.2.tar.gz
cd ft2demos-2.1.2
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
```

&nbsp;  
Modify Makefile to reference correct FreeType source directory
```bash
perl -i.bak -pe "s/TOP_DIR := ..\/freetype2/TOP_DIR := ..\/freetype-2.1.2/" Makefile
```

&nbsp;  
Compile source against PS2 Linux X11 headers/libraries.
```bash
make X11_PATH="/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6"
```

&nbsp;  
Create symbolic links for invoking test binaries directly, then create installation archive.
```bash
for f in `ls -l | grep "\-rwx" | rev | cut -d" " -f 1 | rev`; do cp "$f" ${f}.bak; rm "$f"; ln -s .libs/$f $f; done #skips over wrapper scripts and sets up binaries to be called directly via symlinks
cd ..
tar czf ft2demos-2.1.2.mipsEEel-linux.tar.gz ft2demos-2.1.2
```

## Installing on PS2 Linux (as root)

Transfer **freetype-2.1.2.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/freetype-2.1.2.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

&nbsp;  
### **OPTIONAL:** Install FreeType Demos and Free Kochi Mincho TrueType fonts.

Transfer **ft2demos-2.1.2.mipsEEel-linux.tar.gz** and **kochi-mincho-0.2.20020727.tar.bz2** archives to PS2 Linux and install.
```bash
cd /usr/local/share
tar xzf /path/to/ft2demos-2.1.2.mipsEEel-linux.tar.gz
tar xIf /path/to/kochi-mincho-0.2.20020727.tar.bz2
```

&nbsp;  
Freetype Demo binaries can be executed from anywhere. Add /usr/local/share/ft2demos-2.1.2/bin to PATH variable if desired.

