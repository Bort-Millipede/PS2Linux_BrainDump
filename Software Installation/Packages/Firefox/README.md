# Firefox 0.8

[Source link](https://ftp.mozilla.org/pub/firefox/releases/0.8/firefox-source-0.8.tar.bz2)  

**Build types:**
* Without SSL/TLS support: cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)
* With SSL/TLS support: native (directly on PS2 Linux)

## References

* **Mozilla for PlayStation 2 Cross Compiling Mini-HOWTO**
  * Local backup [here](moz_cross_1.0.1.html) or rendered [here](https://html-preview.github.io/?url=https://github.com/Bort-Millipede/PS2Linux_BrainDump/blob/main/Software%20Installation/Toolchain/moz_cross_1.0.1.html)
  * [Backup site](http://ps2linux.no-ip.info/playstation2-linux.com/download/mozilla-ps2/moz_cross_1.0.1.html)

## Preliminary Considerations

Successfully building Firefox for PS2 Linux can be a very complicated task and can take very long time (especially if building with SSL/TLS support enabled, which requires building directly on PS2 Linux). Luckily, prebuilt Firefox binary packages (including new versions than what is described here, as well as various configurations) are [available on this page](https://ps2linux.no-ip.info/playstation2-linux.com/projects/mozilla-ps2.html).

### Dependencies

* [FreeType](../FreeType)

## Building for PS2 Linux

### Without SSL/TLS Support (cross-compiling)

Save [mozconfig file with SSL/TLS disabled](mozconfig-nossl) to home directory of current user as ```.mozconfig```

Extract source archive.
```bash
tar xjf firefox-source-0.8.tar.bz2
cd mozilla
```

&nbsp;  
Configure and build source. The ```configure``` script will automatically parse the ```.mozconfig``` file saved to the user's home directory.
```bash
./configure
make
```

&nbsp;  
Install to current directory and create installation archive.
```bash
rm -rf usr
make DESTDIR=`pwd` install
ln -s mozilla usr/local/bin/firefox
tar czf firefox-0.8-nossl.mipsEEel-linux.tar.gz usr
```

### With SSL/TLS Support (on PS2 Linux)

**IMPORTANT NOTE:** It is HIGHLY recommended that the commands below be executed in a local session directly on PS2 Linux, and NOT within an SSH remote session. This is because the build below will take a VERY long time to complete, and all progress will be lost if the SSH session disconnects prematurely.

Save [mozconfig file with SSL/TLS enabled](mozconfig-ssl) to home directory of current user as ```.mozconfig```

Extract source archive.
```bash
tar xjf firefox-source-0.8.tar.bz2
cd mozilla
```

&nbsp;  
Configure and build source. The ```configure``` script will automatically parse the ```.mozconfig``` file saved to the user's home directory. This will take a VERY Long time to complete.
```bash
./configure
make
```

&nbsp;  
Install to current directory and create installation archive (for easy installation onto future PS2 Linux installs).
```bash
rm -rf usr
make DESTDIR=`pwd` install
tar czf firefox-0.8.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

### Without SSL/TLS Support

Transfer **firefox-0.8-nossl.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/firefox-0.8-nossl.mipsEEel-linux.tar.gz
```

### With SSL/TLS Support

#### From Source

Execute from the earlier source directory:
```bash
make install
```

#### From Installation Archive

Transfer **firefox-0.8.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/firefox-0.8.mipsEEel-linux.tar.gz
```

## Usage Notes

The actual command for launching firefox is ```mozilla```. This command must be executed from within an X session.

