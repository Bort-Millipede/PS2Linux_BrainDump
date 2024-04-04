# pkg-config 0.12.0

[Source link](https://pkgconfig.freedesktop.org/releases/pkgconfig-0.12.0.tar.gz)  
Build type: native (directly on PS2 Linux)

## Building

Extract archive:
```bash
tar xzf pkgconfig-0.12.0.tar.gz
cd pkgconfig-0.12.0
```

Set necessary environment variables
```bash
export PREFIX=/usr/local
```

Configure and build source
```bash
./configure --prefix=$PREFIX --enable-shared
make
```

Install to current directory and create installation archive (for easy installation onto future installs)
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf pkgconfig-0.12.0.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

From ***pkgconfig-0.12.0*** build directory:
```bash
make install
```

