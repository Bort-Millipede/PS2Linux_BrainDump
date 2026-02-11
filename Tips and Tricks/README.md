# PS2 Linux Tips and Tricks

A vast amount of tips and tricks beyond the scope of this repository can be found [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/faq.html).

## Hardware-Specific Tips

**Dedicated PS2 Memory Card:** PS2 Linux requires a memory card for storing the kernel(s). If using an official 8MB memory card, the author recommends using a dedicated memory card just for PS2 Linux. This is because PS2 Linux will rapidly use up all space on the memory card (for kernels, ramdisks, etc.).

**USB Keyboard and Mouse:** The official Playstation 2 Keyboard (SCPH-10240) and Mouse (SCPH-10230) are not required to use PS2 Linux. However, the author recommends obtaining an official Playstation 2 Keyboard if possible, as the device contains an onboard USB port for a USB mouse. This leaves one USB port on the Playstation 2 console free for use with other devices (such as those described [HERE](../USB&#32;Devices)).

## Install-Specific Tips

It is recommended that all packages available in the PS2 Linux installer be installed, which will ultimately provide the most possible functionality of PS2 Linux from the start. This is accomplished by selecting "Install Custom System" and selecting all available packages during installation.

It is recommended the entire harddrive installed in the Playstation 2 console NOT be used for PS2 Linux. At the least, this will allow a backup partition to be created for easier [backing up and restoring of a PS2 Linux installation](Backup-Restore).

## Recommended Items To Be Completed Immediately After Installation

**Ethernet Driver Update:** If the ethernet connection on PS2 Linux is very unstable and drops very easily, the likely issue is the buggy stock SMAP (ethernet) driver. An updated driver that fixes these issues is available [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/projects/ps2linux.html), with directions for installation available [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/project/shownotesaca2.html?release_id=68). In the author's experience, this is more likely to be experienced with newer Playstation 2 consoles used in conjunction with the official Linux Kit network adapter (SCPH-10350, ethernet only), whereas using the official Playstation 2 Network adapter (SCPH-10281, ethernet and dial-up) does not appear to exhibit the behavior.

**Enable USB Mouse Wheel:** The scrolling wheel on USB mouse devices is disabled in PS2 Linux by default. The procedure for enabling the wheel for X Windows sessions is [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/download/mozilla-ps2/ps2mousewheel.html).

**Kernel Source Installation:** Numerous procedures outlined in this repository require the 2.2.19 Kernel source and/or the 2.4.17_mvl21 Kernel source to be installed on PS2 Linux. Installing these is outlined [HERE](../Software&#32;Installation/Packages/Kernel&#32;Source).

**RPM Upgrade:** The required packages needed for the upgrade can be found [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/projects/apt.html). The actual upgrade procedure is [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/download/apt/rpm-upgrade.pdf), with some revisions being outlined in bug reports [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/bug/apt.html).

**Create Backup Partition:** If PS2 Linux was not installed using the full PS2 HDD (hopefully not), the author recommends creating a 5GB backup partition for backing up files.

**Create Full Backup of PS2 Linux installation:** A full backup of the PS2 Linux installation should be created. This backup can be leveraged at a later time to restore a working PS2 Linux installation without the need to re-run the original PS2 Linux installer. A procedure to accomplish this is outlined in this repository [HERE](Backup-Restore).

## General Tips

Using a dedicated Memory Card for PS2 Linux is recommended. This will allow multiple kernels and the initfs.gz ramdisk to be installed to the Memory Card, all without being concerned about remaining storage space.

When performing command-line operations on PS2 Linux, the author recommends performing these via SSH as much as possible. Operations requiring GUI elements should be performed via the USB keyboard and mouse plugged into the Playstation 2 console. For connecting to PS2 Linux via SSH from a Windows system, the author recommends using [BitVise](https://www.bitvise.com/ssh-client-download).

Although the VGA adapter only officially supports sync-on-green monitors, modern monitors with VGA inputs MAY work with the VGA adapter. The following monitor has been successfully used by the author with PS2 Linux and the VGA adapter:  
* [ASUS VS247H](https://www.asus.com/us/commercial-monitors/vs247hp/)

To use system audio from commands/processes executed as non-root users, permissions for the default ```/dev/dsp``` sound device may need to be set to world-readable and world-writable (as root or via sudo):
```bash
chmod 666 /dev/dsp
```

### Root Password

Although the root password is set during installation of PS2 Linux, the author recommends resetting this password via ```passwd``` (as root or via sudo) after installation. This is because the installer appears to store the root password via a shorter (and likely weaker) hashing algorithm. Resetting the password to the same value here is fine, as the password will now be stored using the better hashing algorithm.

Alternatively, the root password can be removed altogether (thereby preventing logging into the root account with a password altogether) by editing the ```/etc/shadow``` file and replacing the password hash with the ```*``` character.

### X Windows

It is highly recommended that the mouse wheel be enabled for X Windows. Accomplishing this is outlined [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/download/mozilla-ps2/ps2mousewheel.html).

The command for starting X Windows and displaying it over an NTSC connection is:
```bash
startx -- -screen 0 NTSC
```

&nbsp;  
The screen resolution used by the X Server seems to only be customizable (via edits made to the ```/etc/X11/XGSConfig``` file, under the "Screen" section) for VGA output. The screen resolution used for NTSC and PAL outputs appears to be hardcoded and is very low quality.

PS2 Linux ships with various window managers besides the default Window Maker. These can be configured using the ```sdr``` command.

### APA Partitioning

PS2 Linux Beta Release 1 uses legacy APA partitioning (proprietary partitioning format used by Playstation 2 and other Sony devices) by default. Because of this, PS2 Linux Beta Release 1 can be installed alongside other Playstation 2 data residing on the HDD relatively easily. [Broadband Navigator](https://en.wikipedia.org/wiki/PlayStation_Broadband_Navigator) uses a newer rendition of APA partitioning not supported by PS2 Linux Beta Release 1 by default, but the Linux kernel(s) used by PS2 Linux can be patched (covered in this repository) to support having both PS2 Linux Beta Release 1 and Broadband Navigator installed on the same HDD.

PS2 Linux Release 1.0 partitions the HDD like a normal Linux drive, and the included 2.2.1 Kernel does not support APA partitions by default. As such, PS2 Linux Release 1.0 cannot be installed alongside other Playstation 2 data on the HDD in its default setup. However, APA partitioning support can be added to the 2.2.1 Kernel (covered in this repository), which allows PS2 Linux Release 1.0 to be installed alongside other Playstation 2 data on the same HDD.

The tutorial for converting a default PS2 Linux Release 1.0 installation to an installation installed on an APA-partitioned HDD is covered [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/download/apa/apa_2.2.1.html).

## Specific Tips and Tricks

* [Soft-Rebooting PS2 Linux with AKMem](AKMem)
* [Backing Up and Restoring PS2 Linux](Backup-Restore)
* [PC-DC Server for Sega Dreamcast](PC-DC&#32;Server)

