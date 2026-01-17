# Chrooting into PSBBN From PS2 Linux

This page outlines chrooting into an underlying PSBBN installation from PS2 Linux. This can be leveraged to perform various actions against PSBBN (ex. creating new system users, installing software).

## Preliminary Considerations

Prior to the procedure outlined below, the first PSBBN partition must be mounted from PS2 Linux (outlined [HERE](../Mounting&#32;PSBBN&#32;Partitions)). The PSBBN partitions use the ReiserFS filesystem, which is not supported by the 2.2.1 kernel. As such, either the 2.2.19 or 2.4.17_mvl21 kernel must be used to mount PSBBN partitions. If attempting to mount PSBBN partitions from a PS2 Linux Beta Release 1 installation: ensure that the kernel was patched to support both APA and legacy APA partitions.

## Initial Setup (as root or via sudo)

Mount the first PSBBN partition from PS2 Linux. Once the partition is mounted, some additional filesystems should be mounted within the partition.

Mount the proc filesystem.
```bash
mount -t proc /proc /mnt/bbn/proc
```

&nbsp;  
Mount the USB device filesystem.
```bash
mount -t usbdevfs /proc/bus/usb /mnt/bbn/proc/bus/usb
```

&nbsp;  
Mount the devpts filesystem.
```bash
mount -t devpts /dev/pts /mnt/bbn/dev/pts
```

## Chrooting (as root or via sudo)

Chroot into PSBBN by executing the following command.
```bash
chroot /mnt/bbn /bin/bash
```

From here, various operations can be performed against PSBBN (such as creating new system users or installing additional software).

![](chroot_bbn.png?raw=true)  
*Chrooting into PSBBN*

## Cleanup

To exit PSBBN, execute an ```exit``` command or enter Ctrl+D.

The filesystems mounted above should be unmounted (as root or via sudo).
```bash
umount /mnt/bbn/dev/pts
umount /mnt/bbn/proc/bus/usb
umount /mnt/bbn/proc
```

