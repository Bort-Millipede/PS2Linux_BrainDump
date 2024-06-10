# USB Optical Drives

While the PS2's built-in DVD-ROM drive is available for use within PS2 Linux, the drive itself is locked down to only allow reading of Playstation 2 formatted CDs and DVDs. Reading discs of other types is strictly forbidden. Using USB CD-ROM/DVD-ROM Optical Drives with PS2 Linux provides functionality for reading CDs and DVDs of all formats. If USB CD-RW/DVD-RW drives are used, this also provides an avenue for burning CDs and DVDs from PS2 Linux.

## References

* [http://www.geocities.jp/ps2linux_net/usb/caravelle.html](https://web.archive.org/web/20181105102758/http://www.geocities.jp/ps2linux_net/usb/caravelle.html)
* [https://lists.debian.org/debian-68k/2002/08/msg00033.html](https://lists.debian.org/debian-68k/2002/08/msg00033.html)

## Kernel Configuration

USB optical drives only work under the 2.2.19 and 2.4.17_mvl21 kernels (see below about kernel 2.2.1). For these kernel versions, the following options need to be enabled as modules (with ```M```):
* ```SCSI support``` -> ```SCSI disk support```
* ```SCSI support``` -> ```SCSI CD-ROM support```
* ```USB support``` -> ```USB Mass Storage support```

These can be set by invoking the ```make menuconfig``` command in the kernel source directory and navigating to the appropriate menus.

![](../2.2.19-sd_mod.png?raw=true)  
![](2.2.19-sr_mod.png?raw=true)  
![](../2.2.19_usb-storage.png?raw=true)  
*Enabling necessary options as modules in Kernel 2.2.19*

![](../2.4.17-sd_mod.png?raw=true)  
![](2.4.17-sr_mod.png?raw=true)  
![](../2.4.17_usb-storage.png?raw=true)  
*Enabling necessary options as modules in Kernel 2.4.17*

The above options are available in Kernel 2.2.1. However, the ```SCSI CD-ROM support``` option appears to have some noticeable stability issues. In the author's experience:  
* PS2 Linux Beta Release 1: Plugging in a USB optical drive completely freezes PS2 Linux, which then necessitates a hard reboot.
* PS2 Linux Release 1.0: Some discs can be successfully used (example: audio CDs seem to play fine using kscd, albeit only via the analog audio/headphone jack on the drive itself), but sporadic read errors are common and unpredictable.

For the reasons outlined above, using USB optical drives with Kernel 2.2.1 is not recommended.

### CD-RW/DVD-RW Specific Configuration

To specifically use CD-RW/DVD-RW drives, the following sub-modules of ```USB Mass Storage support``` must be enabled:
* ```USB support``` -> ```USB Mass Storage support``` -> ```Freecom USB/ATAPI Bridge support```
* ```USB support``` -> ```USB Mass Storage support``` -> ```ISD-200 USB/ATA Bridge support```
* ```USB support``` -> ```USB Mass Storage support``` -> ```HP CD-Writer 82xx support```

![](2.4.17_usb-storage_sub-module_freecom.png?raw=true)  
![](2.4.17_usb-storage_sub-module_isd-200.png?raw=true)  
![](2.4.17_usb-storage_sub-module_hp-cdwriter.png?raw=true)  
*Enabling necessary sub-module options for CD-RW/DVD-RW drives in Kernel 2.4.17*

## Using USB Optical Drives in PS2 Linux

It is very important to NOT have the device plugged in when booting PS2 Linux, or before the necessary kernel modules have been loaded. Additionally, it is recommended that the disc not be inserted into the device itself until after the device has been properly loaded in PS2 Linux.

The following Linux kernel modules need to be loaded (as root or via sudo) within PS2 Linux:  
* cdrom (on Kernel 2.4.17_mvl21, this is usually built in to the kernel by default and therefore does not need to be loaded)
* sd_mod
* sr_mod
* usb-storage
```bash
/sbin/insmod cdrom
/sbin/insmod sd_mod
/sbin/insmod sr_mod
/sbin/insmod usb-storage
```

The above modules can also be automatically loaded using the [load-usb-modules script](../../Scripts/load-usb-modules) (as root or via sudo) as follows:
```bash
load-usb-modules cdrom
```

The device can then be plugged in. From here, PS2 Linux should recognize the device correctly. ```dmesg``` output should show the optical drive as device ```sr0```. This file will need to be created with e following command (as root).
```bash
mknod /dev/sr0 b 11 0
```

To avoid access issues later, it is recommended to set the ```/dev/sr0``` device as world-readable and world-writeable. This can be done via the following command (as root or via sudo):
```bash
chmod 666 /dev/sr0
```

It is also recommended to add the current user to the ```disk``` group via the following command (as root or via sudo; replace USERNAME with current user):
```bash
usermod -G disk USERNAME
```

USB optical drives can also often be used via device ```/dev/scd0```, which should already be created. Just as above, it is recommended that the device be set as world-readable and world-writeable via the following command (as root or via sudo):
```bash
chmod 666 /dev/scd0
```

The drive itself can usually be ejected (as root or via sudo) via the following command (replace ```sr0``` with ```scd0``` if using that device):
```bash
eject /dev/sr0
```

## Specific Devices Tested

* [Kingwin EZ-Connect USI-2535 (USB 2.0 to IDE/SATA Adapter)](http://www.kingwin.com/adapters/usi-2535-2/) and [Pioneer DVR-111D (IDE DVD-RW Drive)](https://www.pioneerelectronics.com/PUSA/Computer/Computer+Drives/DVR-111D) used together

## Usage Examples

![](USB_DVD-RW.png?raw=true)  
*USB DVD-RW Drive recognized by PS2 Linux under Kernel 2.2.19*

![](ubuntu_livedvd_mounted.png?raw=true)  
*Ubuntu LiveDVD inserted into USB DVD-RW Drive and mounted in PS2 Linux*

USB Optical drives can be used to play audio CDs using VLC, XMMS, or the pre-installed kscd (```/usr/kde1x/bin/kscd```) application. However, kscd and XMMS only output audio via the analog audio port and/or the headphone jack located on the drive itself. This may require custom cables and additional troubleshooting, none of which is currently covered anywhere in this repository.

