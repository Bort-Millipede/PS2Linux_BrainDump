# VLC Dependencies

**Build types:**  
* All except libcdio and vcdimager: cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)
* libcdio and vcdimager: native (directly on PS2 Linux)
  * These packages will need to be built on PS2 Linux and installed on PS2 Linux, as well as built on PS2 Linux and installed onto the cross-compiling environment. Additionally, libcdio will need to be built before vcdimager and rebuilt after vcdimager in order to enable VCD functionality in libcdio.

## Recommendations

Per the author's experience getting VLC working, the dependencies described here should be built and installed in the following order:  
* libdvbpsi3
* mpeg2dec
* a52dec
* faad2
* lame
* ffmpeg
* libmad
* live
* libxml2
* libdvdread
* libdvdplay
* libdvdcss
* libdvdnav
* libcdio
* vcdimager

