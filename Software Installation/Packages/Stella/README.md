# Stella 1.2

**Note:** Precompiled Binaries ([stella-ps2-1.2.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/stella-ps2-1.2.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)! Consult [Installing on PS2 Linux](#installing-on-ps2-linux) and [Usage Notes](#usage-notes) for installation and usage instructions.

Source links:
* [stella-1.2-src.tar.gz](http://ps2linux.no-ip.info/playstation2-linux.com/download/stella-ps2/stella-1.2-src.tar.gz) (available under GPL v2)
* [stella-ps2-1.2-src.tar.gz](http://ps2linux.no-ip.info/playstation2-linux.com/download/stella-ps2/stella-ps2-1.2-src.tar.gz)

[stella.pro file](http://ps2linux.no-ip.info/playstation2-linux.com/download/stella-ps2/.stella.pro)

## References

* [Stella (Atari 2600 emulator) for PS2](http://ps2linux.no-ip.info/playstation2-linux.com/projects/stella-ps2.html)

## Preliminary Notes

Per the instructions below:
* The Stella files (minus the main executable) will be placed in the ```/usr/local/games/stella``` directory.
* Atari 2600 ROMs should be placed in the ```/usr/local/games/roms/2600``` directory.

## Building for PS2 Linux

Extract source archives.
```bash
tar xzf stella-1.2-src.tar.gz
tar xzf stella-ps2-1.2-src.tar.gz
cd stella-1.2/src/build/
```

&nbsp;  
Modify source so that Stella can be launched from any directory.
```bash
perl -i.bak -pe "s/background.bmp/\/usr\/local\/games\/stella\/background.bmp/" ../../src/ui/ps2/mainPS2.cxx
perl -i -pe "s/courier8.bmp/\/usr\/local\/games\/stella\/courier8.bmp/" ../../src/ui/ps2/mainPS2.cxx
```

&nbsp;  
Modify Makefile to reference cross-compiled ```sdl-config```.
```bash
perl -i.bak -pe "s/\`sdl-config/\`\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/bin\/sdl-config/" makefile
```

&nbsp;  
Build source.
```bash
make OPTIMIZATIONS="-O3" CC=mipsEEel-linux-gcc CXX=mipsEEel-linux-g++ LD=mipsEEel-linux-g++
```

&nbsp;  
Create installation archive.
```bash
mkdir -p usr/local/games/stella
mkdir -p usr/local/games/roms/2600
mkdir -p usr/local/bin
cp stella.ps2 usr/local/bin/.
cp background.bmp courier8.bmp usr/local/games/stella/.
tar czf stella-ps2-1.2.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux

Transfer **stella-ps2-1.2.mipsEEel-linux.tar.gz** archive and **.stella.pro** file to PS2 Linux.

&nbsp;  
Install Stella (as root)
```bash
cd /
tar xzf /path/to/stella-ps2-1.2.mipsEEel-linux.tar.gz
```

&nbsp;  
Install hidden **.stella.pro** file to home directory of current non-root user.
```bash
cp /path/to/.stella.pro /path/to/user/home/.stella.pro
```

&nbsp;  
Set permanent **stella** bash alias for current non-root user by placing the following alias in user's .bashrc file.
```
alias stella='pushd /usr/local/games/roms/2600; stella.ps2; popd'
```

&nbsp;  
Place Atari 2600 ROMs in ```/usr/local/games/roms/2600``` directory.

## Usage Notes

Stella only displays via the PS2 VGA cable, NOT via the normal A/V cable.

