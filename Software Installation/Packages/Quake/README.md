# Quake

**Note:** Precompiled Binaries ([nuq-current.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/nuq-current.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)! Consult [Installing on PS2 Linux (as root)](#installing-on-ps2-linux-as-root) and [Usage Notes](#usage-notes) for installation and usage instructions.

[Source link](https://web.archive.org/web/20050626135551/http://quakeforge.net/files/nuq-current.tar.gz) (available under GPL v2)  
[Game Data files link](https://web.archive.org/web/20020604062310/www.quakeforge.net/files/quake-shareware-1.06.tar.gz)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## References

* [http://www.geocities.jp/ps2linux_net/SDL/nuq.html](https://web.archive.org/web/20181105102815/http://www.geocities.jp/ps2linux_net/SDL/nuq.html)

## Dependencies

[SDL/SDL_net](../SDL)

## Building for PS2 Linux

Extract source archive
```bash
tar xzf nuq-current.tar.gz
cd nuq
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
export SDL_CONFIG=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin/sdl-config
```

&nbsp;  
Modify ```bootstrap``` script to explicitly use automake-1.4 and to copy files
```bash
perl -i.bak -pe "s/aclocal/aclocal-1.4/" bootstrap
perl -i -pe "s/automake/automake-1.4 -c/" bootstrap
```

&nbsp;  
Execute ```bootstrap``` script, then modify autoconf files to include mipsEEel-linux host.
```bash
./bootstrap
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
```

&nbsp;  
Configure source. Notes about passed options:  
* ```--with-clients=sdl```: Configure Quake to use SDL.
* ```--with-sharepath=$PREFIX/games/nuq```: Quake game data files will be installed to /usr/local/games/nuq.
```bash
./configure --host=mipsEEel-linux --prefix=$PREFIX --x-includes=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include --x-libraries=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib --with-clients=sdl --with-sharepath=$PREFIX/games/nuq
```

&nbsp;  
Modify build files to use updated command-line options.
```bash
for f in `grep -rlE "\-malign-(loop|jump|function)s" *`; do perl -i -pe "s/-malign-loops/-falign-loops/" "$f"; perl -i -pe "s/-malign-jumps/-falign-jumps/" "$f"; perl -i -pe "s/-malign-functions/-falign-functions/" "$f"; done
```

&nbsp;
Build source.
```bash
make
```

&nbsp;  
Install to current directory, then create installation archive.
```bash
make DESTDIR=`pwd` install
tar czf nuq-current.mipsEEel-linux.tar.gz usr
```

### (RECOMMENDED) Post-Build Cleanup

Unset build-related environment variables, in case other software are conducted subsequently in the same shell session
```bash
unset PREFIX
unset SDL_CONFIG
unset CONFIG_SUB
```

## Installing on PS2 Linux (as root)

Transfer **nuq-current.mipsEEel-linux.tar.gz** and **quake-shareware-1.06.tar.gz** to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/nuq-current.mipsEEel-linux.tar.gz
cd /tmp
tar xzf /path/to/quake-shareware-1.06.tar.gz
mkdir -p /usr/local/games/nuq
cp -r quake-shareware-1.06/id1 /usr/local/games/nuq
```

&nbsp;  
Set permanent **quake** bash alias for current non-root user by placing the following alias in user's ```.bashrc``` file.
```bash
alias quake='nuq-sdl -noudp'
```

## Usage Notes

Unfortunately, for unspecified reasons the sound does not work in-game. Additionally, Quake may not work with the 2.4.17_mvl21 kernel. This is likely due to the requirement that SDL and SDL_net be built/linked against the 2.4.17_mvl21 kernel, which is not entirely realistic for PS2 Linux.

Quake should be launched from a console session (NOT an X session) using the ```quake``` command (set via alias earlier).

