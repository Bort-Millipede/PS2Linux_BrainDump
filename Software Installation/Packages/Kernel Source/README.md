# 2.2.19 and 2.4.17_mvl21 Kernel Sources

Some software that is built natively on PS2 Linux requires being built against newer kernel versions, rather than the stock 2.2.1 Kernel. Therefore, the kernel source for these newer versions must first be installed to PS2 Linux.

2.2.19 required file:
* ```kernel-2.2.19_ps2-5.src.rpm```: present on [Playstation BB Navigator 0.10 Disc 2](https://archive.org/download/sony_playstation2_p/PlayStation%20BB%20Navigator%20-%20Version%200.10%20%28Prerelease%29%20%28Japan%29%20%28Disc%202%29%20%28SCPN-60103%29.zip), within ```source.tgz``` file under ```source/kernel```.

2.4.17_mvl21 (PS2 Linux Beta Release 1) required files:
* [kernel-headers-2.4.17_ps2-22.mipsel.rpm](https://web.archive.org/web/20031207191309/http://www.sony.net:80/Products/Linux/Download/PlayStation_BB_Navigator/kernel-headers-2.4.17_ps2-22.mipsel.rpm)
* [kernel-source-2.4.17_ps2-22.mipsel.rpm](https://web.archive.org/web/20031207191309/http://www.sony.net:80/Products/Linux/Download/PlayStation_BB_Navigator/kernel-source-2.4.17_ps2-22.mipsel.rpm)

2.4.17_mvl21 (PS2 Linux Release 1.0) required files:
* [kernel-headers-2.4.17_ps2-26.mipsel.rpm](https://web.archive.org/web/20031207191309/http://www.sony.net/Products/Linux/Download/PlayStation_BB_Navigator/kernel-headers-2.4.17_ps2-26.mipsel.rpm)
* [kernel-source-2.4.17_ps2-26.mipsel.rpm](https://web.archive.org/web/20031207191309/http://www.sony.net/Products/Linux/Download/PlayStation_BB_Navigator/kernel-source-2.4.17_ps2-26.mipsel.rpm)

**Build type:** N/A

## Installing on PS2 Linux (as root)

### 2.2.19 Kernel

&nbsp;  
Extract RPM.
```bash
cd /usr/src
mv linux linux.bak
rpm2cpio /path/to/kernel-2.2.19_ps2-5.src.rpm | cpio -ivd
tar xzf linux-2.2.19.tar.gz
mv linux linux-2.2.19_ps2-5
rm installkernel linux-2.2.19-5.spec linux-2.2.19.tar.gz module-info
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

Modify APA partitioning support: enable support for legacy APA partitions using [this patch](../../Kernels/2.2.19_ps2-5/kernel-2.2.19_ps2-5_bbn-partitions.patch).
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
Alternatively: copy usable kernel configuration file (such as [this one](../../Kernels/2.2.19_ps2-5/config-2.2.19_ps2-5)) into correct location in kernel source directory.
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

### 2.4.17_mvl21 (PS2 Linux Beta Release 1)

Install RPMs.
```bash
rpm -i /path/to/kernel-headers-2.4.17_ps2-22.mipsel.rpm
rpm -i /path/to/kernel-source-2.4.17_ps2-22.mipsel.rpm
cd /usr/src
mv linux-2.4.17_ps2 linux-2.4.17_ps2-22
cd linux-2.4.17_ps2-22
```

&nbsp;  
Modify APA partitioning support: enable support for legacy APA partitions using [this patch](../../Kernels/2.4.17_ps2-22/kernel-2.4.17_ps2-22_partitions.patch).
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
Alternatively: copy usable kernel configuration file (such as [this one](../../Kernels/2.4.17_ps2-22/config-2.4.17_ps2-22)) into correct location in kernel source directory.
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

### 2.4.17_mvl21 (PS2 Linux Release 1.0)

Install RPMs.
```bash
rpm -i /path/to/kernel-headers-2.4.17_ps2-26.mipsel.rpm
rpm -i /path/to/kernel-source-2.4.17_ps2-26.mipsel.rpm
cd /usr/src
mv linux-2.4.17_ps2 linux-2.4.17_ps2-26
cd linux-2.4.17_ps2-26
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
Alternatively: copy usable kernel configuration file (such as [this one (FIXME)](../../Kernels/2.4.17_ps2-26/FIXME)) into correct location in kernel source directory.
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

## Configuring PS2 Linux to Build Software Against Different Kernel Version

The kernel source directory that PS2 Linux will build software against is referenced by the ```/usr/src/linux``` symlink. To reconfigure this, the symlink must be recreated to reference a different source directory.

### Example (as root)

Configuring PS2 Linux to build against the 2.2.19 Kernel.
```bash
rm /usr/src/linux
ln -s linux-2.2.19_ps2-5 /usr/src/linux
```

