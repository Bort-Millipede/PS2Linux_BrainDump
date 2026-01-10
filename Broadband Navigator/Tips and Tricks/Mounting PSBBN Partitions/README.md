# Mounting PSBBN Partitions From PS2 Linux

This page outlines mounting PSBBN partitions from PS2 Linux, which can be leveraged to gain underlying access to a PSBBN installation.

## References

* [http://www.geocities.jp/ps2linux_net/bn/mount.html](https://web.archive.org/web/20181105102759/http://www.geocities.jp/ps2linux_net/bn/mount.html)

## Preliminary Considerations

This page assumes that PS2 Linux and PSBBN are installed side by side on the same harddrive, and therefore PS2 Linux is installed on APA partitions. In the case of a PS2 Linux Beta Release 1 installation, PS2 Linux is likely installed to legacy APA partitions and PSBBN is installed to APA partitions.

The PSBBN partitions use the ReiserFS filesystem, which is not supported by the 2.2.1 kernel. As such, either the 2.2.19 or 2.4.17_mvl21 kernel must be used to mount PSBBN partitions. If attempting to mount PSBBN partitions from a PS2 Linux Beta Release 1 installation: ensure that the kernel was patched to support both APA and legacy APA partitions.

### Dependencies

**(RECOMMENDED)** [Reiserfsprogs](../../../Software&#32;Installation/Packages/Reiserfsprogs)

## Expected PSBBN Partitions

**PSBBN 0.30:**
```
/dev/hda1 reiserfs
/dev/hda2 swap
/dev/hda4 reiserfs
/dev/hda5 reiserfs
/dev/hda6 reiserfs
/dev/hda7 reiserfs
```

## Mounting (as root or via sudo)

**NOTE:** If mounting PSBBN partitions from a PS2 Linux Beta Release 1 installation installed on legacy APA partitions and using a patched kernel, the PSBBN partitions will likely reside after the PS2 Linux partitions. Therefore, the partitions numbers will not map exactly. Examples:  
* If PS2 Linux is installed on two partitions (```/dev/hda1``` for system, ```/dev/hda2``` for swap), the PSBBN partitions will begin at ```/dev/hda3``` (```/dev/hda3``` = PSBBN ```/dev/hda1```).
* If PS2 Linux is installed on more than two partitions (```/dev/hda1``` for system, ```/dev/hda2``` for swap, ```/dev/hdaX``` and others ...), the PSBBN partitions will begin after these (```/dev/hdaX```+1 = PSBBN ```/dev/hda1```).

&nbsp;  
Boot PS2 Linux using the 2.2.19 or 2.4.17_mvl21 kernel.

To mount the first (main) PSBBN partition (assumed to be ```/dev/hda4``` below), execute the following commands.
```bash
mkdir -p /mnt/bbn
mount -t reiserfs /dev/hda4 /mnt/bbn
```

Verify that the mounted partition contains PSBBN.
```bash
ls /mnt/bbn
```

![](bbn_mount.png?raw=true)  
*First PSBBN partition successfully mounted*

Other PSBBN partitions can be mounted in a similar fashion by changing ```/dev/hda4``` in the command above.

## Unmounting (as root or via sudo)

**NOTE:** if other filesystems (such as ```/proc``` or ```/dev/pts```, as described in other pages in this repository) were mounted within the PSBBN partition after mounting, these must be unmounted prior to unmounting the PSBBN partition.

To unmount a PSBBN partition, execute the following command.
```bash
umount /mnt/bbn
```

