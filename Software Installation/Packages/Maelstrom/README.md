# Maelstrom 3.0.6

[Source link](https://web.archive.org/web/20030803041759/http://www.devolution.com/~slouken/Maelstrom/src/Maelstrom-3.0.6.tar.gz)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## References

* [http://www.geocities.jp/ps2linux_net/SDL/Maelstrom.html](https://web.archive.org/web/20181105102814/http://www.geocities.jp/ps2linux_net/SDL/Maelstrom.html)

## Prerequisites

### Dependencies

[SDL/SDL_net](../SDL)

## Building for PS2 Linux

Extract source archive
```bash
tar xzf Maelstrom-3.0.6.tar.gz
cd Maelstrom-3.0.6
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
export SDL_CONFIG=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin/sdl-config
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
./configure --host=mipsEEel-linux --prefix=$PREFIX
make
```

&nbsp;  
Install to current directory, then create installation archive.
```bash
make DESTDIR=`pwd` install-exec-am
make DESTDIR=`pwd` install-data-am
make install_gamedata target=`pwd`${PREFIX}/games/Maelstrom
tar czf Maelstrom-3.0.6.mipsEEel-linux.tar.gz usr
```

### (RECOMMENDED) Post-Build Cleanup

Unset build-related environment variables, in case other software are conducted subsequently in the same shell session
```bash
unset PREFIX
unset SDL_CONFIG
```

## Installing Maelstrom on PS2 Linux (as root)

Transfer **Maelstrom-3.0.6.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/Maelstrom-3.0.6.mipsEEel-linux.tar.gz
```

&nbsp;  
Transfer **[maelstrom](maelstrom)** helper script to PS2 Linux and install to /usr/local/bin. This will allow Maelstrom to be launched by any user from any directory.
```
cp /path/to/maelstrom /usr/local/bin/maelstrom
chmod 755 /usr/local/bin/maelstrom
chown root.root /usr/local/bin/maelstrom
```

