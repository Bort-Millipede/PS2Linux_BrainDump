# Additional USB Devices

Beyond the standard USB keyboard and mouse devices, other USB devices can be used with PS2 Linux. This often requires additional options to be enabled in the Linux kernel, which necessitates rebuilding the kernel and/or its loadable modules.

## Kernel Configuration

For all devices listed below and for all kernel versions, the ```Prompt for development and/or incomplete code/drivers``` option must be enabled in order to use additional USB devices (this is an option that should probably be enabled anyway). This can be set by invoking the ```make menuconfig``` command in the kernel source directory and navigating to the ```Code maturity level options``` menu.

![](2.2.1_dev_code-drivers.png?raw=true)  
*"Code maturity level options" menu for Kernel 2.2.1*

![](2.2.19_dev_code-drivers.png?raw=true)  
*"Code maturity level options" menu for Kernel 2.2.19*

![](2.4.17_dev_code-drivers.png?raw=true)  
*"Code maturity level options" menu for Kernel 2.4.17_mvl21*

Alternative, This can be enabled from within the ```.config``` file by setting the following value:
```
CONFIG_EXPERIMENTAL=y
```

## Enabling USB Devices

Below is the list of USB devices successfully enabled in PS2 Linux by the author. Information on enabling additional USB devices not covered here can be found [on this page](https://web.archive.org/web/20181105024308/http://www.geocities.jp/ps2linux_net/) or on the [playstation2-linux.com site backup](http://ps2linux.no-ip.info/playstation2-linux.com/).

The instructions for each device type are intended to be generic and support a wide array of devices. However, the author did not perform extensive testing using multiple devices of each type. The actual devices used by the author are clearly indicated in each page. Results may vary.

### Specific Devices

* [Floppy and Zip Drives](Floppy-Zip&#32;Drives)
* [Optical Drives](Optical&#32;Drives)
* [Dial-Up Modems](Modems)

## References

[http://www.geocities.jp/ps2linux_net/](https://web.archive.org/web/20181105024308/http://www.geocities.jp/ps2linux_net/)  
&nbsp;&nbsp;This contains information for using additional USB devices with PS2 Linux.

