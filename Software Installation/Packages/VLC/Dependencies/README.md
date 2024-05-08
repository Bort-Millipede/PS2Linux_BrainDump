# VLC Dependencies

**Note:** Some (or all) of software packages listed below likely have uses outside of being leveraged by VLC. However, the author only used the below items for getting VLC working with various media formats. As such, these are only described here in the context of being leveraged as VLC dependencies.

**Build types:**  
* All except libcdio and vcdimager: cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)
* libcdio and vcdimager: native (directly on PS2 Linux)
  * These packages will need to be built on PS2 Linux and installed on PS2 Linux, as well as built on PS2 Linux and installed onto the cross-compiling environment. Additionally, libcdio will need to be built before vcdimager and rebuilt after vcdimager in order to enable VCD functionality in libcdio.

## Recommendations

Per the author's experience getting VLC working, the dependencies described here should be built and installed in exactly the following order:  
* [libdvbpsi3](libdvbpsi3)
* [mpeg2dec](mpeg2dec)
* [a52dec](a52dec)
* [FAAD2](FAAD2)
* [LAME](LAME)
* [FFmpeg](FFmpeg)
* [libMAD](libMAD)
* [LIVE555](LIVE555)
* [libxml2](libxml2)
* [libdvdread](libdvdread)
* [libdvdplay](libdvdplay)
* [libdvdcss](libdvdcss)
* [libdvdnav](libdvdnav)
* [libcdio](libcdio)
* [vcdimager](vcdimager)
* [libcdio](vcdimager) (rebuilt to enable VCD functionality from vcdimager)

