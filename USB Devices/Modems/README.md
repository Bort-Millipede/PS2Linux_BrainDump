# USB Dial-Up Modems

**NOTE:** This page does NOT describe (nor does anywhere else in this repository) how to get internet connectivity for PS2 Linux via dial-up networking. This was not something that was tested by the author, as getting these USB devices working in PS2 Linux mostly served other purposes.

## Kernel Configuration

**NOTE:** In the 2.2.1 kernel that ships with PS2 Linux Beta Release 1, the necessary kernel module outlined below actually comes pre-installed.

USB dial-up modems work with all available Linux Kernels (2.2.1, 2.2.19, 2.4.17_mvl21). For all kernel versions, the following option needs to be enabled as a module (with *M*):
* ```USB support``` -> ```USB Modem (CDC ACM) support```

This can be set by invoking the ```make menuconfig``` command in the kernel source directory and navigating to the appropriate menu.

![](2.2.1_acm.png?raw=true)  
*Enabling necessary option as module in Kernel 2.2.1*

![](2.2.19_acm.png?raw=true)  
*Enabling necessary option as module in Kernel 2.2.19*

![](2.4.17_acm.png?raw=true)  
*Enabling necessary option as module in Kernel 2.4.17_mvl21*

## Using USB Optical Drives in PS2 Linux

Before plugging in the device, the ```acm``` linux kernel module needs to be loaded (as root or via sudo) within PS2 Linux:  
```bash
/sbin/insmod acm
```

The device can then be plugged in. From here, PS2 Linux should recognize the device correctly. USB modems should show up as the ```/dev/ttyACMX``` device (viewing the output of the ```dmesg``` command should confirm this).

## Specific Devices Tested

* [Conexant RD02-D400](https://www.amazon.com/Conexant-RD02-D400-External-Modem-NW147/dp/B006P3IWV0)

## Usage Examples

![](USB_modem_dmesg_2.2.1.png?raw=true)  
*dmesg output on Kernel 2.2.1 displaying USB dial-up modem recognized as device ttyACM0*

