# PS2 Linux Tips and Tricks

A vast amount of tips and tricks beyond the scope of this repository can be found [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/faq.html).

## General Tips

Using a dedicated Memory Card for PS2 Linux is recommended. This will allow multiple kernels and the initfs.gz ramdisk to be installed to the Memory Card, all without being concerned about remaining storage space.

Although the root password is set during installation of PS2 Linux, the author recommends resetting this password via ```passwd``` (as root or via sudo) after installation. This is because the installer appears to store the root password via a shorter (and likely weaker) hashing algorithm. Resetting the password to the same value here is fine, as the password will now be stored using the better hashing algorithm.

When performing command-line operations on PS2 Linux, the author recommends performing these via SSH as much as possible. Operations requiring GUI elements should be performed via the USB keyboard and mouse plugged into the Playstaton 2 console.

For connecting to PS2 Linux via SSH from a Windows system, the author recommends using [BitVise](https://www.bitvise.com/ssh-client-download).

Although the VGA adapter only officially supports sync-on-green monitors, modern monitors with VGA inputs MAY work with the VGA adapter. The following monitor has been used successfully with PS2 Linux and the VGA adapter by the author:  
* [ASUS VS247H](https://www.asus.com/us/commercial-monitors/vs247hp/)

### X Windows

It is highly recommended that the mouse wheel be enabled for X Windows. Accomplishing this is outlined [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/download/mozilla-ps2/ps2mousewheel.html).

The command for starting X Windows displayed over an NTSC connection is: ```startx -- -screen 0 NTSC```

The screen resolution used by the X Server seems to only be customizable (via edits made to the ```/etc/X11/XGSConfig``` file, under the "Screen" section) for VGA output. The screen resolution used for NTSC and PAL outputs appears to be hardcoded and is very low.

PS2 Linux ships with various window managers besides the default Window Maker. These can be configured using the ```sdr``` command.

## Specific Tips and Tricks

* [Soft-Rebooting PS2 Linux with akmem](AKMem)
* Backing Up and Restoring PS2 Linux
* [PC-DC Server for Sega Dreamcast](PC-DC&#32;Server)

