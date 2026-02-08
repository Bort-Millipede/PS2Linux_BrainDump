# Kernel 2.2.19

![](2.2.19_beta_login.png?raw=true)  
*PS2 Linux Beta Release 1 running on Kernel 2.2.19*

![](2.2.19_release_login.png?raw=true)  
*PS2 Linux Release 1.0 running on Kernel 2.2.19*

Required file (present on [Playstation BB Navigator 0.10 Disc 2](https://archive.org/download/sony_playstation2_p/PlayStation%20BB%20Navigator%20-%20Version%200.10%20%28Prerelease%29%20%28Japan%29%20%28Disc%202%29%20%28SCPN-60103%29.zip), within ```source.tgz``` file under ```source/kernel```):  
* kernel-2.2.19_ps2-5.src.rpm

**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## References

* [http://www.geocities.jp/ps2linux_net/make_install/kernel-2.2.19.html](https://web.archive.org/web/20181105102816/http://www.geocities.jp/ps2linux_net/make_install/kernel-2.2.19.html)
* [http://www.geocities.jp/ps2linux_net/bn/mount.html](https://web.archive.org/web/20181105102759/http://www.geocities.jp/ps2linux_net/bn/mount.html)
* [http://hp.vector.co.jp/authors/VA008536/ps2linux/kernel2.html](http://hp.vector.co.jp/authors/VA008536/ps2linux/kernel2.html)

## Preliminary Considerations

This kernel version can be built for either PS2 Linux Beta Release 1 or PS2 Linux Release 1.0. 

### Limitations

The sound module included with this kernel version does not work. This is a known longstanding issue. To mitigate this, the 2.2.1 sound module can be forcefully loaded into the 2.2.19 kernel module at runtime, after which audio output should function correctly. Accomplishing this is outlined further below.

### Kernel Configuration File

It is recommended that a known-working kernel configuration file be used when building the kernel below. The author's latest kernel configuration file is [available here](config-2.2.19_ps2-5). All appropriate kernel options outlined throughout this repository are enabled in this configuration file. This configuration file should work with both PS2 Linux Beta Release 1 and PS2 Linux Release 1.0.

## Extracting Required File From Playstation BB Navigator 0.10 Disc 2

Attach Playstation BB Navigator 0.10 Disc 2 to the system with the ```mipsEEel-linux-*``` toolchain installed. Mount the DVD as UDF (as root or via sudo).
```bash
mount -t udf /dev/cdrom /mnt/cdrom
```

Extract the **kernel-2.2.19_ps2-5.src.rpm** from the source.tgz file on the DVD.
```bash
tar xzf /mnt/cdrom/source.tgz source/kernel/kernel-2.2.19_ps2-5.src.rpm
mv source/kernel/kernel-2.2.19_ps2-5.src.rpm .
rm -rf source
```

Unmount the DVD (as root or via sudo).
```bash
umount /mnt/cdrom
```

## Installing/Configuring 2.2.19 Kernel Source to Cross-Compiling Environment (as root or via sudo)

Extract RPM into cross-compiling environment.
```bash
cd /usr/mipsEEel-linux/mipsEEel-linux/usr/src
mv linux linux.bak
rpm2cpio /path/to/kernel-2.2.19_ps2-5.src.rpm | cpio -id
tar xzf linux-2.2.19.tar.gz
mv linux linux-2.2.19_ps2-5
rm -f installkernel linux-2.2.19-5.spec linux-2.2.19.tar.gz module-info
mv linux.bak linux
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
* **are NOT installed alongside BB Navigator, or**
* **do NOT need to mount BB Navigator partitions**

Modify APA partitioning support: use legacy APA partitioning support from 2.2.1 Beta Kernel.
```bash
cd drivers/block
mv genhd.c genhd-2.2.19_ps2.c
cp /path/to/linux-2.2.1_ps2-6/drivers/block/genhd.c .
cd ../..
```

&nbsp;  
**Otherwise, do this ONLY FOR PS2 Linux Beta Release 1 installations that:**  
* **are installed alongside BB Navigator AND need to mount BB Navigator partitions**

Modify APA partitioning support: enable support for legacy APA partitions using [this patch](kernel-2.2.19_ps2-5_bbn-partitions.patch).
```bash
cd drivers/block
patch -p0 < /path/to/kernel-2.2.19_ps2-5_bbn-partitions.patch
cd ../..
```

&nbsp;  
**Finally: if planning on booting PS2 Linux from BB Navigator:** Edit character device driver to prevent picture from freezing on boot.
```bash
perl -i -pe "s/^\tgraphics_boot = 1;/\t\/\/graphics_boot = 1;/" drivers/char/console.c
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
cp -f config_ps2 arch/mips/defconfig
```

&nbsp;  
Clear all previous builds and build metadata.
```bash
make mrproper
```

&nbsp;  
Copy usable kernel configuration file (such as the included ```config_ps2``` file, or [the author's configuration file](config-2.2.19_ps2-5)) into correct location in kernel source directory.
```bash
cp /path/to/working/kernel/config/file config
cp config .config
```

&nbsp;  
Prepare kernel source directory for building. If prompted by ```make oldconfig``` command to make choices, pressing ENTER will choose the default choice.  
To immediately exit out of ```make menuconfig``` command, press: ```ESC ESC```; then select ```No```.
```
make oldconfig
make menuconfig
```

## Building for PS2 Linux (Beta Release 1 or Release 1.0)

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
"Install" kernel modules to current system (as root or via sudo). These will not actually run on the current system.
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

## Installing Kernel on PS2 Linux (Beta Release 1 or Release 1.0) (as root or via sudo)

Transfer **vmlinux**, **System.map**, and **kernel-modules-2.2.19_ps2-5.tar.gz** files to PS2 Linux.

&nbsp;  
Install kernel modules and create necessary ```/lib/modules/2.2.19``` symbolic link.
```bash
cd /lib/modules
tar xzf /path/to/kernel-modules-2.2.19_ps2-5.tar.gz
ln -sf 2.2.19_ps2 2.2.19
depmod -a
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
**Recommended:** Install compressed kernel to first Memory Card.
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
**Note:** If a raw uncompressed kernel was installed to the Memory Card above, replace ```vmlinux-2.2.19.gz``` with ```vmlinux-2.2.19``` in the below boot entry.  
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
**Recommended:** With the exception of the entry above, disable all ```mousedev``` entries.
```bash
perl -i -pe "s/^alias[ \t]{1,}char-major-10-32[ \t]{1,}mousedev$/#alias\tchar-major-10-32\tmousedev/" /etc/modules.conf
perl -i -pe "s/^alias[ \t]{1,}char-major-13-63[ \t]{1,}mousedev$/#alias\tchar-major-13-63\tmousedev/" /etc/modules.conf
```

&nbsp;  
Recreate the ```/dev/usbmouse``` symbolic link to reference the correct USB mouse node.
```bash
ln -s usbmouse0-2.2.19 /dev/usbmouse
```

&nbsp;  
Reboot PS2 Linux and select the ```2.2.19``` boot entry to use the 2.2.19 Kernel.

## Using Kernel 2.2.19

### Fixing Sound

The easiest way to get sound working under kernel 2.2.19 is to force-load the kernel 2.2.1 ```ps2sd``` module into the running 2.2.19 kernel. This can be done using the following command:
```bash
insmod -f /lib/modules/2.2.1/misc/ps2sd.o
```

&nbsp;  
The 2.2.1 ```ps2sd``` module can also be automatically force-loaded at boot time. To configure this, edit the ```/etc/rc.d/rc.sysinit``` file and replace ```insmod ps2sd``` (around line 50) with:
```
if [ "`uname -r`" = "2.2.19" ]
then
   insmod -q -f /lib/modules/2.2.1/misc/ps2sd.o >/dev/null
   echo "Using /lib/modules/2.2.1/misc/ps2sd.o"
else
   insmod ps2sd
fi
```

### Initializing PS2 RTC Under PS2 Linux Beta Release 1

The ```ps2rtc``` kernel module needs to be loaded under PS2 Linux Beta Release 1 in order to access the Playstation 2 Real Time Clock. To do this automatically at boot time, edit the ```/etc/rc.d/rc.sysinit``` file:
* If the "Fixing Sound" changes above were committed, append the following after the above changes.
* Otherwise, append the following after ```insmod sound``` line (should be around line 50):
```bash
if [ "`uname -r`" = "2.2.19" ]
then
   insmod ps2rtc
fi
```

