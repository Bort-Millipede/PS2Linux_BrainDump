# LIVE555 (2004.04.23)

[Source link](http://download.videolan.org/pub/videolan/vlc/0.7.2/contrib/live.2004.04.23.tar.gz)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Building/Installing for Cross-Compiling Environment

Extract source archive and rename source directory.
```bash
tar xzf live.2004.04.23.tar.gz
mv live live_crosspc
cd live
```

&nbsp;  
Patch and generate Linux build files.
```bash
perl -i.bak -pe "s/cc/mipsEEel-linux-gcc/" config.linux
perl -i -pe "s/c\+\+/mipsEEel-linux-g\+\+/" config.linux
perl -i -pe "s/ld/mipsEEel-linux-ld/" config.linux
./genMakefiles linux
```

&nbsp;  
Build source.
```bash
make
```

&nbsp;  
Install to cross-compiling environment (as root).
```bash
mkdir /usr/mipsEEel-linux/mipsEEel-linux/usr/lib/live
cp -rf * /usr/mipsEEel-linux/mipsEEel-linux/usr/lib/live/.
cd /usr/mipsEEel-linux/mipsEEel-linux/usr/include/
ln -s ../lib/live/BasicUsageEnvironment/include/* .
ln -s ../lib/live/groupsock/include/* .
ln -s ../lib/live/liveMedia/include/* .
ln -s ../lib/live/UsageEnvironment/include/* .
```

## Building for PS2 Linux

Re-extract source archive. Do NOT use the same extracted directory as was used above.
```bash
tar xzf live.2004.04.23.tar.gz
cd live
```

&nbsp;  
Patch and generate Linux build files.
```bash
perl -i.bak -pe "s/cc/mipsEEel-linux-gcc/" config.linux
perl -i -pe "s/c\+\+/mipsEEel-linux-g\+\+/" config.linux
perl -i -pe "s/ld/mipsEEel-linux-ld/" config.linux
./genMakefiles linux
```

&nbsp;  
Build source.
```bash
make
```

&nbsp;  
Install to current directory, then create installation archive.
```bash
rm -rf usr
rm -rf /tmp/usr/local/lib/live
mkdir -p /tmp/usr/local/lib/live
cp -rf * /tmp/usr/local/lib/live/.
mv /tmp/usr .
mkdir -p usr/local/include
cd usr/local/include
ln -s ../lib/live/BasicUsageEnvironment/include/* .
ln -s ../lib/live/groupsock/include/* .
ln -s ../lib/live/liveMedia/include/* .
ln -s ../lib/live/UsageEnvironment/include/* .
cd ../../..
tar czf live.2004.04.23.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Transfer **live.2004.04.23.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/live.2004.04.23.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

