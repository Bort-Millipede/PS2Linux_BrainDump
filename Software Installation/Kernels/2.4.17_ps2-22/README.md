# Kernel 2.4.17_mvl21 (for PS2 Linux Beta Release 1)

![](2.4.17_beta_login.png?raw=true)

Required files:  
* [kernel-headers-2.4.17_ps2-22.mipsel.rpm](https://web.archive.org/web/20031207191309/http://www.sony.net:80/Products/Linux/Download/PlayStation_BB_Navigator/kernel-headers-2.4.17_ps2-22.mipsel.rpm)
* [kernel-source-2.4.17_ps2-22.mipsel.rpm](https://web.archive.org/web/20031207191309/http://www.sony.net:80/Products/Linux/Download/PlayStation_BB_Navigator/kernel-source-2.4.17_ps2-22.mipsel.rpm)

**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## References

* [http://www.geocities.jp/ps2linux_net/make_install/kernel-2.4.17.html](https://web.archive.org/web/20181105102754/http://www.geocities.jp/ps2linux_net/make_install/kernel-2.4.17.html)
* [http://playstation2-linux.com/download/mozilla-ps2/kernel-2.4.17-mini-howto.html](http://ps2linux.no-ip.info/playstation2-linux.com/download/mozilla-ps2/kernel-2.4.17-mini-howto.html)

## Preliminary Considerations

### Limitations

While this kernel provides many improved functionalities absent from the 2.2.x kernels, not all software that comes pre-installed with PS2 Linux seems to work with this kernel (as the pre-installed software was originally built against the 2.2.1 kernel). Therefore, certain software and features that work seemlessly under 2.2.x kernels does not work under the 2.4.17 kernel.

### Kernel Configuration File

It is recommended that a known-working kernel configuration file be used when building the kernel below. The author's latest kernel configuration file is [available here](config-2.4.17_ps2-22). All appropriate kernel options outlined throughout this repository should be enabled in this configuration file.

## Installing 2.4.17_ps2-22 Kernel Source to Cross-Compiling Environment (as root)

&nbsp;  
Extract RPMs into cross-compiling environment.
```bash
cd /usr/mipsEEel-linux/mipsEEel-linux
rpm2cpio kernel-headers-2.4.17_ps2-22.mipsel.rpm | cpio -ivd
rpm2cpio kernel-source-2.4.17_ps2-22.mipsel.rpm | cpio -ivd
cd usr/src
mv linux-2.4.17_ps2 linux-2.4.17_ps2-22
cd linux-2.4.17_ps2-22
```

&nbsp;  
Modify APA partitioning support: enable support for legacy APA partitions using [this patch](kernel-2.4.17_ps2-22_partitions.patch).
```bash
cd fs/partitions
patch -p1 < /path/to/kernel-2.4.17_ps2-22_partitions.patch
cd ../..
```

&nbsp;  
**If planning on booting PS2 Linux from BB Navigator:**

Edit ```drivers/char/console.c```: Change line 1723 to:
```
//graphics_boot = 1;
```

&nbsp;  
Run ```setup-ps2``` script and modify included kernel configuration file to:
* Enable built-in ext2 filesystem support.
* Enable devpts filesystem support.
* Enable UNIX 98 PTY support.
* Enable PS2 debug log facility.
* Enable built-in SCSI device support.
```bash
./setup-ps2
perl -i -pe "s/CONFIG_EXT2_FS=m/CONFIG_EXT2_FS=y/" .config
perl -i -pe "s/#\ CONFIG_DEVPTS_FS\ is\ not\ set/CONFIG_DEVPTS_FS=y/" .config
perl -i -pe "s/#\ CONFIG_UNIX98_PTYS\ is\ not\ set/CONFIG_UNIX98_PTYS=y/" .config
perl -i -pe "s/#\ CONFIG_PS2_DEBUGLOG\ is\ not\ set/CONFIG_PS2_DEBUGLOG=m/" .config
perl -i -pe "s/CONFIG_SCSI=m/CONFIG_SCSI=y/" .config
```

&nbsp;  
Clear all previous builds and build information
```bash
cp .config config
make mrproper
```

&nbsp;  
Copy included kernel configuration into correct location in kernel source directory.
```bash
cp config .config
```

&nbsp;  
Alternatively: copy usable kernel configuration file (such as [this one](config-2.4.17_ps2-22)) into correct location in kernel source directory.
```bash
cp /path/to/working/kernel/config/file config
cp config .config
```

&nbsp;  
Prepare kernel source directory for building. If prompted by ```make oldconfig``` command to make choices, pressing ENTER will choose the default choice.  
To immediately exit out of ```make menuconfig``` command, press: ESC ESC; then select "No".
```
make oldconfig
make menuconfig
```

## Building for PS2 Linux Beta

The kernel can be built in the directory that was created/prepared above, or it can be built in a separate directory (this is recommended by the author).
* If building in the above directory, building must be done as root.
* If building in a separate directory, building should be done as a non-root user. To create this directory, follow the directions in the previous section but substitute the ```cd /usr/mipsEEel-linux/mipsEEel-linux``` command for a different base directory where the source directory should be created.

&nbsp;  
If needed, reconfigure the kernel (if not needed, this should be skipped).
```bash
make menuconfig
```

&nbsp;  
Build dependencies, then build kernel
```bash
make dep
make
```

&nbsp;  
Build kernel modules
```bash
make modules
```

&nbsp;  
"Install" kernel modules to current system (as root). These will not actually run on the current system.
```bash
make modules_install
```

&nbsp;  
Create installation archive for kernel modules.
```
cd /lib/modules
tar czvf /path/to/new/kernel-modules-2.4.17_ps2-22.tar.gz 2.4.17_mvl21
```

## Installing on PS2 Linux Beta (as root)

Transfer **vmlinux**, **System.map**, and **kernel-modules-2.4.17_ps2-22.tar.gz** files to PS2 Linux.

&nbsp;  
Install kernel modules
```bash
cd /lib/modules
tar xzf /path/to/kernel-modules-2.4.17_ps2-22.tar.gz
```

&nbsp;  
Install kernel files to ```/boot```.
```bash
cp /path/to/vmlinux /boot/vmlinux-2.4.17_mvl21
cp /path/to/System.map /boot/System.map-2.4.17_mvl21
```

&nbsp;  
Install compressed kernel to first Memory Card (recommended).
```bash
mount /mnt/mc00
gzip -9c /path/to/vmlinux > /mnt/mc00/vmlinux-2.4.17_mvl21.gz
chmod 755 /mnt/mc00/vmlinux-2.4.17_mvl21.gz
```

&nbsp;  
Alternatively: install raw uncompressed kernel to first Memory Card.
```bash
mount /mnt/mc00
cp /path/to/vmlinux /mnt/mc00/vmlinux-2.4.17_mvl21
chmod 755 /mnt/mc00/vmlinux-2.4.17_mvl21
```

&nbsp;  
Create new boot entry in ```p2lboot.cnf``` file. **Note:** If a raw uncompressed kernel was installed to the Memory Card, replace ```vmlinux-2.4.17_mvl21.gz``` with ```vmlinux-2.4.17_mvl21``` in the boot entry.  
Add the following entry to the ```/mnt/mc00/p2lboot.cnf``` file:
```
"2.4.17_mvl21"	vmlinux-2.4.17_mvl21.gz ""	203 /dev/hda1 "" 2.4.17_mvl21
```

&nbsp;  
Create node for for USB mouse to be used by Kernel 2.4.17.
```bash
mkdir -p /dev/input
mknod /dev/input/mice c 13 63
```

&nbsp;  
Add a new entry in the ```/etc/modules.conf``` file to correctly load the USB mouse under Kernel 2.4.17_mvl21.  
Add the following entry to the ```/etc/modules.conf``` file:
```
alias	char-major-13-63	mousedev
```

&nbsp;  
(Recommended) With the exception of the entry above, diable all ```mousedev``` entries by prepending them with ```#``` characters.

&nbsp;  
Recreate the ```/dev/usbmouse``` symoblic link to reference the correct USB mouse node.
```bash
ln -s input/mice /dev/usbmouse
```

&nbsp;  
Reboot PS2 Linux and select the ```2.4.17_mvl21``` boot entry to use the 2.4.17_mvl21 Kernel.

