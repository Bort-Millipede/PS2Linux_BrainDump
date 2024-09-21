# Linux Kernels

## Available Kernels

* [2.2.1_ps2-6](2.2.1_ps2-6) (for PS2 Linux Beta Release 1)
* [2.2.1_ps2-7](2.2.1_ps2-7) (for PS2 Linux Release 1.0)
* [2.2.19_ps2-5](2.2.19_ps2-5) (for PS2 Linux Beta Release 1 and PS2 Linux Release 1.0)
* [2.4.17_ps2-22](2.4.17_ps2-22) (for PS2 Linux Beta Release 1)
* [2.4.17_ps2-26](2.4.17_ps2-26) (for PS2 Linux Release 1.0)

Other kernel versions (such as 2.2.21-pre1-xr7 and others) are available via the unofficial BlackRhino PS2 Linux distribution (more info [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/projects/blackrhino.html)). However, the author did not explore this mainly due to the reality that the distribution's package manager servers are long gone, and therefore using this distribution in modern times is deemed unrealistic.

Additionally, the source for kernel 2.2.19_ps2-23 can be found on the Playstation Broadband Navigator 0.20 DVD (```kernel-source-2.2.19_ps2-23.mipsel.rpm``` within ```SOURCE.TGZ``` under ```source/kernel```). However, the kernel headers (presumably ```kernel-headers-2.2.19_ps2-23.mipsel.rpm```) are not included on the DVD and are not available anywhere else to the author's knowledge. Therefore, this kernel version cannot be successfully compiled and used with PS2 Linux.

## Tip for New/Updated Kernels

It is highly recommended that kernels be installed to the PS2 Memory Card using compression (specifically GZIP). Because space on Memory Cards is extremely limited (8MB maximum), installing kernels with compression allows multiple kernels to be installed to the Memory Card simultaneously.

In the author's experience, the only noticeable drawback to installing kernels onto the Memory Cards with compression is a very slight increase in initial system boot time:
* When booting an uncompressed kernel from the PS2 Linux DVD, the progress indicator immediately starts counting up to 100%.
* When booting a compressed kernel, the progress indicator stays at 0% for about 5-10 seconds before counting up to 100%.

Instructions for installing both compressed and raw uncompressed kernels are available in the separate kernel pages linked above.

## Switching Between Installed Kernels

Besides simply booting from different kernels in the PS2 Linux Boot menu, certain system configuration changes should be made prior to booting a different kernel version. While switching kernels seems to be possible without performing some (or all) of these configuration changes, they are recommended to prevent certain issues later.

The configuration changes outlined below can be performed automatically using the [kernel-switch](../../Scripts/kernel-switch) script.

### (PS2 Linux Release 1.0 Only) ```/boot/vmlinux``` and ```/boot/System.map``` Links

These symlinks should reference the ```/boot/vmlinux*``` and ```/boot/System.map*``` files, respectively, for the intended kernel to be used. 

### ```/usr/src/linux``` Link

This symlink should reference the kernel source code directory for the intended kernel to be used. This ensures that any software built after booting into the new kernel will be built against the new kernel.

Most likely values the ```/usr/src/linux``` link can be set to (for both PS2 Linux Beta Release 1 and PS2 Linux Release 1.0):  
* ```linux-2.2.1_ps2```: Kernel 2.2.1
* ```linux-2.2.19_ps2```: Kernel 2.2.19
* ```linux-2.4.17_ps2```: Kernel 2.4.17_mvl21

### ```/dev/mouse``` and ```/dev/usbmouse``` Links

The ```/dev/mouse``` link on PS2 Linux appears to always reference the ```/dev/usbmouse``` symlink. Because all available kernels use different devices to reference the USB mouse device, the ```/dev/usbmouse``` symlink must references the correct mouse device.

Most likely values the ```/dev/usbmouse``` link can be set to (for both PS2 Linux Beta Release 1 and PS2 Linux Release 1.0):  
* ```usbmouse0```: Kernel 2.2.1
* ```usbmouse0-2.2.19```: Kernel 2.2.19
* ```input/mice```: Kernel 2.4.17_mvl21

### ```/etc/modules.conf``` File

Just like the ```/dev/usbmouse``` symlink must reference the correct mouse device, the ```/etc/modules.conf``` file must also reference the correct mouse device. Separate entries are needed for each kernel mouse device, and the entries not referencing the correct device should be disabling by prepending them with a ```#``` character.

The entries for each are as follows:

Kernel 2.2.1:
```
alias	char-major-10-32	mousedev
```

&nbsp;  
Kernel 2.2.19:
```
alias	char-major-13-32	mousedev
```

&nbsp;  
Kernel 2.4.17_mvl21:
```
alias	char-major-13-63	mousedev
```

