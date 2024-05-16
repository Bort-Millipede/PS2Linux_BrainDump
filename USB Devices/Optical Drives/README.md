# USB Optical Drives

While the PS2's built-in DVD-ROM drive is available for use within PS2 Linux, the drive itself is locked down to only allow reading of Playstation 2 formatted CDs and DVDs. Reading discs of other types is strictly forbidden. Using USB CD-ROM/DVD-ROM Optical Drives with PS2 Linux provides functionality for reading CDs and DVDs of all formats. If USB CD-RW/DVD-RW drives are used, this also provides an avenue for burning CDs and DVDs from PS2 Linux.

## References

* [http://www.geocities.jp/ps2linux_net/usb/caravelle.html](https://web.archive.org/web/20181105102758/http://www.geocities.jp/ps2linux_net/usb/caravelle.html)

## Kernel Configuration

USB optical drives only work under the 2.2.19 and 2.4.17_mvl21 kernels (see below about kernel 2.2.1). For all kernel versions, the following options need to be enabled as modules (with *M*):
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

The above options are available in kernel 2.2.1. However, the ```SCSI CD-ROM support``` option is VERY UNSTABLE. In the author's experience: plugging in a USB optical drive completely freezes PS2 Linux, which then necessitates a hard reboot. Therefore, using USB optical drives with kernel 2.2.1 is not recommended.

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

Before plugging in the device, the following linux kernel modules need to be loaded (as root or via sudo) within PS2 Linux:  
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

The device can then be plugged in. From here, PS2 Linux should recognize the device correctly. USB optical drives usually show up as ```/dev/scd0``` devices (viewing the output of the ```dmesg``` command should confirm this). The drive itself can usually be ejected (as root or via sudo) via the following command:
```bash
eject /dev/scd0
```

## Specific Devices Tested

* [Kingwin EZ-Connect USI-2535 (USB 2.0 to IDE/SATA Adapter)](http://www.kingwin.com/adapters/usi-2535-2/) and [Pioneer DVR-111D (IDE DVD-RW Drive)](https://www.pioneerelectronics.com/PUSA/Computer/Computer+Drives/DVR-111D) used together

## Usage Examples

![](USB_DVD-RW.png?raw=true)  
*USB DVD-RW Drive recognized by PS2 Linux under Kernel 2.2.19*

![](ubuntu_livedvd_mounted.png?raw=true)  
*Ubuntu LiveDVD inserted into USB DVD-RW Drive and mounted in PS2 Linux*

