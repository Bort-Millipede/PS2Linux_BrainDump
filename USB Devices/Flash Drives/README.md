# USB Flash Drives

Using USB Floppy or Zip drives with PS2 Linux provides another avenue for file transfers to/from PS2 Linux

## Kernel Configuration

USB flash drives only reliably work under the 2.2.19 and 2.4.17_mvl21 kernels. Results are inconsistent on the 2.2.1 kernel, and therefore this kernel should not be relied upon for using these types of devices. For the supported kernel versions, the following options need to be enabled as modules (with *M*):
* ```SCSI support``` -> ```SCSI disk support```
* ```USB support``` -> ```USB Mass Storage support```

These can be set by invoking the ```make menuconfig``` command in the kernel source directory and navigating to the appropriate menus.

![](../2.2.19-sd_mod.png?raw=true)  
![](../2.2.19_usb-storage.png?raw=true)  
*Enabling necessary options as modules in Kernel 2.2.19*

![](../2.4.17-sd_mod.png?raw=true)  
![](../2.4.17_usb-storage.png?raw=true)  
*Enabling necessary options as modules in Kernel 2.4.17*

## Using Flash Drives in PS2 Linux

The author recommends using smaller capacity flash drives if available. Additionally, older flash drives seem to work better with PS2 Linux.

Before plugging in the device, the following linux kernel modules need to be loaded (as root or via sudo) within PS2 Linux:  
* sd_mod
* usb-storage
```bash
/sbin/insmod sd_mod
/sbin/insmod usb-storage
```

The above modules can also be automatically loaded using the [load-usb-modules script](../../Scripts/load-usb-modules) (as root or via sudo) as follows:
```bash
load-usb-modules flash
```

From here, PS2 Linux should recognize the device(s) correctly. These devices show up as ```/dev/sdX``` devices and can (as root or via sudo) be mounted as normal disks via ```mount```. The disks themselves can (as root or via sudo) be partitioned with ```fdisk``` and formatted with ```mkdosfs```. However, it is highly recommended that any partitioning/formatting be performed on a Windows-based system instead, as the most ideal format to be used for flash drives is FAT32.

## Specific Devices Tested

* [Ativa 2GB AU32048](https://www.officedepot.com/a/products/564177/Ativa-USB-20-FlipTop-Flash-Drive/)

## Usage Examples

![](USB_flash_2.2.19.png?raw=true)  
![](flash_fdisk.png?raw=true)  
*USB Flash Drive by PS2 Linux under Kernel 2.2.19, and flash drive partition listed via fdisk*

