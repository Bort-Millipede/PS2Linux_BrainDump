# Kernel 2.2.19

Required file (present on [Playstation BB Navigator 0.10 Disc 2](https://archive.org/download/sony_playstation2_p/PlayStation%20BB%20Navigator%20-%20Version%200.10%20%28Prerelease%29%20%28Japan%29%20%28Disc%202%29%20%28SCPN-60103%29.zip) under ```SCEI/RPMS```):  
* kernel-2.2.19_ps2-5.src.rpm (in ```source.tgz``` file under ```source/kernel```)  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## References

* [http://www.geocities.jp/ps2linux_net/make_install/kernel-2.2.19.html](https://web.archive.org/web/20181105102816/http://www.geocities.jp/ps2linux_net/make_install/kernel-2.2.19.html)
* [http://www.geocities.jp/ps2linux_net/bn/mount.html](https://web.archive.org/web/20181105102759/http://www.geocities.jp/ps2linux_net/bn/mount.html)

## Preliminary Considerations

This kernel version can be built for either PS2 Linux Beta Release 1 or PS2 Linux Release 1.0. 

### Limitations

The sound module included with this kernel version does not work. This is a known longstanding issue. To mitigate this, the 2.2.1 sound module can be forcefully loaded into the 2.2.19 kernel module at runtime. Accomplishing this is outlined further below.

### Kernel Configuration File

It is recommended that a known-working kernel configuration file be used when building the kernel below. The author's latest kernel configuration file is [available here](config-2.2.19_ps2-5).

## Extracting Necessary File From Playstation BB Navigator 0.10 Disc 2

Attach Playstation BB Navigator 0.10 Disc 2 to the system with the ```mipsEEel-linux-*``` toolchain installed. Mount the DVD as UDF.
```bash
mount -t udf /dev/cdrom /mnt/cdrom
```

Extract the **kernel-2.2.19_ps2-5.src.rpm** from the source.tgz file on the DVD.
```bash
tar xzf /mnt/cdrom/source.tgz source/kernel/kernel-2.2.19_ps2-5.src.rpm
mv source/kernel/kernel-2.2.19_ps2-5.src.rpm .
rm -rf source
```

Umount the DVD
```bash
umount /mnt/cdrom
```

## Installing 2.2.19 Kernel Source to Cross-Compiling Environment (as root)

&nbsp;  
Extract RPM into cross-compiling environment.
```bash
cd /usr/mipsEEel-linux/mipsEEel-linux/usr/src
rpm2cpio kernel-2.2.19_ps2-5.src.rpm | cpio -ivd
tar xzf linux-2.2.19.tar.gz
mv linux linux-2.2.19_ps2-5
rm installkernel linux-2.2.19-5.spec linux-2.2.19.tar.gz module-info
```

&nbsp;  
Remove unnecessary files and create necessary symbolic link in kernel source directory
```bash
cd linux-2.2.19_ps2-5
rm -rf include/config/t10000.h
rm -rf drivers/ps2/t10000
cd include
ln -sf asm-mips asm
cd ..
```

&nbsp;  
**Do this ONLY FOR PS2 Linux Beta Release 1 installations (NOT for PS2 Linux Release 1.0 installations) that:**  
* **are not installed alongside BB Navigator, or**
* **do not need to mount BB Navigator partitions**

Modify APA partitioning support: use APA partitioning support from 2.2.1 Kernel.
```bash
cd drivers/block
mv genhd.c genhd-2.2.19_ps2.c
cp /path/to/linux-2.2.1_ps2-6/drivers/block/genhd.c .
cd ../..
```

&nbsp;  
**Otherwise, do this for PS2 Linux installations (Beta Release 1 and Release 1.0) that:**  
* **are installed alongside BB Navigator, or**
* **need to mount BB Navigator partitions**

Modify APA partitioning support: enable support for legacy APA partitions using [this patch](kernel-2.2.19_ps2-5_bbn-partitions.patch).
```bash
drivers/block
patch -p1 < /path/to/kernel-2.2.19_ps2-5_bbn-partitions.patch
cd ../..
```

&nbsp;  
**Finally: if planning on booting PS2 Linux from BB Navigator:**

Edit ```drivers/char/console.c```: change line 2827 to:
```
//graphics_boot = 1;
```

&nbsp;  
Modify included kernel configuration file to:
* Specify that the kernel is being cross-compiled
* Enable built-in ext2 filesystem support.
* Enable devpts filesystem support.
* Enable UNIX 98 PTY support.
* Enable PS2 debug log facility.
* Enable built-in SCSI device support.
```bash
perl -i.bak -pe "s/^# CONFIG_CROSSCOMPILE is not set/CONFIG_CROSSCOMPILE=y/" config_ps2
perl -i -pe "s/CONFIG_EXT2_FS=m/CONFIG_EXT2_FS=y/" config_ps2
perl -i -pe "s/# CONFIG_DEVPTS_FS\ is\ not\ set/CONFIG_DEVPTS_FS=y/" config_ps2
perl -i -pe "s/# CONFIG_UNIX98_PTYS\ is\ not\ set/CONFIG_UNIX98_PTYS=y/" config_ps2
perl -i -pe "s/# CONFIG_PS2_DEBUGLOG\ is\ not\ set/CONFIG_PS2_DEBUGLOG=m/" config_ps2
perl -i -pe "s/CONFIG_SCSI=m/CONFIG_SCSI=y/" config_ps2
cp config_ps2 arch/mips/defconfig
```

&nbsp;  
Clear all previous builds and build information
```bash
make mrproper
```

&nbsp;  
Copy included kernel configuration into correct location in kernel source directory.
```bash
cp config_ps2 .config
```

&nbsp;  
Alternatively: copy usable kernel configuration file (such as [this one](config-2.2.19_ps2-5)) into correct location in kernel source directory.
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

## Building for PS2 Linux (Beta or Release)

The kernel can be built in the directory that was created/prepared above, or it can be built in a separate directory (this is recommended by the author).
* If building in the above directory, building must be done as root.
* If building in a separate directory, building should be done as a non-root user. To create this directory, follow the directions in the previous section but substitute the ```cd /usr/mipsEEel-linux/mipsEEel-linux/usr/src``` command for a different base directory where the source directory should be created.

&nbsp;  
If needed, reconfigure the kernel (if not needed, this should be skipped).
```bash
make menuconfig
```

&nbsp;  
Build dependencies, then build kernel
```bash
make dep
make clean
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
mv 2.2.19 2.2.19_ps2
tar czf /path/to/new/kernel-modules-2.2.19_ps2-5.tar.gz 2.2.19_ps2
```

## Installing on PS2 Linux (as root)

Transfer **vmlinux**, **System.map**, and **kernel-modules-2.2.19_ps2-5.tar.gz** files to PS2 Linux.

&nbsp;  
Install kernel modules and create necessary ```/lib/modules/2.2.19``` symbolic link.
```bash
cd /lib/modules
tar xzf /path/to/kernel-modules-2.2.19_ps2-5.tar.gz
ln -sf 2.2.19_ps2 2.2.19
```

&nbsp;  
Install kernel files to ```/boot```.
```bash
cp /path/to/vmlinux /boot/vmlinux-2.2.19_ps2
cp /path/to/System.map /boot/System.map-2.2.19_ps2
```

&nbsp;  
**Do this ONLY FOR PS2 Linux Release 1.0 installations:**  
Recreate the ```/boot/vmlinux``` and ```/boot/System.map``` symbolic links to reference the 2.2.19 Kernel.
```bash
rm -f /boot/vmlinux /boot/System.map
ln -s vmlinux-2.2.19_ps2 /boot/vmlinux
ln -s System.map-2.2.19_ps2 /boot/System.map
```

&nbsp;  
Install compressed kernel to first Memory Card (recommended).
```bash
mount /mnt/mc00
gzip -9c /path/to/vmlinux > /mnt/mc00/vmlinux-2.2.19.gz
chmod 755 /mnt/mc00/vmlinux-2.2.19.gz
```

&nbsp;  
Alternatively: install raw uncompressed kernel to first Memory Card.
```bash
mount /mnt/mc00
cp /path/to/vmlinux /mnt/mc00/vmlinux-2.2.19
chmod 755 /mnt/mc00/vmlinux-2.2.19
```

&nbsp;  
Create new boot entry in ```p2lboot.cnf``` file. **Note:** If a raw uncompressed kernel was installed to the Memory Card, replace ```vmlinux-2.2.19.gz``` with ```vmlinux-2.2.19``` in the boot entry.  
Add the following entry to the ```/mnt/mc00/p2lboot.cnf``` file:
```
"2.2.19"	vmlinux-2.2.19.gz ""	203 /dev/hda1 "" 2.2.19
```

&nbsp;  
Create node for for USB mouse to be used by Kernel 2.2.19.
```bash
mknod /dev/usbmouse0-2.2.19 c 13 32
```

&nbsp;  
Add a new entry in the ```/etc/modules.conf``` file to correctly load the USB mouse under Kernel 2.2.19.  
Add the following entry to the ```/etc/modules.conf``` file:
```
alias	char-major-13-32	mousedev
```

&nbsp;  
(Recommended) With the exception of the entry above, diable all ```mousedev``` entries by prepending them with ```#``` characters.

&nbsp;  
Recreate the ```/dev/usbmouse``` symoblic link to reference the correct USB mouse node.
```bash
ln -s usbmouse0-2.2.19 /dev/usbmouse
```

&nbsp;  
Reboot PS2 Linux and select the ```2.2.19``` boot entry to use the 2.2.19 Kernel.

## Using Kernel 2.2.19

### Fixing sound

The easiest way to get sound working under kernel 2.2.19 is to force-load the kernel 2.2.1 ps2sd module into the running 2.2.19 kernel. This can be done using the following command:
```bash
insmod -f /lib/modules/2.2.1/misc/ps2sd.o
```

To automatically force-load the 2.2.1 and boot, edit the ```/etc/rc.d/rc.sysinit``` file and replace the ```insmod ps2sd``` line with:  
```
if [ "`uname -r`" = "2.2.19" ]
then
   insmod ps2rtc
   insmod -q -f /lib/modules/2.2.1/misc/ps2sd.o >/dev/null
   echo "Using /lib/modules/2.2.1/misc/ps2sd.o"
else
   insmod ps2sd
fi
```

