# Enabling Telnet on PSBBN

Enabling Telnet on PSBBN allows remote access to a running PSBBN installation.

## References

* [http://www.geocities.jp/ps2linux_net/bn/telnet.html](https://web.archive.org/web/20181105102758/http://www.geocities.jp/ps2linux_net/bn/telnet.html)

## Preliminary Considerations

Prior to the procedure outlined below, the first PSBBN partition must be mounted from PS2 Linux (outlined [HERE](../Mounting&#32;PSBBN&#32;Partitions)). The PSBBN partitions use the ReiserFS filesystem, which is not supported by the 2.2.1 kernel. As such, either the 2.2.19 or 2.4.17_mvl21 kernel must be used to mount PSBBN partitions. If attempting to mount PSBBN partitions from a PS2 Linux Beta Release 1 installation: ensure that the kernel was patched to support both APA and legacy APA partitions.

Additionally, Telnet communications do not utilize encryption and therefore all information (including usernames/passwords) are transmitted in cleartext. As such, the author recommends enabling Telnet temporarily in order to install SSH (outlined [HERE](../Software&#32;Installation)).

## Enable Telnet (as root or via sudo)

Mount the first PSBBN partition from PS2 Linux.

Copy the Telnet daemon executable from PS2 Linux to PSBBN.
```bash
cp /usr/sbin/in.telnetd /mnt/bbn/usr/sbin/.
```

&nbsp;  
Modify the PSBBN ```/etc/inetd.conf``` file to enable (uncomment) telnet.
```bash
perl -i.bak -pe "s/^#telnet/telnet/" /mnt/bbn/etc/inetd.conf
```

&nbsp;  
Modify the PSBBN ```/etc/rc.d/rc.sysinit``` file to have PSBBN launch telnet at boot.
```bash
bash -c "echo /usr/sbin/inetd >> /mnt/bbn/etc/rc.d/rc.sysinit"
```

&nbsp;  
Reboot into PSBBN and confirm access via telnet.

## Usage Example

![](telnet_bbn.png?raw=true)  
*PSBBN successfully accessed via Telnet*

