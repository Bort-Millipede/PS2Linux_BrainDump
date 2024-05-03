# libcdio 0.71

[Source link](https://ftp.gnu.org/gnu/libcdio/libcdio-0.71.tar.gz)  
**Build type:** native (directly on PS2 Linux)

## Preliminary Considerations

The primary reason for incorporating libcdio in to VLC is to support VCDs and possibly other physical CD/DVD formats.

libcdio cannot seem to be cross-compiled, so it must be built directly on PS2 Linux. However, it still needs to be built once in a manner so that it can be subsequently installed to the cross-compiling environment. Additionally, the software actually needs to be built twice (once without vcdimager, and once including vcdimager) per platform (cross-compiling environment and PS2 Linux). Therefore in actuality, libcdio needs to be built a total of 4 times.

Because libcdio is being built to enable features in VLC that require the use of a USB optical drive, the software needs to be built against kernel 2.2.19 (recommended) or kernel 2.4.17_mvl21. As such, the ```/usr/src/linux``` symbolic link must be recreated to reference one of teh following:
* ```2.4.17_ps2```: 2.4.17_mvl21 from Broadband Navigator 0.30, for Beta Release 1; or 2.4.17_mvl21 from Broadband Navigator 0.31 and 0.32, for Release 1.0
* ```2.2.19_ps2```: 2.2.19 kernel from Broadband Navigator 0.10

## Dependencies:

* [Popt](../../../Popt)
* [pkg-config](../../../pkg-config)
* [Libtool](../../../Libtool)
* [Autoconf](../../../Autoconf)
* [Automake (1.6.3 or 1.5)](../../../Automake)

## Building for Cross-Compiling Environment (Without vcdimager)

Extract source archive.
```bash
tar xzf libcdio-0.71.tar.gz
cd libcdio-0.71
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
```

&nbsp;  
Configure source. Notes about passed options:
* ```--disable-cddb```: Disable cd information internet lookups
* ```--disable-rpath```: Do not hardcode runtime library paths
```bash
./configure --prefix=$PREFIX --enable-shared --disable-cddb --disable-rpath
```

&nbsp;  
Build source.
```bash
make
```

&nbsp;  
Install to current directory and create installation archive for cross-compiling environment.
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf libcdio-0.71-nolibvcd.mipsEEel-linux.cross-pc.tar.gz usr
```

## Installing on Cross-Compiling Environment (Without vcdimager; as root)

Transfer **libcdio-0.71-nolibvcd.mipsEEel-linux.cross-pc.tar.gz** archive to system with ```mipsEEel-linux-*``` toolchain installed, and install.
```
cd /
tar xzf /path/to/libcdio-0.71-nolibvcd.mipsEEel-linux.cross-pc.tar.gz
```

## Building/Installing for PS2 Linux

Extract source archive. (if using the same extracted directory as above, this should be skipped)
```bash
tar xzf libcdio-0.71.tar.gz
cd libcdio-0.71
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
```

&nbsp;  
Completely clear previous build (if using a new extracted directory and not the same one as used above, this can be skipped)
```bash
make distclean
```

&nbsp;  
Configure source. Notes about passed options:
* ```--disable-cddb```: Disable cd information internet lookups
* ```--disable-rpath```: Do not hardcode runtime library paths
```bash
./configure --prefix=$PREFIX --enable-shared --disable-cddb --disable-rpath
```

&nbsp;  
Build source.
```bash
make
```

&nbsp;  
Install to current directory and create installation archive (for easy installation onto future PS2 Linux installs).
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf libcdio-0.71-nolibvcd.mipsEEel-linux.tar.gz usr
```

&nbsp;  
Install to PS2 Linux (as root or via sudo)
```bash
make install
/sbin/ldconfig
```


