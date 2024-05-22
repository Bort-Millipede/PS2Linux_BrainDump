# PS2 Linux Tips and Tricks

A vast amount of tips and tricks beyond the scope of this repository can be found [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/faq.html).

## Recommended Items To Be Completed Immediately After Installation

**Ethernet Driver Update:** If the ethernet connection on PS2 Linux is very unstable and drops very easily (this is more likely to be experienced with newer Playstation 2 consoles), the likely issue is the buggy stock SMAP (ethernet) driver. An updated driver that fixes these issues is available [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/projects/ps2linux.html), with directions for installation available [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/project/shownotesaca2.html?release_id=68).

**Kernel Source Installation:** Numerous procedures outlined in this repository require the 2.2.19 Kernel source and/or the 2.4.17_mvl21 Kernel source to be installed on PS2 Linux. Installing these is outlined [HERE](../Software&#32;Installation/Packages/Kernel&#32;Source).

**RPM Upgrade:** The required packages needed for the upgrade can be found [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/projects/apt.html). The actual upgrade procedure is [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/download/apt/rpm-upgrade.pdf), with some revisions being outlined in bug reports [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/bug/apt.html).

**Create Backup Partition:** If PS2 Linux was not installed using the full PS2 HD (hopefully not), the author recommends creating a 5GB backup partition for backing up files.

**Create Full Backup of PS2 Linux installation:** A full backup of the PS2 Linux installation should be created. This backup can be leveraged at a later time to restore a working PS2 Linux installation without the need to re-run the original PS2 Linux installer.

## General Tips

Using a dedicated Memory Card for PS2 Linux is recommended. This will allow multiple kernels and the initfs.gz ramdisk to be installed to the Memory Card, all without being concerned about remaining storage space.

When performing command-line operations on PS2 Linux, the author recommends performing these via SSH as much as possible. Operations requiring GUI elements should be performed via the USB keyboard and mouse plugged into the Playstaton 2 console. For connecting to PS2 Linux via SSH from a Windows system, the author recommends using [BitVise](https://www.bitvise.com/ssh-client-download).

Although the root password is set during installation of PS2 Linux, the author recommends resetting this password via ```passwd``` (as root or via sudo) after installation. This is because the installer appears to store the root password via a shorter (and likely weaker) hashing algorithm. Resetting the password to the same value here is fine, as the password will now be stored using the better hashing algorithm.

Although the VGA adapter only officially supports sync-on-green monitors, modern monitors with VGA inputs MAY work with the VGA adapter. The following monitor has been successfully used by the author with PS2 Linux and the VGA adapter:  
* [ASUS VS247H](https://www.asus.com/us/commercial-monitors/vs247hp/)

### X Windows

It is highly recommended that the mouse wheel be enabled for X Windows. Accomplishing this is outlined [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/download/mozilla-ps2/ps2mousewheel.html).

The command for starting X Windows anddisplayed over an NTSC connection is: ```startx -- -screen 0 NTSC```

The screen resolution used by the X Server seems to only be customizable (via edits made to the ```/etc/X11/XGSConfig``` file, under the "Screen" section) for VGA output. The screen resolution used for NTSC and PAL outputs appears to be hardcoded and is very low.

PS2 Linux ships with various window managers besides the default Window Maker. These can be configured using the ```sdr``` command.

## Specific Tips and Tricks

* [Soft-Rebooting PS2 Linux with akmem](AKMem)
* Backing Up and Restoring PS2 Linux
* [PC-DC Server for Sega Dreamcast](PC-DC&#32;Server)

