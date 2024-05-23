# SDL and SDL_net

Source links:  
* [SDL-1.2.5.tar.gz](https://www.libsdl.org/release/SDL-1.2.5.tar.gz)
* [SDL_net-1.2.2.tar.gz](https://www.libsdl.org/projects/SDL_net/release/SDL_net-1.2.2.tar.gz)

**Build types:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## References

* [http://www.geocities.jp/ps2linux_net/SDL/SDL.html](https://web.archive.org/web/20181105102800/http://www.geocities.jp/ps2linux_net/SDL/SDL.html)
* [http://www.geocities.jp/ps2linux_net/SDL/SDL_net.html](https://web.archive.org/web/20181105102813/http://www.geocities.jp/ps2linux_net/SDL/SDL_net.html)
* [https://forums.raspberrypi.com/viewtopic.php?t=39667](https://forums.raspberrypi.com/viewtopic.php?t=39667)

## SDL 1.2.5

### Building/Installing for Cross-Compiling Environment

Extract source archive
```bash
tar xzf SDL-1.2.5.tar.gz
cd SDL-1.2.5
```

&nbsp;  
Set necessary environment variables. SDL requires that the individual compilation components be specified via environment variables prior to executing ```configure```.  
**NOTE**: ```esd-config``` referenced below must be edited prior to building SDL per [these instructions](https://github.com/Bort-Millipede/PS2Linux_BrainDump/tree/main/Software%20Installation/Toolchain#additional-recommended-steps-for-setting-up-usable-environment)
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
export ARCH=mipsEEel
export CROSS_COMPILE=mipsEEel-linux-
export CC=mipsEEel-linux-gcc
export NM=mipsEEel-linux-nm
export LD=mipsEEel-linux-ld
export CXX=mipsEEel-linux-c++
export RANLIB=mipsEEel-linux-ranlib
export AR=mipsEEel-linux-ar
export AS=mipsEEel-linux-as
export OBJDUMP=mipsEEel-linux-objdump
export STRIP=mipsEEel-linux-strip
export ESD_CONFIG=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin/esd-config
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host.
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| ${ARCH} /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | ${ARCH}-\* /" "$f"; done
```

&nbsp;  
Configure source. Notes about passed options:  
* ```--disable-arts```: The "Analog Realtime Synthesizer" is not available for PS2 Linux by default, so this needs to be disabled in SDL.
```bash
./configure --host=mipsEEel-linux --prefix=$PREFIX --x-includes=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include --x-libraries=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib --enable-video-ps2gs --disable-mintaudio --disable-arts --disable-video-xbios --disable-video-gem --disable-directx
```

&nbsp;  
Build source.
```bash
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
tar xzf SDL-1.2.5.tar.gz
cd SDL-1.2.5
```

&nbsp;  
Set necessary environment variables. SDL requires that the individual compilation components be specified via environment variables prior to executing ```configure```.  
**NOTE**: ```esd-config``` referenced below must be edited prior to building SDL per [these instructions](https://github.com/Bort-Millipede/PS2Linux_BrainDump/tree/main/Software%20Installation/Toolchain#additional-recommended-steps-for-setting-up-usable-environment)
```bash
export PREFIX=/usr/local
export ARCH=mipsEEel
export CROSS_COMPILE=mipsEEel-linux-
export CC=mipsEEel-linux-gcc
export NM=mipsEEel-linux-nm
export LD=mipsEEel-linux-ld
export CXX=mipsEEel-linux-c++
export RANLIB=mipsEEel-linux-ranlib
export AR=mipsEEel-linux-ar
export AS=mipsEEel-linux-as
export OBJDUMP=mipsEEel-linux-objdump
export STRIP=mipsEEel-linux-strip
export ESD_CONFIG=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin/esd-config
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host (if using the same extracted directory as above, this should be skipped)
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| ${ARCH} /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | ${ARCH}-\* /" "$f"; done
```

&nbsp;  
Completely clear previous build (if using a new extracted directory and not the same one as used above, this can be skipped)
```bash
make distclean
```

&nbsp;  
Configure source. Notes about passed options:  
* ```--disable-arts```: The "Analog Realtime Synthesizer" is not available for PS2 Linux by default, so this needs to be disabled in SDL.
```bash
./configure --host=mipsEEel-linux --prefix=$PREFIX --x-includes=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include --x-libraries=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib --enable-video-ps2gs --disable-mintaudio --disable-arts --disable-video-xbios --disable-video-gem --disable-directx
```

&nbsp;  
Build source and install to current directory, then create installation archive.
```bash
make
rm -rf usr
make DESTDIR=`pwd` install
tar czf SDL-1.2.5.mipsEEel-linux.tar.gz usr
```

### (OPTIONAL) Building SDL Tests for PS2 Linux

Extract source archive (if using the same extracted directory as above, this should be skipped)
```bash
tar xzf SDL-1.2.5.tar.gz
cd SDL-1.2.5
```

&nbsp;  
Rename ```test``` directory to ```SDL-tests``` and enter directory
```bash
mv test SDL-tests
cd SDL-tests
```

&nbsp;  
Set necessary environment variables. SDL requires that the individual compilation components be specified via environment variables prior to executing ```configure```.  
**NOTE:** ```esd-config``` referenced below must be edited prior to building SDL per [these instructions](https://github.com/Bort-Millipede/PS2Linux_BrainDump/tree/main/Software%20Installation/Toolchain#additional-recommended-steps-for-setting-up-usable-environment)
```bash
export PREFIX=/usr/local
export ARCH=mipsEEel
export CROSS_COMPILE=mipsEEel-linux-
export CC=mipsEEel-linux-gcc
export NM=mipsEEel-linux-nm
export LD=mipsEEel-linux-ld
export CXX=mipsEEel-linux-c++
export RANLIB=mipsEEel-linux-ranlib
export AR=mipsEEel-linux-ar
export AS=mipsEEel-linux-as
export OBJDUMP=mipsEEel-linux-objdump
export STRIP=mipsEEel-linux-strip
export ESD_CONFIG=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin/esd-config
export SDL_CONFIG=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin/sdl-config
```

&nbsp;  
Create symbolic links for X libraries: required for successful cross-compiled build.
```bash
ln -sf ../X11R6/lib/libX11.so.6 /usr/mipsEEel-linux/mipsEEel-linux/usr/lib/libX11.so.6
ln -sf ../X11R6/lib/libXext.so.6 /usr/mipsEEel-linux/mipsEEel-linux/usr/lib/libXext.so.6
ln -sf ../X11R6/lib/libSM.so.6 /usr/mipsEEel-linux/mipsEEel-linux/usr/lib/libSM.so.6
ln -sf ../X11R6/lib/libICE.so.6 /usr/mipsEEel-linux/mipsEEel-linux/usr/lib/libICE.so.6
ln -sf ../X11R6/lib/libXmu.so.6 /usr/mipsEEel-linux/mipsEEel-linux/usr/lib/libXmu.so.6
ln -sf ../X11R6/lib/libXi.so.6 /usr/mipsEEel-linux/mipsEEel-linux/usr/lib/libXi.so.6
ln -sf ../X11R6/lib/libXt.so.6 /usr/mipsEEel-linux/mipsEEel-linux/usr/lib/libXt.so.6
```

&nbsp;  
Configure and build source.
```bash
./configure --host=mipsEEel-linux --prefix=$PREFIX --x-includes=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include --x-libraries=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib
make
```

&nbsp;  
Create installation archive
```bash
cd ..
tar czvf SDL-tests-1.2.5.mipsEEel-linux.tar.gz `file SDL-tests/* | grep "executable, MIPS R3000_LE" | cut -d":" -f 1` SDL-tests/README SDL-tests/COPYING SDL-tests/*.bmp SDL-tests/picture.xbm SDL-tests/sample.wav
```

## SDL_net 1.2.2

### Building/Installing for Cross-Compiling Environment

Extract source archive.
```bash
tar xzf SDL_net-1.2.2.tar.gz
cd SDL_net-1.2.2
```

&nbsp;  
Set necessary environment variables. SDL_net requires that the individual compilation components be specified via environment variables prior to executing ```configure```.  
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
export ARCH=mipsEEel
export CROSS_COMPILE=mipsEEel-linux-
export CC=mipsEEel-linux-gcc
export NM=mipsEEel-linux-nm
export LD=mipsEEel-linux-ld
export CXX=mipsEEel-linux-c++
export RANLIB=mipsEEel-linux-ranlib
export AR=mipsEEel-linux-ar
export AS=mipsEEel-linux-as
export OBJDUMP=mipsEEel-linux-objdump
export STRIP=mipsEEel-linux-strip
export SDL_CONFIG=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin/sdl-config
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host.
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| ${ARCH} /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | ${ARCH}-\* /" "$f"; done
```

&nbsp;  
Configure source.
```bash
./configure --host=mipsEEel-linux --prefix=$PREFIX --x-includes=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include --x-libraries=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib --disable-gui
```

&nbsp;  
Build source.
```bash
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
tar xzf SDL_net-1.2.2.tar.gz
cd SDL_net-1.2.2
```

&nbsp;  
Set necessary environment variables. SDL_net requires that the individual compilation components be specified via environment variables prior to executing ```configure```.  
```bash
export PREFIX=/usr/local
export ARCH=mipsEEel
export CROSS_COMPILE=mipsEEel-linux-
export CC=mipsEEel-linux-gcc
export NM=mipsEEel-linux-nm
export LD=mipsEEel-linux-ld
export CXX=mipsEEel-linux-c++
export RANLIB=mipsEEel-linux-ranlib
export AR=mipsEEel-linux-ar
export AS=mipsEEel-linux-as
export OBJDUMP=mipsEEel-linux-objdump
export STRIP=mipsEEel-linux-strip
export SDL_CONFIG=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin/sdl-config
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host (if using the same extracted directory as above, this should be skipped)
```bash
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| ${ARCH} /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | ${ARCH}-\* /" "$f"; done
```

&nbsp;  
Completely clear previous build (if using a new extracted directory and not the same one as used above, this can be skipped)
```bash
make distclean
```

&nbsp;  
Configure source.
```bash
./configure --host=mipsEEel-linux --prefix=$PREFIX --x-includes=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include --x-libraries=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib --disable-gui
```

&nbsp;  
Build source and install to current directory, then create installation archive
```bash
make
rm -rf usr
make DESTDIR=`pwd` install
tar czf SDL_net-1.2.2.mipsEEel-linux.tar.gz usr
```

## (RECOMMENDED) Post-Build Cleanup

Unset build-related environment variables, in case other software are conducted subsequently in the same shell session
```bash
unset PREFIX
unset ARCH
unset CROSS_COMPILE
unset CC
unset NM
unset LD
unset CXX
unset RANLIB
unset AR
unset AS
unset OBJDUMP
unset ESD_CONFIG
unset SDL_CONFIG
```

## Installing on PS2 Linux (as root)

Transfer **SDL-1.2.5.mipsEEel-linux.tar.gz** and **SDL_net-1.2.2.mipsEEel-linux.tar.gz** archives to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/SDL-1.2.5.mipsEEel-linux.tar.gz
/sbin/ldconfig
tar xzf /path/to/SDL_net-1.2.2.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

### **OPTIONAL:** Install SDL tests (as root)

Transfer **SDL-tests-1.2.5.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /usr/local/share
tar xzf /path/to/SDL-tests-1.2.5.mipsEEel-linux.tar.gz
```

