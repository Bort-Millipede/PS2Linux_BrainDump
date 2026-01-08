# Mounting PSBBN Partitions From PS2 Linux

## References

* [http://www.geocities.jp/ps2linux_net/bn/mount.html](https://web.archive.org/web/20181105102759/http://www.geocities.jp/ps2linux_net/bn/mount.html)

## Preliminary Considerations

This page assumes that PS2 Linux and PSBBN are installed side by side on the same harddrive, and therefore PS2 Linux is installed on APA partitions. In the case of a PS2 Linux Beta Release 1 installation, PS2 Linux is installed to legacy APA partitions and PSBBN is installed to APA partitions.

The PSBBN partitions use the ReiserFS filesystem, which is not supported by the 2.2.1 kernel. As such, either the 2.2.19 or 2.4.17_mvl21 kernel must be used to mount PSBBN partitions. If attempting to mount PSBBN partitions from a PS2 Linux Beta Release 1 installation: ensure that the kernel was patched to support both APA and legacy APA partitions.

### Dependencies

**(RECOMMENDED)** [Reiserfsprogs](../../../Software&#32;Installation/Packages/Reiserfsprogs)

## Procedure

Boot PS2 Linux using the 2.2.19 or 2.4.17_mvl21 kernel.

To mount the first (main) PSBBN partition (assumed to be /dev/hda4 for this), execute the following command (as root or via sudo).
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

