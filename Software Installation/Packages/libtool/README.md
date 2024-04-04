# libtool 1.4.2

[Source link](https://ftp.gnu.org/gnu/libtool/libtool-1.4.2.tar.gz)  
Build type: cross-compiling (on system with mipsEEel-linux-* toolchain installed)

## Building

Extract archive
```bash
tar xzf libtool-1.4.2.tar.gz
cd libtool-1.4.2
```

Set necessary environment variables
```bash
export PREFIX=/usr/local
export CC=mipsEEel-linux-gcc
export NM=mipsEEel-linux-nm
export LD=mipsEEel-linux-ld
export CXX=mipsEEel-linux-c++
export RANLIB=mipsEEel-linux-ranlib
export AR=mipsEEel-linux-ar
export AS=mipsEEel-linux-as
export OBJDUMP=mipsEEel-linux-objdump
export STRIP=mipsEEel-linux-strip
```

Run bootstrap script and modify autoconf files to include mipsEEel-linux host
```bash
./bootstrap
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-* /" "$f"; done
```

Configure and build source. Create *libtool* symbolic link to prevent build failure
```bash
./configure --prefix=$PREFIX --host=mipsEEel-linux
ln -s ../libtool libltdl/libtool
make
```

Install to current directory and create installation archive
```bash
make DESTDIR=`pwd` install
tar czf libtool-1.4.2.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer *libtool-1.4.2.mipsEEel-linux.tar.gz* archive to PS2 Linux and install
```bash
cd /
tar xzf /path/to/libtool-1.4.2.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

