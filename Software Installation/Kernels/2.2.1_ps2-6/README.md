# Kernel 2.2.1 (for PS2 Linux Beta Release 1)

Required files (present on [PS2 Linux Beta Release 1 DVD](https://archive.org/download/sony_playstation2_p/PS2%20Linux%20Beta%20Release%201%20%28Japan%29%20%28En%2CJa%29.zip) under ```SCEI/RPMS```):  
* kernel-headers-2.2.1_ps2-6.mipsel.rpm
* kernel-source-2.2.1_ps2-6.mipsel.rpm  
**Build type:** cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Preliminary Considerations

### Limitations

The 2.2.1 kernel that comes installed on the Playstation 2 Linux Kit Beta is 2.2.1_ps2-6. It seems that a fair amount of the kernel source (especially items compiled as kernel modules by default) was deliberately ommitted from the available source RPMs. As such, installing a cross-compiled kernel/modules for this version requires the originally-installed modules to be copied and then overwritten.

This kernel version expects an HDD partitioned with the proprietary APA format. The Linux Kit Beta uses an earlier rendition of APA partitioning, which is not recognized by the Linux Kit Release 1.0. Additionally, the Linux Kit Release 1.0 does not support APA by default (this is achievable relatively easily but is not covered here), and even when this support is enabled it is only for the newer rendition of APA that is not supported by the Linux Kit Beta. For all of these reasons among others, it is not recommended to attempt to install this exact kernel version onto an installation of PS2 Linux Release 1.0. While it is possible to backport the newer APA partitioning files into this 2.2.1 kernel, doing so is not covered here.

### Kernel Configuration File

It is recommended that a known-working kernel configuration file be used when building the kernel below. The author's latest kernel configuration file is [available here](config-2.2.1_ps2-6).

## Extracting Necessary Files From PS2 Linux Beta Release 1 DVD

Attach PS2 Linux Beta Release 1 DVD to the system with the ```mipsEEel-linux-*``` toolchain installed. Mount the DVD as UDF.
```bash
mount -t udf /dev/cdrom /mnt/cdrom
```

Copy the **kernel-headers-2.2.1_ps2-6.mipsel.rpm** and **kernel-source-2.2.1_ps2-6.mipsel.rpm** files from the ```/mnt/cdrom/SCEI/RPMS/``` directory onto the system.

Umount the DVD
```bash
umount /mnt/cdrom
```

## Installing Kernel Source to Cross-Compiling Environment (as root)

Rename directory where Linux Kit Release 1.0 kernel source code is currently stored. (This assumes that the cross-compiling environment was installed via the [procedure outlined here](../../Toolchain/))
```bash
cd /usr/mipsEEel-linux/mipsEEel-linux
mv usr/src/linux-2.2.1_ps2 usr/src/linux-2.2.1_ps2-7
```

&nbsp;  
Extract RPMs into cross-compiling environment
```bash
cd /usr/mipsEEel-linux/mipsEEel-linux
rpm2cpio /path/to/kernel-headers-2.2.1_ps2-6.mipsel.rpm | cpio -ivd
rpm2cpio /path/to/kernel-source-2.2.1_ps2-6.mipsel.rpm | cpio -ivd
cd usr/src
mv linux-2.2.1_ps2 linux-2.2.1_ps2-6
```

&nbsp;  
Modify included kernel configuration file to specify that the kernel is being cross-compiled. Also add support for experimental features and for USB mass storage devices.
```bash
perl -i.bak -pe "s/^# CONFIG_CROSSCOMPILE is not set/CONFIG_CROSSCOMPILE=y/" config_ps2
perl -i -pe "s/^# CONFIG_EXPERIMENTAL is not set/CONFIG_EXPERIMENTAL=y/" config_ps2
perl -i -pe "s/^# CONFIG_USB_STORAGE is not set/CONFIG_USB_STORAGE=m/" config_ps2
```

&nbsp;  
Clear all previous builds and build information
```bash
make mrproper
```

&nbsp;  
Copy usable kernel configuration file into kernel source directory.
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
* If building in a separate directory, building should be done as a non-root user. To create this directory, follow the directions in the previous section but substitute the ```cd /usr/mipsEEel-linux/mipsEEel-linux``` commands for a different base directory where the source directory should be created.

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
mv 2.2.1 2.2.1_ps2.cc
tar czvf /path/to/new/kernel-modules-2.2.1_ps2-6.tar.gz 2.2.1_ps2.cc
```


## Installing on PS2 Linux Beta (as root)

Transfer **vmlinux**, **System.map**, and **kernel-modules-2.2.1_ps2-6.tar.gz** files to PS2 Linux.

**Only do this the first ever time a new build of kernel modules is installed; skip on all subsequent installs:**  
Backup original kernel module directory (to ```/lib/modules/2.2.1_ps2.orig```) on PS2 Linux Beta. This backup will be needed every time a new build of the kernel modules is installed.
```bash
cd /lib/modules
mv 2.2.1_ps2 2.2.1_ps2.orig
rm 2.2.1
ln -s 2.2.1_ps2.orig 2.2.1
```

&nbsp;  
**Only do this the first ever time a new kernel build is installed; skip on all subsequent installs:**  
Backup originally-installed kernel files.
```bash
cp /boot/System.map-2.2.1_ps2 /boot/System.map-2.2.1_ps2.orig
cp /boot/vmlinux-2.2.1_ps2 /boot/vmlinux-2.2.1_ps2.orig
```

&nbsp;  
Copy kernel module backup directory into new kernel module directory, then install modules and recreate necessary ```/lib/modules/2.2.1``` symbolic link.
```bash
cd /lib/modules
mkdir 2.2.1_ps2.cc
cp 2.2.1_ps2.orig/* 2.2.1_ps2.cc/.
tar xzf /path/to/kernel-modules-2.2.1_ps2-6.tar.gz
rm 2.2.1
ln -s 2.2.1_ps2.cc 2.2.1
```

&nbsp;  
Install kernel files to ```/boot```.
```bash
cp /path/to/vmlinux /boot/vmlinux-2.2.1_ps2.cc
cp /path/to/System.map /boot/System.map-2.2.1_ps2.cc
ln -s vmlinux-2.2.1_ps2.cc /boot/vmlinux-2.2.1_ps2
ln -s System.map-2.2.1_ps2.cc /boot/System.map-2.2.1_ps2
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
cp /path/to/vmlinux /mnt/mc00/vmlinux.gz
chmod 755 /mnt/mc00/vmlinux
```

### (RECOMMENDED) Post-Build "cleanup"

If [ps2fs](../../Packages/ps2fs) was installed prior to building and installing kernel, ps2fs must be re-installed to the /lib/modules/2.2.1_ps2 directory.

