# AKMem for Soft-Rebooting PS2 Linux

When rebooting PS2 Linux via the ```shutdown``` or ```reboot``` commands, the user must physically press the Reset button on the Playstation 2 console to perform the reboot.

![](reboot_screen.png?raw=true)

AKMem ("Another Kernel Memory") is a feature present in the 2.2.19 and 2.4.17_mvl21 kernels. This feature can be leveraged to perform a "soft reboot" of PS2 Linux without requiring the Reset button to be pressed. Additionally, soft rebooting via AKMem enables the user to boot into a different kernel without needing to perform a hard reboot of the Playstation 2 console.

AKMem can be utilized to boot into Kernel 2.2.1 from either Kernel 2.2.19 or 2.4.17_mvl21. However, once PS2 Linux has been booted using Kernel 2.2.1, AKMem cannot be used again without hard rebooting the console and booting into Kernel 2.2.19 or 2.4.17_mvl21.

[Required source link](http://hp.vector.co.jp/authors/VA008536/ps2linux/akmem_ps2.tar.gz)  
**Build type:** native (directly on PS2 Linux)

## References

* [http://www.geocities.jp/ps2linux_net/make_install/akmem.html](https://web.archive.org/web/20181105102756/http://www.geocities.jp/ps2linux_net/make_install/akmem.html)
* [http://hp.vector.co.jp/authors/VA008536/ps2linux/akmem.html](http://hp.vector.co.jp/authors/VA008536/ps2linux/akmem.html)

## Dependencies

* [2.2.19 and/or 2.4.17_mvl21 Kernel Source](../../Software&#32;Installation/Packages/Kernel&#32;Source)

## Kernel Configuration

AKMem is only available under the 2.2.19 and 2.4.17_mvl21 kernels. For these kernel versions, the following option needs to be enabled:
* ```Character devices``` -> ```AKMem(Another Kernel Memory)``` -> ```Another kernel memory device support```

![](2.2.19_akmem.png?raw=true)  
*AKMem(Another Kernel Memory) menu for Kernel 2.2.19*

![](2.4.17_akmem.png?raw=true)  
*AKMem(Another Kernel Memory) menu for Kernel 2.4.17_mvl21*

Alternatively, This can be enabled from within the ```.config``` file by setting the following value:
```
CONFIG_AKMEM=y
```

## Building and Installing AKMem Executable and Script for PS2 Linux

Extract source archive.
```bash
tar xzf akmem_ps2.tar.gz
cd akmem_ps2
```

&nbsp;  
Ensure ```/usr/src/linux``` symbolic link is referencing correct kernel source directory (as root or via sudo).  
**NOTE:** Replace ```linux-2.2.19_ps2``` with ```linux-2.4.17_ps2``` below for Kernel 2.4.17_mvl21.
```bash
rm -f /usr/src/linux
ln -sf linux-2.2.19_ps2 /usr/src/linux
```

&nbsp;  
Build source
```bash
make
```

&nbsp;  
Create ```akmem``` device file and install ```akload``` executable to ```/usr/local/sbin``` (as root or via sudo).
```bash
make mknod
cp akload /usr/local/sbin/akload
```

&nbsp;  
Install **[reboot-akmem script](reboot-akmem)** to ```/usr/local/sbin``` (as root or via sudo).
```bash
cp /path/to/reboot-akmem /usr/local/sbin/reboot-akmem
chmod 755 /usr/local/sbin/reboot-akmem
```

&nbsp;  
Create installation archive (for easy installation onto future PS2 Linux or Broadband Navigator installs).
```bash
mkdir akmem_ps2-bin
cp akload akmem_ps2-bin/
tar czf akmem_ps2-bin.tar.gz akmem_ps2-bin
```

### (RECOMMENDED) Post-Build Cleanup

Recreate ```/usr/src/linux``` symlink to reference current kernel version source directory (as root or via sudo).

## Usage Notes

AKMem can only be utilized while using the 2.2.19 or 2.4.17_mvl21 kernels. 

### Soft Reboot

To perform a soft reboot of PS2 Linux, simply execute the ```reboot-akmem``` script (as root or via sudo):
```bash
reboot-akmem
```

### Soft Reboot Into Different Kernel

To perform a soft reboot PS2 Linux into a different kernel, execute the ```reboot-akmem``` script with the requested kernel version to reboot into specified (example below: boot into Kernel 2.2.19):
```bash
reboot-akmem 2.2.19
```

To reboot into a specific kernel vmlinux file, execute ```reboot-akmem``` with the requested file specified:
```bash
reboot-akmem /path/to/kernel/vmlinux
```

To reboot into Kernel 2.2.1 (and be unable to use AKMem again without performing a hard reboot), the following command can be used:
```bash
reboot-akmem 2.2.1
```

