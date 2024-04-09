# mpg123 0.66

[Source link](https://src.rrz.uni-hamburg.de/files/src/mpg123/mpg123-0.66.tar.gz)
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Building

Extract archive
```bash
tar xzf mpg123-0.66.tar.gz
cd mpg123-0.66
```

&nbsp;  
Set necessary environment variables
```bash
export PREFIX=/usr/local
```

&nbsp;
Configure and build source.
```bash
./configure --host=mipsEEel-linux --prefix=$PREFIX --with-optimization=3 --with-audio=oss
make
```

&nbsp;  
Install to current directory and create installation archive
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf mpg123-0.66.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

```bash
cd /
tar xzf /path/to/mpg123-0.66.mipsEEel-linux.tar.gz
```

