# VLC Dependencies

**Note:** Some (or all) of software packages listed below likely have uses outside of being leveraged by VLC. However, the author only used the below items for getting VLC working with various media formats. As such, these are only described here in the context of being leveraged as VLC dependencies.

## Precompiled Binaries

Precompiled Binaries are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)!
* [a52dec-0.7.4.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/a52dec-0.7.4.mipsEEel-linux.tar.gz)
* [faad2-2.0.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/faad2-2.0.mipsEEel-linux.tar.gz)
* [ffmpeg-20040520.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/ffmpeg-20040520.mipsEEel-linux.tar.gz)
* [lame-3.96.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/lame-3.96.mipsEEel-linux.tar.gz)
* [libcdio-0.71.mipsEEel-linux.beta.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/libcdio-0.71.mipsEEel-linux.beta.tar.gz) for Beta Release 1; [libcdio-0.71.mipsEEel-linux.release.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/libcdio-0.71.mipsEEel-linux.release.tar.gz) for Release 1.0
* [libdvbpsi3-0.1.4.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/libdvbpsi3-0.1.4.mipsEEel-linux.tar.gz)
* [libdvdcss-1.2.8.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/libdvdcss-1.2.8.mipsEEel-linux.tar.gz)
* [libdvdnav-0.1.10.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/libdvdnav-0.1.10.mipsEEel-linux.tar.gz)
* [libdvdplay-1.0.1.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/libdvdplay-1.0.1.mipsEEel-linux.tar.gz)
* [libdvdread-20030812.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/libdvdread-20030812.mipsEEel-linux.tar.gz)
* [libmad-0.15.1b.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/libmad-0.15.1b.mipsEEel-linux.tar.gz)
* [libxml2-2.6.4.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/libxml2-2.6.4.mipsEEel-linux.tar.gz)
* [live.2004.04.23.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/live.2004.04.23.mipsEEel-linux.tar.gz)
* [mpeg2dec-0.4.0.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/mpeg2dec-0.4.0.mipsEEel-linux.tar.gz)
* [vcdimager-0.7.21.mipsEEel-linux.beta.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/vcdimager-0.7.21.mipsEEel-linux.beta.tar.gz) for Beta Release 1; [vcdimager-0.7.21.mipsEEel-linux.release.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/vcdimager-0.7.21.mipsEEel-linux.release.tar.gz) for Release 1.0



## Building

**Build types:**  
* All except libcdio and vcdimager: cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)
* libcdio and vcdimager: native (directly on PS2 Linux)
  * These packages will need to be built on PS2 Linux and installed on PS2 Linux, as well as built on PS2 Linux and installed onto the cross-compiling environment. Additionally, libcdio will need to be built before vcdimager and rebuilt after vcdimager in order to enable VCD functionality in libcdio.

### Recommendations

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

