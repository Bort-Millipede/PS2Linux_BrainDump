# Scripts

The following scripts were written entirely the author and should support both PS2 Linux Beta Release 1 and PS2 Linux Release 1.0.

## [kernel-switch](kernel-switch)

This script installs the requested kernel version (2.2.1, 2.2.19, or 2.4.17_mvl21) to the memory card. The script also performs the necessary system configurations on PS2 Linux to ensure that the requested kernel version can be used without issue. Lastly, the script will display the current kernel and system configuration information in use.

To install a kernel to the memory card, the script requires that the ```vmlinux``` file for the requested kernel be installed to the ```/boot``` directory. The script dynamically detects what kernel ```vmlinux``` files are available in ```/boot``` for installation. Kernels are installed to the memory card using gzip compression by default, but can also be installed without any compression.

This script does NOT install kernel modules: this must be done manually by the user.

It is recommended that the script be installed to the ```/usr/local/sbin``` directory (as root or via sudo):
```bash
cp /path/to/kernel-switch /usr/local/sbin/kernel-switch
chmod 755 /usr/local/sbin/kernel-switch
```

### Usage Examples

```
$ sudo /usr/local/sbin/kernel-switch

Usage: /usr/local/sbin/kernel-switch [OPTIONS] [KERNEL_VERSION]

Options:
-t: Check links/config files and print which Kernel is currently configured (does not require a KERNEL_VERSION argument)
-c: Configure system for requested Kernel, but do not install Kernel on Memory Card 0
-k: Install Kernel file on Memory Card 0, but do not configure system for installed kernel
-r: Install requested Kernel without gzip compression
-s: Do not set newly-installed Kernel as default boot option

KERNEL_VERSION values:
2.2.1: Kernel 2.2.1
2.2.19: Kernel 2.2.19
2.4.17: Kernel 2.4.17_mvl21
2.4.17_mvl21: Kernel 2.4.17_mvl21

Running PS2 Linux Version: Beta Release 1
Running Kernel: 2.2.1
Kernel(s) installed in /boot: 2.2.1, 2.2.19, 2.4.17_mvl21
Kernel(s) installed on memory card: 2.2.1 (gzipped), 2.2.19 (gzipped), 2.4.17_mvl21 (gzipped)
```  
*kernel-switch displaying available options and system information*

&nbsp;  
```
$ sudo /usr/local/sbin/kernel-switch -t

Checking current system configuration
Default boot entry (in p2lboot.opt): 2.2.1
/usr/src/linux link: 2.2.1 Kernel (set to linux-2.2.1_ps2)
/dev/mouse link: Set to usbmouse (recommended)
/dev/usbmouse link: 2.2.1 Kernel (set to usbmouse0)
/etc/modules.conf file: 2.2.1 Kernel

To check Kernel files installed in /boot and on Memory Card 0, execute /usr/local/sbin/kernel-switch without arguments
```  
*kernel-switch displaying current system configuration*

## [load-usb-modules](load-usb-modules)

This script loads the necessary kernel modules required for using certain USB devices with PS2 Linux. The following device types are supported:
* USB Zip Drives
* USB Floppy Drives
* USB Flash Drives
* USB CD-ROM Drives
* USB 56K Modems

**NOTE:** These devices must be properly setup first: [USB Floppy/Zip Drives](../USB&#32;Devices/Floppy-Zip&#32;Drives); [USB Optical Drives](../USB&#32;Devices/Optical&#32;Drives); [USB Modems](../USB&#32;Devices/Modems)

### Usage Examples

```
$ sudo load-usb-modules
Usage: /usr/local/sbin/load-usb-modules DEVICE

DEVICE values:
zip: USB Zip Drives
floppy: USB Floppy Drives
flash: USB Flash Drives
cdrom: USB CD-ROM Drives
modem: USB 56K Modems
```
*load-usb-modules displaying usage information*


