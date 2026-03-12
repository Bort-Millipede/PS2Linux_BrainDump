# Booting To a Ramdisk with PS2 Linux

This page outlines installing a ramdisk to the memory card and booting to it using PS2 Linux. Booting to a ramdisk in PS2 Linux (similar to booting a modern Linux LiveCD) provides the ability to perform certain operations that are not possible when booting normally from a hard disk drive. 

This page uses a prebuilt PS2 Linux-compatible ramdisk. Building a ramdisk from scratch for PS2 Linux is not covered here or anywhere else in this repository.

## References

* [http://playstation2-linux.com/download/apa/apa_2.2.1.html](http://ps2linux.no-ip.info/playstation2-linux.com/download/apa/apa_2.2.1.html)

## Prequisites

A ramdisk file is required for the directions below. The options for this are:
* Original ramdisk (from the playstation2-linux.com community) for Beta Release 1 and Release 1.0 (supports kernel 2.2.1 only): [initfs.gz](http://ps2linux.no-ip.info/playstation2-linux.com/download/apa/initfs.gz)
* Author's ramdisks (support kernels 2.2.1, 2.2.19, and 2.4.17_mvl21):
  * For Beta Release 1: [initfs_beta.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initfs/initfs_beta.gz)
  * For Release 1.0: [initfs_release.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initfs/initfs_release.gz)

Additionally, booting into a ramdisk requires that ramdisk support is enabled in the Linux kernel. For kernels 2.2.1 and 2.2.19, this is included with the default configurations. For kernel 2.4.17_mvl21, this is not included with the default configuration and requires the kernel to be recompiled with ramdisk support. The options for this are:
* Use the [author's precompiled 2.4.17_mvl21 kernels](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/tag/kernel), which include this necessary support. 
* Build the 2.4.17_mvl21 kernel with ramdisk support ([Beta Release 1](../../Software&#32;Installation/Kernels/2.4.17_ps2-22) and [Release 1.0](../../Software&#32;Installation/Kernels/2.4.17_ps2-26)).

## Installing the Ramdisk (as root or via sudo).

The ramdisk file is reference as file ```initfs.gz``` below.

&nbsp;  
Mount the memory card.
```bash
mount /mnt/mc00
```

&nbsp;  
**Optional:** Confirm that the memory card has sufficient free space by comparing it to the file size of the ramdisk.
```bash
df --block-size=1 /mnt/mc00 | tr -s " " | grep mc00 | cut -d" " -f 4
ls -l /path/to/initfs.gz | tr -s " " | grep "initfs.gz" | cut -d" " -f 5
```

&nbsp;  
copy the ramdisk file (referenced below as ```initfs.gz```) to the memory card.
```bash
cp /path/to/initfs.gz /mnt/mc00/initfs.gz
```

### Adding Boot entries

#### Compressed Kernels

Add the following entry to the ```/mnt/mc00/p2lboot.cnf``` file:
```
"initfs2.2.1"	vmlinux.gz initfs.gz	203 /dev/ram0 ""	initfs 2.2.1
```

If using one of the author's ramdisks, also add the following entries:
```
"initfs2.2.19"	vmlinux-2.2.19.gz initfs.gz	203 /dev/ram0 ""	initfs 2.2.19
"initfs2.4.17"	vmlinux-2.4.17_mvl21.gz initfs.gz	203 /dev/ram0 "ramdisk_size=10240"	initfs 2.4.17
```

#### Uncompressed Kernels

Add the following entry to the ```/mnt/mc00/p2lboot.cnf``` file:
```
"initfs2.2.1"	vmlinux initfs.gz	203 /dev/ram0 ""	initfs 2.2.1
```

If using one of the author's ramdisks, also add the following entries:
```
"initfs2.2.19"	vmlinux-2.2.19 initfs.gz	203 /dev/ram0 ""	initfs 2.2.19
"initfs2.4.17"	vmlinux-2.4.17_mvl21 initfs.gz	203 /dev/ram0 "ramdisk_size=10240"	initfs 2.4.17
```

## Using to the Installed Ramdisk

Load the PS2 Linux DVD and select the appropriate ```initfs*``` boot option, depending on which kernel should be used with the ramdisk. When the login prompt appears, enter root for the username.

## PS2 Linux Beta Release 1 Ramdisk with Kernel 2.4.17_mvl21

The PS2 Linux Beta Release 1 DVD cannot boot the 2.4.17_mvl21 kernel correctly (the kernel loading dialog completes, after which a blank screen appears and nothing further happens). As such, the DVD cannot be used to boot to the ramdisk with kernel 2.4.17_mvl21 either. The author has confirmed that the PS2 Linux Release 1.0 DVD (from any region, as long as the PS2 console being used can boot the DVD successfully) can be used to boot to the ramdisk with kernel 2.4.17_mvl21 successfully.

While this may also be possible using AKMem or BB Navigator, the author has been unable to confirm this and therefore makes no guarantees.

