# Abuse

[Source link](https://web.archive.org/web/20011218172815/http://www.labyrinth.net.au/~trandor/abuse/files/abuse_sdl-0.5.0.tar.gz)  
[Abuse data files link](https://web.archive.org/web/20011218172815/http://www.labyrinth.net.au/~trandor/abuse/files/abuse_datafiles.tar.gz)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## References

* [http://www.geocities.jp/ps2linux_net/SDL/abuse.html](https://web.archive.org/web/20181105102815/http://www.geocities.jp/ps2linux_net/SDL/abuse.html)

## Prerequisites

### Dependencies

[SDL/SDL_net](../SDL)

## Building for PS2 Linux

Extract archive
```bash
tar xzf abuse_sdl-0.5.0.tar.gz
cd abuse_sdl-0.5.0
```

&nbsp;  
Set necessary environment variables
```bash
export PREFIX=/usr/local
export SDL_CONFIG=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin/sdl-config
```

&nbsp;  
Modify autoconf files to include mipsEEel-linux host, and modify Makefile.in files to execute ```automake``` and copy missing files
```
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
for f in `find . -name Makefile.in`; do perl -i.bak -pe "s/\\$\(AUTOMAKE\) --gnu/\\$\(AUTOMAKE\) -a -c --gnu/" "$f"; done
```

&nbsp;  
Recreate cross-compiling ```linux``` symbolic link to reference 2.2.1 kernel source directory (as root).
```bash
rm /usr/mipsEEel-linux/mipsEEel-linux/usr/src/linux
ln -s linux-2.2.1_ps2 /usr/mipsEEel-linux/mipsEEel-linux/usr/src/linux
```

&nbsp;  
Configure and build source against 2.2.1 kernel.
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux --x-includes=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include --x-libraries=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib
make
```

&nbsp;  
Install 2.2.1 kernel-linked binary to current directory.
```bash
make DESTDIR=`pwd` install
mv usr/local/bin/abuse.sdl usr/local/bin/abuse-2.2.1.sdl
```

&nbsp;  
Recreate cross-compiling ```linux``` symbolic link to reference 2.2.19 kernel source directory (as root).
```bash
rm /usr/mipsEEel-linux/mipsEEel-linux/usr/src/linux
ln -s linux-2.2.19_ps2 /usr/mipsEEel-linux/mipsEEel-linux/usr/src/linux
```

&nbsp;  
Clear earlier build, the configure and build source against 2.2.19 kernel.
```bash
make distclean
./configure --prefix=$PREFIX --host=mipsEEel-linux --x-includes=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include --x-libraries=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib
make
```

&nbsp;  
Install 2.2.19 kernel-linked binary to current directory.
```bash
make DESTDIR=`pwd` install
mv usr/local/bin/abuse.sdl usr/local/bin/abuse-2.2.19.sdl
```

&nbsp;  
Recreate cross-compiling ```linux``` symbolic link to reference 2.4.17_mvl21 kernel source directory (as root).
```bash
rm /usr/mipsEEel-linux/mipsEEel-linux/usr/src/linux
ln -s linux-2.4.17_ps2 /usr/mipsEEel-linux/mipsEEel-linux/usr/src/linux
```

&nbsp;  
Clear earlier build, the configure and build source against 2.4.17_mvl21 kernel.
```bash
make distclean
./configure --prefix=$PREFIX --host=mipsEEel-linux --x-includes=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include --x-libraries=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib
make
```

&nbsp;  
Install 2.4.17_mvl21 kernel-linked binary to current directory, then create installation archive.
```bash
make DESTDIR=`pwd` install
mv usr/local/bin/abuse.sdl usr/local/bin/abuse-2.4.17.sdl
tar czf abuse_sdl-0.5.0.mipsEEel-linux.tar.gz usr
```

### (RECOMMENDED) Post-Build Cleanup

Recreate cross-compiling ```linux``` symbolic link to reference 2.2.1 kernel source directory (as root).
```bash
rm /usr/mipsEEel-linux/mipsEEel-linux/usr/src/linux
ln -s linux-2.2.1_ps2 /usr/mipsEEel-linux/mipsEEel-linux/usr/src/linux
```

## Installing on PS2 Linux (as root)

Transfer **abuse_sdl-0.5.0.mipsEEel-linux.tar.gz** and **abuse_datafiles.tar.gz** archives to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/abuse_sdl-0.5.0.mipsEEel-linux.tar.gz
mkdir -p /usr/local/games/abuse
cd /usr/local/games/abuse
tar xzf /path/to/abuse_datafiles.tar.gz
```

&nbsp;  
Transfer **[abuse](abuse)** helper script to PS2 Linux and install to /usr/local/bin. This will allow Abuse to be launched by any user from any directory.
```
cp /path/to/abuse /usr/local/bin
chmod 755 /usr/local/bin/abuse
chown root.root /usr/local/bin/abuse
```

## Usage Notes

Abuse does not work with the 2.4.17_mvl21 kernel. This is likely due to the requirement that SDL and SDL_net be built/linked against the 2.4.17_mvl21 kernel, which is not entirely realistic for PS2 Linux.

Additionally, Abuse requires that the ```/dev/usbmouse``` symbolic link reference the correct usbmouse file. This link can be automatically recreated via the [kernel-switch](../../../Scripts/FIXME) script or manually recreated (kernel 2.2.1 should reference ```usbmouse0```; kernel 2.2.19 should reference ```usbmouse0-2.2.19```)

