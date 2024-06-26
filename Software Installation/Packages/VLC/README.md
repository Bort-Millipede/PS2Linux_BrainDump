# VLC 0.7.2

![](VLC_version.png?raw=true)

Source links:  
* 0.7.2: [http://download.videolan.org/pub/videolan/vlc/0.7.2/vlc-0.7.2.tar.gz](http://download.videolan.org/pub/videolan/vlc/0.7.2/vlc-0.7.2.tar.gz)
* 0.8.0 (required for working VCD player): [http://download.videolan.org/pub/videolan/vlc/0.8.0/vlc-0.8.0.tar.gz](http://download.videolan.org/pub/videolan/vlc/0.8.0/vlc-0.8.0.tar.gz)

**Build type (VLC only, not dependencies):** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## References

[http://www.videolan.org/vlc/download-sources.html (Archived page from 8/3/2004)](https://web.archive.org/web/20040803125519/http://www.videolan.org/vlc/download-sources.html)

## Preliminary Considerations

Getting VLC built and working on PS2 Linux can be a very long and complicated process. VLC is heavily dependent upon shared libraries (plugins) to provide support for different media formats. As such, there are many dependencies that need to be built and installed (both to the cross-compiling environment and to PS2 Linux) before VLC can be successfully built and installed to PS2 Linux in a useful functional way. This involves building software in the cross-compiling environment as well as natively on PS2 Linux.

If following this page and all subpages exactly, the build of VLC that will be installed onto PS2 Linux SHOULD (no promises) be able to handle the following media formats:  
* MP3
* A52/AC3
* MP4
* AAC
* RTSP
* Audio CD (read below)
* VCD (read below)
* DVD (read below)

### Audio CDs, VCDs, and DVDs

For these players to be used, the built-in PS2 DVD-ROM drive will not work (due to the "locked down" state of the drive in PS2 Linux). Therefore, a [USB optical drive](../../../USB&#32;Devices/Optical&#32;Drives) will be required. These devices only work under the 2.2.19 and 2.4.17_mvl21 kernels with the necessary kernel modules loaded (as root or via sudo): 
```bash
/sbin/insmod cdrom
/sbin/insmod sd_mod
/sbin/insmod sr_mod
/sbin/insmod usb-storage
```

**NOTE:** The ```cdrom``` module is usually built into Kernel 2.4.17_mvl21 by default, and therefore most likely does not need to be loaded. However, executing the ```/sbin/insmod cdrom``` command anyway will not have any negative effect.

Beyond this, the author's results with each format are as follows (your results may vary!):  
* **Audio CDs**: VLC on PS2 Linux will play these, but if using digital audio (piped through USB) then before long the audio will start to lag/skip. Audio CDs can also be played and outputted through the Analog audio port and/or the headphone jack located on the USB optical drive. However, getting this working may require custom cables and additional troubleshooting, none of which is currently covered anywhere in this repository.
* **VCDs**: Overall, VLC on PS2 Linux appears to handle these fairly well. However, VLC does appear to have issues identifying some discs as VCDs for unknown reasons.
* **DVDs**: Despite best efforts, playing DVDs with VLC on PS2 Linux hardly works. Decryption of most DVDs seems to fail almost immediately. For those that can be decrypted and played, the sound does not seem to work. Finally, the picture will load and a few frames will be displayed, but then VLC seems to mostly lock up after this until either the stop button is pressed or a Segmentation Fault occurs (necessitating that the process be forcefully terminated). Overall, this functionality should be considered a novelty.

### Dependencies

* General:
  * [SDL/SDL_net](../SDL) (Installed to cross-compiling environment and PS2 Linux)
  * [Popt](../Popt) (Installed to cross-compiling environment and PS2 Linux)
  * [FreeType](../FreeType) (Installed to cross-compiling environment and PS2 Linux)
  * [pkg-config](../pkg-config) (Installed to PS2 Linux)
  * [libtool 1.4.2](../Libtool) (Installed to PS2 Linux)
  * [autoconf 2.53](../Autoconf) (Installed to PS2 Linux)
  * [automake (1.6.3 or 1.5)](../Automake) (Installed to PS2 Linux)
* [VLC-specific](Dependencies):
  * [libdvbpsi3](Dependencies/libdvbpsi3)
  * [mpeg2dec](Dependencies/mpeg2dec)
  * [a52dec](Dependencies/a52dec)
  * [FAAD2](Dependencies/FAAD2)
  * [LAME](Dependencies/LAME)
  * [FFmpeg](Dependencies/FFmpeg)
  * [libMAD](Dependencies/libMAD)
  * [LIVE555](Dependencies/LIVE555)
  * [libxml2](Dependencies/libxml2)
  * [libdvdread](Dependencies/libdvdread)
  * [libdvdplay](Dependencies/libdvdplay)
  * [libdvdcss](Dependencies/libdvdcss)
  * [libdvdnav](Dependencies/libdvdnav)
  * [libcdio](Dependencies/libcdio)
  * [vcdimager](Dependencies/vcdimager)

Refer to [this page](Dependencies) for recommendations on the exact order in which all VLC-specific dependencies should be built and installed.

## Building for PS2 Linux

Extract source archives and backport VCDX driver from VLC 0.8.0 into VLC 0.7.2.
```bash
tar xzf vlc-0.7.2.tar.gz
tar xzf vlc-0.8.0.tar.gz
cd vlc-0.7.2/modules/access/vcdx
rm -rf *
cp -rf ../../../../vlc-0.8.0/modules/access/vcdx/* .
cd ../../..
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
export GNOME_CONFIG=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin/gnome-config
export ESD_CONFIG=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin/esd-config
export PKG_CONFIG_PATH=/usr/mipsEEel-linux/mipsEEel-linux/usr/lib/pkgconfig
```

&nbsp;  
Execute ```bootstrap``` script, then modify autoconf files to include mipsEEel-linux host.
```bash
./bootstrap
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-\* /" "$f"; done
```

&nbsp;  
Configure source. Notes about passed options:  
* ```--with-*-config-path```: Reference correct ```*-config``` scripts to ensure VLC is cross-compiled against correct headers/libraries.
* ```--disable-ogg```/```--disable-vorbis```: Build VLC without Vorbis and Ogg support. If this is needed, these options can be omitted. However, the required shared libraries will need to be built/installed first (not covered here or anywhere else in this repository: refer to References link).
* ```--disable-mkv```: Build VLC without Matroska support. If this is needed, these options can be omitted. However, the required shared libraries will need to be built/installed first (not covered here or anywhere else in this repository: refer to References link(s)).
* ```--disable-arts```: The "Analog Realtime Synthesizer" is not available for PS2 Linux by default, so this needs to be disabled in VLC.
* ```--disable-skins```/```--disable-skins2```/```--disable-wxwindows```: Disable Skins and wxWindows interfaces, as issues were encountered attempting to build these.
```bash
./configure --host=mipsEEel-linux --prefix=$PREFIX --x-includes=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/include --x-libraries=/usr/mipsEEel-linux/mipsEEel-linux/usr/X11R6/lib --with-freetype-config-path=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin --with-xml2-config-path=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin --with-gtk-config-path=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin --with-orbit-config-path=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin --with-sdl-config-path=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin --with-dvdnav-config-path=/usr/mipsEEel-linux/mipsEEel-linux/usr/bin --enable-gnome --enable-sdl --enable-gtk --enable-release --enable-shared --disable-libcddb --disable-ogg --disable-vorbis --disable-mkv --disable-arts --disable-skins --disable-skins2 --disable-wxwindows
```

&nbsp;  
Modify Makefiles to prevent "Not matching architecture" errors while building SDL interface modules.
```bash
perl -i.bak -pe "s/\\$\(VLC_CONFIG\) --libs plugin aout_sdl/\\$\(VLC_CONFIG\) --libs plugin aout_sdl | perl -pe \"s~L\/usr\/local\/lib~L\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/lib~\"/g" modules/audio_output/Makefile
perl -i.bak -pe "s/\\$\(VLC_CONFIG\) --libs plugin vout_sdl/\\$\(VLC_CONFIG\) --libs plugin vout_sdl | perl -pe \"s~L\/usr\/local\/lib~L\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/lib~\"/g" modules/video_output/Makefile
```

&nbsp;  
Build source.
```bash
make
```

&nbsp;  
Install to current directory.
```bash
rm -rf usr
make DESTDIR=`pwd` install
```

&nbsp;  
Modify generated ```vlc-config``` script to reference correct headers/libraries on PS2 Linux.
```bash
perl -i -pe "s/\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/X11R6\/include/\/usr\/X11R6\/include/g" usr/local/bin/vlc-config
perl -i -pe "s/\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/X11R6\/lib/\/usr\/X11R6\/lib/g" usr/local/bin/vlc-config
perl -i -pe "s/cflags=\"\\$\{cflags\} -I\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/include\"/cflags=\"\\$\{cflags\} -I\/usr\/local\/include\"/" usr/local/bin/vlc-config
perl -i -pe "s/-L\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/lib -lcdio/-L\/usr\/local\/lib -lcdio/" usr/local/bin/vlc-config
perl -i -pe "s/-L\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/lib -ldvdnav/-L\/usr\/local\/lib -ldvdnav/" usr/local/bin/vlc-config
perl -i -pe "s/-L\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/lib -lfreetype/-L\/usr\/local\/lib -lfreetype/" usr/local/bin/vlc-config
perl -i -pe "s/-L\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/lib -lvcdinfo/-L\/usr\/local\/lib -lvcdinfo/" usr/local/bin/vlc-config
perl -i -pe "s/\"\\$\{cflags\} -I\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/include -I\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/include\/dvdnav\"/\"\\$\{cflags\} -I\/usr\/local\/include -I\/usr\/local\/include\/dvdnav\"/" usr/local/bin/vlc-config
perl -i -pe "s/\"\\$\{cflags\} -I\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/include -I\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr\/include\/freetype2\"/\"\\$\{cflags\} -I\/usr\/local\/include -I\/usr\/local\/include\/freetype2\"/" usr/local/bin/vlc-config
perl -i -pe "s/\/usr\/mipsEEel-linux\/mipsEEel-linux\/usr/\/usr/g" usr/local/bin/vlc-config
```

&nbsp;  
Create installation archive.
```bash
tar czf vlc-0.7.2.mipsEEel-linux.tar.gz usr
```

## Installing on PS2 Linux (as root)

Ensure that all dependencies listed above have already been installed to PS2 Linux.

Transfer **vlc-0.7.2.mipsEEel-linux.tar.gz** archive to PS2 Linux and install.
```bash
cd /
tar xzf /path/to/vlc-0.7.2.mipsEEel-linux.tar.gz
/sbin/ldconfig
```

## Usage Notes

### Audio CDs, VCDs, and DVDs

These seem to work best under kernel 2.4.17_mvl21. They may work fine under kernel 2.2.19, but in the author's experience there is a much higher likelihood of stability issues. For unknown reasons, VLC seems to work better overall with PS2 Linux Beta Release 1 (example: 2.2.19 kernel seems to work for these media types fine) than with PS2 Linux Release 1.0 (example: 2.2.19 kernel does not seem to work for these media types). Results may vary.

The "Device Name" option will need to be changed to either ```/dev/sr0``` or ```/dev/scd0```. This will instruct VLC to use the USB optical drive, rather than the built-in DVD-ROM drive.

## Usage Examples

![](MP3.png?raw=true)
*VLC playing MP3 file on PS2 Linux*

![](MPG.png?raw=true)
*VLC playing MPEG video file on PS2 Linux*

![](Audio_CD.png?raw=true)
*VLC playing Audio CD on PS2 Linux*

![](VCD.png?raw=true)
*VLC playing Video CD (VCD) on PS2 Linux*

![](DVD_Menu.png?raw=true)
*VLC loading DVD main menu on PS2 Linux*

![](DVD.png?raw=true)
*VLC playing DVD on PS2 Linux*

