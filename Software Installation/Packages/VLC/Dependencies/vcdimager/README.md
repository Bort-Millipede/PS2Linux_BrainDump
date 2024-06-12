# vcdimager 0.7.21

[Source link](https://ftp.gnu.org/gnu/vcdimager/vcdimager-0.7.21.tar.gz)  
**Build type:** native (directly on PS2 Linux)

## Preliminary Considerations

The primary reason for incorporating vcdimager into VLC is to support VCDs.

vcdimager cannot seem to be cross-compiled, so it must be built directly on PS2 Linux. However, it still needs to be built once in a manner so that it can be subsequently installed to the cross-compiling environment.

Because vcdimager is being built to enable features in VLC that require the use of a USB optical drive, the software should be built against kernel 2.2.19 (recommended) or kernel 2.4.17_mvl21. It can be built against kernel 2.2.1, but this is not recommended. As such, the ```/usr/src/linux``` symbolic link must be recreated to reference one of the following:
* ```2.4.17_ps2```: 2.4.17_mvl21 from Broadband Navigator 0.30, for Beta Release 1; or 2.4.17_mvl21 from Broadband Navigator 0.31 and 0.32, for Release 1.0
* ```2.2.19_ps2```: 2.2.19 kernel from Broadband Navigator 0.10

## Dependencies

* [Popt](../../../Popt)
* [pkg-config](../../../pkg-config)
* [Libtool](../../../Libtool)
* [Autoconf](../../../Autoconf)
* [Automake (1.6.3 or 1.5)](../../../Automake)
* [libxml2](../libxml2)
* [2.2.19 and/or 2.4.17_mvl21 Kernel Source](../../../Kernel&#32;Source)
* [libcdio](../libcdio)

## Building for Cross-Compiling Environment

Extract source archive.
```bash
tar xzf vcdimager-0.7.21.tar.gz
cd vcdimager-0.7.21
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
```

&nbsp;  
Configure source. Notes about passed options:
* ```--without-cli-frontend```: Building with CLI frontend always seems to fail, so disabling this frontend as it is not required for VLC.
```bash
./configure --prefix=$PREFIX --enable-shared --without-cli-frontend
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
tar czf vcdimager-0.7.21.mipsEEel-linux.cross-pc.tar.gz usr
```

## Installing on Cross-Compiling Environment (as root)

Transfer **vcdimager-0.7.21.mipsEEel-linux.cross-pc.tar.gz** archive to system with ```mipsEEel-linux-*``` toolchain installed, and install.
```bash
cd /
tar xzf /path/to/vcdimager-0.7.21.mipsEEel-linux.cross-pc.tar.gz usr
```

## Building/Installing for PS2 Linux

Extract source archive. (if using the same extracted directory as above, this should be skipped)
```bash
tar xzf vcdimager-0.7.21.tar.gz
cd vcdimager-0.7.21
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
* ```--without-cli-frontend```: Building with CLI frontend always seems to fail, so disabling this frontend as it is not required for VLC.
```bash
./configure --prefix=$PREFIX --enable-shared --without-cli-frontend
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
tar czf vcdimager-0.7.21.mipsEEel-linux.tar.gz usr
```

&nbsp;  
Install to PS2 Linux (as root or via sudo)
```bash
make install
/sbin/ldconfig
```

