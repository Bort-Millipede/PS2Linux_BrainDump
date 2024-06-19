# Linux Kernels

## Available Kernels

* [2.2.1_ps2-6](2.2.1_ps2-6) (for PS2 Linux Beta Release 1)
* [2.2.1_ps2-7](2.2.1_ps2-7) (for PS2 Linux Release 1.0)
* [2.2.19_ps2-5](2.2.19_ps2-5) (for PS2 Linux Beta Release 1 and PS2 Linux Release 1.0)
* [2.4.17_ps2-22](2.4.17_ps2-22) (for PS2 Linux Beta Release 1)
* [2.4.17_ps2-26](2.4.17_ps2-26) (for PS2 Linux Release 1.0)

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

