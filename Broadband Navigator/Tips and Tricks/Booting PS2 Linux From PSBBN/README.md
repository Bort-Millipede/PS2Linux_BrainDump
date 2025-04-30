# Booting PS2 Linux From PSBBN (Without PS2 Linux DVD)

## References

* [http://www.geocities.jp/ps2linux_net/bn/ps2boot.html](https://web.archive.org/web/20181105102755/http://www.geocities.jp/ps2linux_net/bn/ps2boot.html)



Add to BBN /etc/rc.d/rc.sysinit, (starting on new line immediately after ```/bin/mount -a -n -t nonfs,smbfs,ncpfs,proc``` (line 43):

```
# Boot PS2 Linux 2.4.17 if X is pressed, or 2.2.19 if Circle is pressed
BUTTON=`cat /proc/ps2pad | awk '$1==0 { print $5; }'`
if [ "$BUTTON" != "" ] && [ "$BUTTON" != "FFFF" ]
then
	if [ "$BUTTON" = "FFBF" ]
	then
		/usr/local/sbin/akload -r /boot/vmlinux-2.4.17_mvl21.ps2linux
	elif [ "$BUTTON" = "FFDF" ]
	then
		/usr/local/sbin/akload -r /boot/vmlinux-2.2.19_ps2.ps2linux
	fi
fi
```
