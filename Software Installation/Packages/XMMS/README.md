# XMMS (X Multimedia System) 1.2.7

[Source link](https://web.archive.org/web/20070802011520/http://www.xmms.org/files/1.2.x/xmms-1.2.7.tar.bz2)  
**Build type:** native (directly on PS2 Linux)

## Preliminary Considerations

Another option for getting XMMS on PS2 Linux is to use the prebuilt XMMS binary packages [available on this page](http://ps2linux.no-ip.info/playstation2-linux.com/projects/cfyc.html).

## Building/Installing on PS2 Linux

Extract source archive.
```bash
tar xIf xmms-1.2.7.tar.bz2
cd xmms-1.2.7
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
```

&nbsp;  
Configure source. Notes about passed options:  
* ```--without-vorbis``` and ```--without-ogg```: Build XMMS without Vorbis and Ogg support. If this is needed, these options can be omitted. However, the required shared libraries will need to be built/installed first (not covered here or anywhere else in this repository).
* ```--disable-*test```: Skip building and executing test programs.
```bash
./configure --prefix=$PREFIX --host=mips-unknown-linux-gnu --without-vorbis --without-ogg --disable-glibtest --disable-gtktest --disable-libxmltest --disable-esdtest --disable-libmikmodtest --disable-vorbistest --with-gnome --with-x
```

&nbsp;  
Build source.
```bash
make
```

&nbsp;  
Install to current directory and create installation archive (for easy installation onto future PS2 Linux installs).
```bash
make DESTDIR=`pwd` install
tar czf xmms-1.2.7.mipsEEel-linux.tar.gz usr/
```

&nbsp;  
Install to PS2 Linux (as root or via sudo).
```bash
make install
```

