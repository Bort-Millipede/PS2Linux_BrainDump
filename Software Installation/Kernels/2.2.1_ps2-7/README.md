# Kernel 2.2.1 (for PS2 Linux Release 1.0)

![](2.2.1_release_login.png?raw=true)

Required RPM files below are present on **Linux (for Playstation 2) Release 1.0 Disc 2** under ```SCEI/RPMS```.  
* [USA Disc 2](https://archive.org/download/sony_playstation2_l/Linux%20%28for%20PlayStation%202%29%20Release%201.0%20%28USA%29%20%28Disc%202%29%20%28Software%20Packages%29.zip)

Required files:  
* kernel-headers-2.2.1_ps2-7.mipsel.rpm
* kernel-source-2.2.1_ps2-7.mipsel.rpm
* [smap.c.us](smap.c.us): Updated SMAP driver by mrbrown to prevent ethernet connection stability issues
* [apa_2.2.1_src.tar.gz](apa_2.2.1_src.tar.gz): Files to enable APA partitioning support in 2.2.1 Kernel

**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Preliminary Considerations

This page assumes that the cross-compiling environment was installed via the [procedure outlined here](../../Toolchain/). Therefore, the 2.2.1_ps2-7 kernel source is already present on the cross-compiling environment at ```/usr/mipsEEel-linux/mipsEEel-linux/usr/src/linux-2.2.1_ps2```. However, additional configuration is required which is covered below.

If the 2.2.1_ps2-7 kernel source is NOT already present in the cross-compiling environment, commands are provided below to extract it to the environment.

### Kernel Configuration File

It is recommended that a known-working kernel configuration file be used when building the kernel below. The author's latest kernel configuration file is [available here](config-2.2.1_ps2-7). All appropriate kernel options outlined throughout this repository should be enabled in this configuration file.

## Extracting Necessary Files From Linux (for Playstation 2) Release 1.0 Disc 2

Attach **Linux (for Playstation 2) Release 1.0 Disc 2** to the system with the ```mipsEEel-linux-*``` toolchain installed. Mount the DVD as UDF (as root or via sudo).
```bash
mount -t udf /dev/cdrom /mnt/cdrom
```

Copy the **kernel-headers-2.2.1_ps2-7.mipsel.rpm** and **kernel-source-2.2.1_ps2-7.mipsel.rpm** files from the ```/mnt/cdrom/SCEI/RPMS/``` directory onto the system.

Unmount the DVD (as root or via sudo)
```bash
umount /mnt/cdrom
```

## Installing/Configuring 2.2.1_ps2-7 Kernel Source in Cross-Compiling Environment (as root)

If the 2.2.1_ps2-7 kernel source is NOT already present on the cross-compiling environment: extract the 2.2.1_ps2-7 kernel source into the cross-compiling environment
```bash
cd /usr/mipsEEel-linux/mipsEEel-linux
rpm2cpio /path/to/kernel-headers-2.2.1_ps2-7.mipsel.rpm | cpio -ivd
rpm2cpio /path/to/kernel-source-2.2.1_ps2-7.mipsel.rpm | cpio -ivd
cd usr/src
mv linux-2.2.1_ps2 linux-2.2.1_ps2-7
cd linux-2.2.1_ps2-7
```

&nbsp;  
Rename kernel source directory to ```linux-2.2.1_ps2-7```:
```bash
cd /usr/mipsEEel-linux/mipsEEel-linux/usr/src
linux
mv linux-2.2.1_ps2 linux-2.2.1_ps2-7
ln -s linux-2.2.1_ps2-7 linux
cd linux-2.2.1_ps2-7
```

&nbsp;  
Install updated SMAP driver to kernel source directory.
```bash
cd drivers/ps2
mv smap.c smap.c.orig
cp /path/to/smap.c.us smap.c
cd ../..
```

&nbsp;  
Add APA partitioning support kernel.
```bash
mv drivers/block/genhd.c drivers/block/genhd.c.orig
mv fs/Config.in fs/Config.in.orig
tar xzf /path/to/apa_2.2.1_src.tar.gz
```

&nbsp;  
Modify included kernel configuration file to specify that the kernel is being cross-compiled. Also add support for experimental features and for USB mass storage devices.
```bash
perl -i.bak -pe "s/^# CONFIG_BSD_DISKLABEL is not set/CONFIG_PS2_PARTITION=y\n# CONFIG_BSD_DISKLABEL is not set/" arch/mips/defconfig
perl -i -pe "s/^# CONFIG_CROSSCOMPILE is not set/CONFIG_CROSSCOMPILE=y/" arch/mips/defconfig
perl -i -pe "s/^# CONFIG_EXPERIMENTAL is not set/CONFIG_EXPERIMENTAL=y/" arch/mips/defconfig
perl -i -pe "s/^# CONFIG_USB_STORAGE is not set/CONFIG_USB_STORAGE=m/" arch/mips/defconfig
cp arch/mips/defconfig config_ps2
```

&nbsp;  
Clear all previous builds and build information
```bash
make mrproper
```

&nbsp;  
Copy usable kernel configuration file (such as [this one](config-2.2.1_ps2-7)) into correct location in kernel source directory.
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

## Building for PS2 Linux

The kernel can be built in the directory that was created/prepared above, or it can be built in a separate directory (this is recommended by the author).
* If building in the above directory, building must be done as root.
* If building in a separate directory, building should be done as a non-root user. To create this directory, follow the directions in the previous section (including the first step) but substitute the ```/usr/mipsEEel-linux/mipsEEel-linux``` directory references for a different base directory where the source directory should be created.

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
Create installation archive for "installed" kernel modules.
```
cd /lib/modules
tar czf /home/cross/ps2-cross/kernel/builds/2.2.1_ps2-7/kernel-modules-2.2.1_ps2-7.cc.tar.gz 2.2.1
```

## Installing on PS2 Linux Release (as root)

Transfer **vmlinux**, **System.map**, and **kernel-modules-2.2.1_ps2-6.tar.gz** files to PS2 Linux.

**Only do this the first ever time a new build of kernel modules is installed; skip on all subsequent installs:**  
Backup original kernel module directory (to ```/lib/modules/2.2.1_.orig```) on PS2 Linux Release.
```bash
cd /lib/modules
mv 2.2.1 2.2.1.orig
```

&nbsp;  
**Only do this the first ever time a new kernel build is installed; skip on all subsequent installs:**  
Backup originally-installed kernel files.
```bash
cp /boot/System.map-2.2.1_ps2 /boot/System.map-2.2.1_ps2.orig
cp /boot/vmlinux-2.2.1_ps2 /boot/vmlinux-2.2.1_ps2.orig
```

&nbsp;  
Install kernel modules.
```bash
cd /lib/modules
tar czf /home/cross/ps2-cross/kernel/builds/2.2.1_ps2-7/kernel-modules-2.2.1_ps2-7.cc.tar.gz 2.2.1
```

&nbsp;  
Install kernel files to ```/boot``` and create necessary ```/boot/vmlinux``` and ```/boot/System.map``` symbolic links.
```bash
cp /path/to/vmlinux /boot/vmlinux-2.2.1_ps2
cp /path/to/System.map /boot/System.map-2.2.1_ps2
rm /boot/linux /boot/System.map
ln -s vmlinux-2.2.1_ps2 /boot/vmlinux
ln -s System.map-2.2.1_ps2 /boot/System.map
```

&nbsp;  
Install compressed kernel to first Memory Card (recommended).
```bash
mount /mnt/mc00
gzip -9c /path/to/vmlinux > /mnt/mc00/vmlinux.gz
chmod 755 /mnt/mc00/vmlinux.gz
```

&nbsp;  
Alternatively: install raw uncompressed kernel to first Memory Card.
```bash
mount /mnt/mc00
cp /path/to/vmlinux /mnt/mc00/vmlinux
chmod 755 /mnt/mc00/vmlinux
```

&nbsp;  
Create new boot entry in ```p2lboot.cnf``` file. **Note:** The original boot entry created by the PS2 Linux installer can be edited to replace ```vmlinux``` with ```vmlinux.gz```. Alternatively if a raw uncompressed kernel was installed to the Memory Card, the original boot entry created by the PS2 Linux installer can be used as-is and this can be skipped.
Add the following entry to the ```/mnt/mc00/p2lboot.cnf``` file:
```
"2.2.1"	vmlinux-2.2.1.gz ""	203 /dev/hda1 "" 2.2.1
```

&nbsp;  
Reboot to use newly-installed kernel.

### (RECOMMENDED) Post-Build "cleanup"

If [ps2fs](../../Packages/ps2fs) was installed prior to building and installing the kernel above, ps2fs must be re-installed to the /lib/modules/2.2.1 directory.

