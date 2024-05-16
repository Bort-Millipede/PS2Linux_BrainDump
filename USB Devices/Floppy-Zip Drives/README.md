# USB Floppy and Zip Drives

Using USB Floppy or Zip drives with PS2 Linux provides another avenue for file transfers to/from PS2 Linux, similar to how a USB flash drive would function.

USB Floppy and USB Zip drives are recognized by PS2 Linux as the same device type. Therefore, the information provided on this page is interchangable for both device types.

## References

* [http://www.geocities.jp/ps2linux_net/usb/zip250.html](https://web.archive.org/web/20181105102808/http://www.geocities.jp/ps2linux_net/usb/zip250.html)

## Kernel Configuration

USB Floppy and Zip drives work with all available Linux Kernels (2.2.1, 2.2.19, 2.4.17_mvl21). For all kernel versions, the following options need to be enabled as modules (with *M*):
* ```SCSI support``` -> ```SCSI disk support```
* ```USB support``` -> ```USB Mass Storage support```

These can be set by invoking the ```make menuconfig``` command in the kernel source directory and navigating to the appropriate menus.

![](../2.2.1-sd_mod.png?raw=true)  
![](../2.2.1_usb-storage.png?raw=true)  
*Enabling necessary options as modules in Kernel 2.2.1*

![](../2.2.19-sd_mod.png?raw=true)  
![](../2.2.19_usb-storage.png?raw=true)  
*Enabling necessary options as modules in Kernel 2.2.19*

![](../2.4.17-sd_mod.png?raw=true)  
![](../2.4.17_usb-storage.png?raw=true)  
*Enabling necessary options as modules in Kernel 2.4.17*

## Using Floppy and Zip Drives in PS2 Linux

Before plugging in the device, the following linux kernel modules need to be loaded (as root or via sudo) within PS2 Linux:  
* sd_mod
* usb-storage
```bash
/sbin/insmod sd_mod
/sbin/insmod usb-storage
```

The above modules can also be automatically loaded using the [load-usb-modules script](../../Scripts/load-usb-modules) (as root or via sudo) as follows:
* floppy drives
```bash
load-usb-modules floppy
```
* zip drives
```bash
load-usb-modules zip
```

&nbsp;  
From here, PS2 Linux should recognize the device(s) correctly. These devices show up as ```/dev/sdX``` devices and can (as root or via sudo) be mounted as normal disks via ```mount```. The disks themselves can (as root or via sudo) be partitioned with ```fdisk``` and formatted with ```mkdosfs```. However, it is highly recommended that any partitioning/formatting be performed on a Windows-based system instead, as the most ideal formats to be used for floppy and zip disks are FAT or FAT32.

The drives themselves can also usually be ejected (as root or via sudo) via the following command (with ```sdX``` replaced with the correct device):
```bash
eject /dev/sdX
```

## Specific Devices Tested

* Floppy Drive: [VST FDUSB-M](https://www.amazon.com/External-Floppy-1-44MB-FDUSB-M-V1/dp/B00U5Z8A48)
* Zip Drive: [iOmega Z100USB](https://www.amazon.com/iOmega-Portable-External-Z100USB-V1/dp/B00V24ZL0C)

## Usage Examples

![](USB_floppy.png?raw=true)  
![](floppy_fdisk.png?raw=true)  
*USB Floppy Drive recognized by PS2 Linux under Kernel 2.2.1, and floppy disk partition listed via fdisk*

![](USB_zip.png?raw=true)  
![](zip_fdisk.png?raw=true)  
*USB Zip Drive recognized by PS2 Linux under Kernel 2.2.1, and zip disk partition listed via fdisk*

