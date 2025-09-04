## FFmpeg 20040520

**Note:** Precompiled Binaries ([ffmpeg-20040520.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/ffmpeg-20040520.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)! Consult [Installing on PS2 Linux (as root)](#installing-on-ps2-linux-as-root) for installation instructions.

[Source link](http://download.videolan.org/pub/videolan/vlc/0.7.2/contrib/ffmpeg-20040520.tar.bz2) (available under LGPL v2.1)
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Building/Installing for Cross-Compiling Environment

Extract source archive.
```bash
tar xjf ffmpeg-20040520.tar.bz2
cd ffmpeg-20040520
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
```

&nbsp;  
Patch ```configure``` script to reference correct ```freetype-config``` and ```sdl-config``` scripts.
```bash
perl -i.bak -pe "s/\`which freetype-config/\`which \/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/bin\/freetype-config/" configure
perl -i -pe "s/\`freetype-config/\`\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/bin\/freetype-config/g" configure
perl -i -pe "s/\`sdl-config/\`\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/bin\/sdl-config/g" configure
```

&nbsp;  
Patch Makefiles to:  
* Add ```DESTDIR``` argument support.
* Prevent binary stripping by incorrect ```strip``` command.
* Ensure libpostproc is built.
* Reference correct ```freetype-config``` script.
```bash
perl -i.bak -pe "s/\\$\(STRIP\) \\$\@/#\\$\(STRIP\) \\$\@/" Makefile
perl -i -pe "s/^\tinstall -d \"\\$\(bindir\)\"/\tinstall -d \"\\$\(DESTDIR\)\\$\(bindir\)\"/" Makefile
perl -i -pe "s/\tinstall -c -s -m 755 \\$\(PROG\) \"\\$\(bindir\)\"/\t\\$\(STRIP\) \\$\(PROG\)\n\tinstall -c -m 755 \\$\(PROG\) \"\\$\(DESTDIR\)\\$\(bindir\)\"/" Makefile
perl -i -pe "s/^\t\\$\(MAKE\) -C vhook install INSTDIR=\\$\(prefix\)\/lib\/vhook/\tinstall -d \\$\(DESTDIR\)\\$\(prefix\)\/lib\/vhook\n\t\\$\(MAKE\) -C vhook install INSTDIR=\\$\(DESTDIR\)\\$\(prefix\)\/lib\/vhook/" Makefile
perl -i -pe "s/INSTDIR=\\$\(prefix\)/INSTDIR=\\$\(DESTDIR\)\\$\(prefix\)/" Makefile
perl -i -pe "s/^\tinstall -d \\$\@/\tinstall -d \\$\(DESTDIR\)\\$\@/" Makefile
perl -i.bak -pe "s/^ifeq \(\\$\(SHARED_PP\),yes\)/ifeq \(\\$\(SHARED_PP\),no\)/" libavcodec/Makefile
perl -i -pe "s/^# LIBS \+= libpostproc\/libpostproc.a ... should be fixed/LIBS \+= libpostproc\/libpostproc.a/" libavcodec/Makefile
perl -i -pe "s/^\tinstall -s -m 755/\t\\$\(STRIP\) \\$\(SLIB\)\n\tinstall -m 755/" libavcodec/Makefile
perl -i -pe "s/\\$\(prefix\)\/lib/\\$\(DESTDIR\)\\$\(prefix\)\/lib/" libavcodec/Makefile
perl -i -pe "s/\\$\(prefix\)\/include\/ffmpeg/\\$\(DESTDIR\)\\$\(prefix\)\/include\/ffmpeg/" libavcodec/Makefile
perl -i.bak -pe "s/^\tinstall -s -m 755/\t\\$\(STRIP\) \\$\(SPPLIB\)\n\tinstall -m 755/" libavcodec/libpostproc/Makefile
perl -i -pe "s/\\$\(prefix\)/\\$\(DESTDIR\)\\$\(prefix\)/" libavcodec/libpostproc/Makefile
perl -i.bak -pe "s/^\tinstall -s -m 755/\t\\$\(STRIP\) \\$\(SLIB\)\n\tinstall -m 755/" libavformat/Makefile
perl -i -pe "s/\\$\(prefix\)\/lib/\\$\(DESTDIR\)\\$\(prefix\)\/lib/" libavformat/Makefile
perl -i -pe "s/\\$\(prefix\)\/include\/ffmpeg/\\$\(DESTDIR\)\\$\(prefix\)\/include\/ffmpeg/" libavformat/Makefile
perl -i.bak -pe "s/\`freetype-config/\`\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/bin\/freetype-config/" vhook/Makefile
```

&nbsp;  
Configure source and patch ```config.mak``` to reference correct ``ar``, ```ranlib```, and ```strip``` commands.
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --enable-mp3lame --enable-faad --enable-a52 --enable-pp --enable-gpl --enable-pthreads --enable-shared --enable-shared-pp --cc=mipsEEel-linux-gcc --cpu=mipsEEel
perl -i.bak -pe "s/^AR=ar/AR=mipsEEel-linux-ar/" config.mak
perl -i -pe "s/^RANLIB=ranlib/RANLIB=mipsEEel-linux-ranlib/" config.mak
perl -i -pe "s/^STRIP=strip/STRIP=mipsEEel-linux-strip/" config.mak
```

&nbsp;  
Build source
```bash
make lib
make all
make -C libavcodec/libpostproc
```

&nbsp;  
Install to cross-compiling environment (as root or via sudo).
```bash
make install
make installlib
make -C libavcodec/libpostproc install
```

## Building for PS2 Linux

Extract source archive. (if using the same extracted directory as above, this should be skipped)
```bash
tar xjf ffmpeg-20040520.tar.bz2
cd ffmpeg-20040520
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
```

&nbsp;  
Patch ```configure``` script to reference correct ```freetype-config``` and ```sdl-config``` scripts. (If using the same extracted directory as above, this should be skipped)
```bash
perl -i.bak -pe "s/\`which freetype-config/\`which \/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/bin\/freetype-config/" configure
perl -i -pe "s/\`freetype-config/\`\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/bin\/freetype-config/g" configure
perl -i -pe "s/\`sdl-config/\`\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/bin\/sdl-config/g" configure
```

&nbsp;  
(If using the same extracted directory as above, this should be skipped)
Patch Makefiles to:  
* Include ```DESTDIR``` argument support.
* Prevent binary stripping by incorrect ```strip``` command.
* Ensure libpostproc is built.
* Reference correct ```freetype-config``` script.
```bash
perl -i.bak -pe "s/\\$\(STRIP\) \\$\@/#\\$\(STRIP\) \\$\@/" Makefile
perl -i -pe "s/^\tinstall -d \"\\$\(bindir\)\"/\tinstall -d \"\\$\(DESTDIR\)\\$\(bindir\)\"/" Makefile
perl -i -pe "s/\tinstall -c -s -m 755 \\$\(PROG\) \"\\$\(bindir\)\"/\t\\$\(STRIP\) \\$\(PROG\)\n\tinstall -c -m 755 \\$\(PROG\) \"\\$\(DESTDIR\)\\$\(bindir\)\"/" Makefile
perl -i -pe "s/^\t\\$\(MAKE\) -C vhook install INSTDIR=\\$\(prefix\)\/lib\/vhook/\tinstall -d \\$\(DESTDIR\)\\$\(prefix\)\/lib\/vhook\n\t\\$\(MAKE\) -C vhook install INSTDIR=\\$\(DESTDIR\)\\$\(prefix\)\/lib\/vhook/" Makefile
perl -i -pe "s/INSTDIR=\\$\(prefix\)/INSTDIR=\\$\(DESTDIR\)\\$\(prefix\)/" Makefile
perl -i -pe "s/^\tinstall -d \\$\@/\tinstall -d \\$\(DESTDIR\)\\$\@/" Makefile
perl -i.bak -pe "s/^ifeq \(\\$\(SHARED_PP\),yes\)/ifeq \(\\$\(SHARED_PP\),no\)/" libavcodec/Makefile
perl -i -pe "s/^# LIBS \+= libpostproc\/libpostproc.a ... should be fixed/LIBS \+= libpostproc\/libpostproc.a/" libavcodec/Makefile
perl -i -pe "s/^\tinstall -s -m 755/\t\\$\(STRIP\) \\$\(SLIB\)\n\tinstall -m 755/" libavcodec/Makefile
perl -i -pe "s/\\$\(prefix\)\/lib/\\$\(DESTDIR\)\\$\(prefix\)\/lib/" libavcodec/Makefile
perl -i -pe "s/\\$\(prefix\)\/include\/ffmpeg/\\$\(DESTDIR\)\\$\(prefix\)\/include\/ffmpeg/" libavcodec/Makefile
perl -i.bak -pe "s/^\tinstall -s -m 755/\t\\$\(STRIP\) \\$\(SPPLIB\)\n\tinstall -m 755/" libavcodec/libpostproc/Makefile
perl -i -pe "s/\\$\(prefix\)/\\$\(DESTDIR\)\\$\(prefix\)/" libavcodec/libpostproc/Makefile
perl -i.bak -pe "s/^\tinstall -s -m 755/\t\\$\(STRIP\) \\$\(SLIB\)\n\tinstall -m 755/" libavformat/Makefile
perl -i -pe "s/\\$\(prefix\)\/lib/\\$\(DESTDIR\)\\$\(prefix\)\/lib/" libavformat/Makefile
perl -i -pe "s/\\$\(prefix\)\/include\/ffmpeg/\\$\(DESTDIR\)\\$\(prefix\)\/include\/ffmpeg/" libavformat/Makefile
perl -i.bak -pe "s/\`freetype-config/\`\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/bin\/freetype-config/" vhook/Makefile
```

&nbsp;  
Completely clear previous build (if using a new extracted directory and not the same one as used above, this can be skipped)
```
make distclean
```

&nbsp;  
Configure source and patch ```config.mak``` to reference correct ``ar``, ```ranlib```, and ```strip``` commands.
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --enable-mp3lame --enable-faad --enable-a52 --enable-pp --enable-gpl --enable-pthreads --enable-shared --enable-shared-pp --cc=mipsEEel-linux-gcc --cpu=mipsEEel
perl -i.bak -pe "s/^AR=ar/AR=mipsEEel-linux-ar/" config.mak
perl -i -pe "s/^RANLIB=ranlib/RANLIB=mipsEEel-linux-ranlib/" config.mak
perl -i -pe "s/^STRIP=strip/STRIP=mipsEEel-linux-strip/" config.mak
```

&nbsp;  
Build source
```bash
make lib
make all
make -C libavcodec/libpostproc
```

&nbsp;  
Install to current directory, then create installation archive.
```bash
rm -rf usr
make DESTDIR=`pwd` install
make DESTDIR=`pwd` installlib
make DESTDIR=`pwd` -C libavcodec/libpostproc install
tar czf ffmpeg-20040520.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer **ffmpeg-20040520.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/ffmpeg-20040520.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

