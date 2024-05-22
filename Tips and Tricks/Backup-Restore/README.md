# Backing Up and Restoring PS2 Linux

This page outlines how to create a full backup of a PS2 Linux installation, as well as how to restore from a backup at a later time. This involves booting into a ramdisk. The procedure below is preferred by the author, but is by no means the only method for backing up/restoring a PS2 Linux installation. The reference link listed below provides another (and possibly simpler) procedure for this.

Partitioning/re-partitioning the hard drive is not covered here or anywhere else in this repository. The reference link listed below may provide sufficient information for this.

The directions below assume that PS2 Linux is installed to ```/dev/hda1``` and the backup partition is installed to ```/dev/hda3```. If this does not match the PS2 Linux installation being backed up or restored, the appropriate steps below must be modified accordingly.

Required file: [initfs.gz](http://ps2linux.no-ip.info/playstation2-linux.com/download/apa/initfs.gz)

## References

* [http://playstation2-linux.com/download/apa/apa_2.2.1.html](http://ps2linux.no-ip.info/playstation2-linux.com/download/apa/apa_2.2.1.html)

## Prerequisites

### Dependencies

* [star](../../Software&#32;Installation/Packages/star): This seems to perform faster than the standard ```tar``` executable available on PS2 Linux.
* [pv](../../Software&#32;Installation/Packages/pv): This is optional but recommended. This should be used in conjunction with file transfers using netcat, as the netcat version available in the PS2 Linux ramdisk does not output progress information.

### Backup Partition Setup

A backup partition will need to be created on the PS2 HD to store the backup files. The author recommends 5GB for this, although a smaller partition may also suffice.

The following directories should be created on the root of the backup partition:
* ```bin```: For storing executables that can be helpful during the backup/restore process
* ```install-images```: For storing PS2 Linux installation backup archives.

It is recommended that the following executables be copied to the ```bin``` directory on the backup partition:
* ```md5sum```: ```cp /usr/bin/md5sum /mnt/backup/bin/md5sum```
* ```pv```: ```cp /usr/local/bin/pv /mnt/backup/bin/pv```
* ```star```: ```cp /usr/local/bin/star /mnt/backup/bin/pv```
* ```ps2fdisk```: For partitioning drives using the APA partitioning scheme. Available [HERE](http://ps2linux.no-ip.info/playstation2-linux.com/download/apa/ps2fdisk_0.9-3.gz)
* ```ps2fdisk_scei```: (For PS2 Linux Beta Release 1 installations) For partitioning drivers using teh legacy APA partitioning scheme. ```cp /sbin/ps2fdisk /mnt/backup/bin/ps2fdisk_scei```

## Installing the Ramdisk (as root).

Mount the memory card and copy the ramdisk file to the memory card.
```bash
mount /mnt/mc00
cp /path/to/initfs.gz /mnt/mc00/initfs.gz
```

&nbsp;  
Add the following entry to the ```/mnt/mc00/p2lboot.cnf``` file:
```
"initfs"  vmlinux initfs.gz 203 /dev/ram0 "" initfs
```

## Creating a Backup of a PS2 Linux Installation

Load the PS2 Linux DVD and select the ```initfs``` boot option. When the login prompt appears, enter root for the username.

&nbsp;  
Mount the PS2 Linux and backup partitions.
```bash
mount /dev/hda1 /mnt/hd
mkdir -p /mnt/backup
mount /dev/hda3 /mnt/backup
```

&nbsp;  
Create a full backup of the PS2 Linux installation (this will take a while).
```bash
cd /mnt/hd
/mnt/backup/bin/star -c -H=gnutar * | gzip -1 -c > /mnt/backup/install-images/ps2linuxbeta-full-image.tar.gz
```

&nbsp;  
Mount the Memory Card and create a backup of the PS2 Linux save file.
```bash
mount /mnt/mc00
cd /mnt/mc00
/mnt/backup/bin/star -c -H=gnutar * | gzip -c > /mnt/backup/install-images/mc00.tar.gz
```

## Transfering Files To/From PS2 Linux While in the Ramdisk

The ramdisk does establish the network connection by default. Additionally, the ramdisk cannot establish a network connection via DHCP. Therefore, the network connection must be manually setup. It is recommended that the most recent leased DHCP-leased IP address be used for this.

If the most recent IP address leased to PS2 linux was 192.168.1.10 with a subnet mask of 255.255.255.0, then the network connection can be manually setup using the following command:
```bash
ifconfig eth0 192.168.1.10 netmask 255.255.255.0 bcast 192.168.1.255
```

### Netcat

The ramdisk comes with netcat installed. The most straightforward way for transferring files via netcat is outlined below. However, this method may not be preferred as transfer speeds are very slow.

Send file from PS2 Linux to Linux PC:  
On Linux PC (receive file ```ps2linuxbeta-full-image.tar.gz``` on TCP port 4444):
```bash
nc -nvlp 4444 > ps2linuxbeta-full-image.tar.gz
```
On PS2 Linux ramdisk (send file ```ps2linuxbeta-full-image.tar.gz``` to 192.168.1.11 on TCP port 4444, with progress information displayed by ```pv```):
```bash
cat /mnt/backup/install-images/ps2linuxbeta-full-image.tar.gz | /mnt/backup/bin/pv | nc -nv 192.168.1.11 4444
```

&nbsp;  
Send file from PC to PS2 Linux:  
On PS2 Linux ramdisk (receive file ```ps2linuxbeta-full-image.tar.gz``` on TCP port 4444, with progress information displayed by ```pv```):
```bash
nc -nvlp 4444 | /mnt/backup/bin/pv > ps2linuxbeta-full-image.tar.gz
```
On Linux PC (send file ```ps2linuxbeta-full-image.tar.gz``` to 192.168.1.10 on TCP port 4444):
```bash
cat ps2linuxbeta-full-image.tar.gz | nc -nv 192.168.1.10 4444
```

**NOTE:** On a Windows-based PC, the ```cat``` command above can be replaced by the ```type``` command.

### FTP

This method is a little more complicated, but transfers files very quickly. The method outlined below leverages the [Python3-based](https://www.python.org/) FTP server [pyftpdlib](https://pypi.org/project/pyftpdlib/).

&nbsp;  
Setup FTP Server on PC (192.168.1.11) on port 21 with login credentials PS2LINUX/PS2LINUX:
```
python -m pyftpdlib -p 21 -w -u PS2LINUX -P PS2LINUX
```

&nbsp;  
Connect to the FTP server from PS2 Linux ramdisk:
```bash
ftp 192.168.1.11 21
PS2LINUX
PS2LINUX
```

&nbsp;  
Download file from FTP server to PS2 Linux:
```
get ps2linuxbeta-full-image.tar.gz
```

&nbsp;  
Upload file to FTP server from PS2 Linux:
```
put ps2linuxbeta-full-image.tar.gz
```

## Restoring a Backup of a PS2 Linux Installation

Load the PS2 Linux DVD and select the ```initfs``` boot option. When the login prompt appears, enter root for the username.

&nbsp;  
Mount the backup partition.
```bash
mkdir -p /mnt/backup
mount /dev/hda3 /mnt/backup
```

&nbsp;  
Format the PS2 Linux partition. This will destroy the current installation on the partition!
```bash
mke2fs /dev/hda1
```

&nbsp;  
Mount the PS2 Linux partition.
```bash
mount /dev/hda1 /mnt/hd
```

&nbsp;  
Restore the PS2 Linux installation. This will take a while.
```bash
cd /mnt/hd
gzip -dc /mnt/backup/install-images/ps2linuxbeta-full-image.tar.gz | /mnt/backup/bin/star -x -p -f -
```

&nbsp; 
Ensure that the ```/mnt/hd/etc/fstab``` file references the correct partitions for the PS2 Linux partition and for the swap partition.

