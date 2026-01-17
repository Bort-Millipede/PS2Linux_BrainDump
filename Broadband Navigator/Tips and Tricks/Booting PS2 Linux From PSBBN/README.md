# Booting PS2 Linux From PSBBN (Without PS2 Linux DVD)

Because PSBBN is actually a scaled-back installation of PS2 Linux and because PSBBN automatically boots from the memory card without the PSBBN DVD, PSBBN can be leveraged to boot PS2 Linux without the PS2 Linux DVD. The procedure outlined below involves setting PSBBN to check whether button(s) are pressed on the first controller during boot, and booting PS2 Linux if button(s) are pressed.

## References

* [http://www.geocities.jp/ps2linux_net/bn/ps2boot.html](https://web.archive.org/web/20181105102755/http://www.geocities.jp/ps2linux_net/bn/ps2boot.html)

## Preliminary Considerations

the 2.2.19 or 2.4.17_mvl21 kernel must be used for this setup for various reasons (ReiserFS support, AKMem support, etc.).

This page assumes that PS2 Linux and PSBBN are installed side by side on the same harddrive, and therefore PS2 Linux is installed on APA partitions. In the case of a PS2 Linux Beta Release 1 installation, PS2 Linux is likely installed to legacy APA partitions and PSBBN is installed to APA partitions. The setup outlined below requires first mounting the first PSBBN partition from PS2 Linux (outlined [HERE](../Mounting&#32;PSBBN&#32;Partitions)).

The setup instructions could also be adapted to accomplish the same thing while logged into PSBBN via SSH or Telnet, but doing so that way is not provided by the author here or anywhere else.

### Usage Considerations

Booting PS2 Linux from PSBBN requires picking specific kernel(s) to boot. Kernels 2.4.17_mvl21 and 2.2.19 work fine with this setup with little to no additional setup.

In the author's experience at time of writing, Kernel 2.2.1. does NOT boot successfully from PSBBN. To boot into PS2 Linux with Kernel 2.2.1 from PSBBN, the author recommends first booting into Kernel 2.4.17_mvl21 or 2.2.19, then subsequently rebooting into Kernel 2.2.1 via AKMem.

### Dependencies

* [AKMem](../../../Tips&#32;and&#32;Tricks/AKMem), specifically the **akload** executable.

## Setup (as root or via sudo)

Mount the first PSBBN partition from PS2 Linux.

Copy the **akload** executable to PSBBN.
```bash
mkdir -p /mnt/bbn/usr/local/sbin
cp /usr/local/sbin/akload /mnt/bbn/usr/local/sbin/.
```

&nbsp;  
Copy the PS2 Linux kernel file(s) to the PSBBN ```/boot``` directory. The filename assumptions are listed below (individual setup may vary):  
* 2.4.17_mvl21: ```/boot/vmlinux-2.4.17_mvl21``` on PS2 Linux copied to ```/boot/vmlinux-2.4.17_mvl21.ps2linux``` on PSBBN.
* 2.2.19: ```/boot/vmlinux-2.2.19_ps2``` on PS2 Linux copied to ```/boot/vmlinux-2.2.19_ps2.ps2linux``` on PSBBN.
* 2.2.1: ```/boot/vmlinux-2.2.1_ps2``` on PS2 Linux copied to ```/boot/vmlinux-2.2.1_ps2.ps2linux``` on PSBBN.

```bash
cp /boot/vmlinux-2.4.17_mvl21 /mnt/bbn/boot/vmlinux-2.4.17_mvl21.ps2linux
cp /boot/vmlinux-2.2.19_ps2 /mnt/bbn/boot/vmlinux-2.2.19_ps2.ps2linux
cp /boot/vmlinux-2.2.1_ps2 /mnt/bbn/boot/vmlinux-2.2.1_ps2.ps2linux
```

The remaining setup involves modifying the PSBBN ```/etc/rc.d/rc.sysinit``` file in either of the following ways. Open the PSBBN ```/etc/rc.d/rc.sysinit``` file (located at ```/mnt/bbn/etc/rc.d/rc.sysinit```) and find the following line (should be around line 43):
```bash
/bin/mount -a -n -t nonfs,smbfs,ncpfs,proc
```

### Selecting Controller Buttons For PS2 Linux Booting

As indicated earlier, PS2 Linux will be booted directly from PSBBN by pressing buttons on the first controller during PSBBN boot. This can be setup in either of the following ways:
* Press ANY button on the controller: boot PS2 Linux with a single specified Kernel.
* Press specific buttons on the controller to boot PS2 Linux with specific Kernels (ex. press X to boot 2.4.17_mvl21, press Circle to boot 2.2.19, etc.).

#### Boot PS2 Linux with Single Kernel Using ANY Button

Add the following code snippet to the PSBBN ```/etc/rc.d/rc.sysinit``` file directly below the line discovered earlier (replace **KERNEL_FILE** in the snippet with the kernel filename).
```bash
# Boot PS2 Linux if any button is pressed
BUTTON=`cat /proc/ps2pad | awk '$1==0 { print $5; }'`
if [ "$BUTTON" != "" ] && [ "$BUTTON" != "FFFF" ]
then
	/usr/local/sbin/akload -r /boot/KERNEL_FILE
fi
```

#### Boot PS2 Linux Using Specific Buttons for Different Kernels

Add the following code snippet to the PSBBN ```/etc/rc.d/rc.sysinit``` file directly below the line discovered earlier (filenames for each kernel version are provided earlier. In this snippet:  
* ```FFBF```: X button
* ```FFDF```: Circle button
* ```FF7F```: Square button

```bash
# Boot PS2 Linux 2.4.17 if X is pressed, 2.2.19 if Circle is pressed, or 2.2.1 if Square is pressed
BUTTON=`cat /proc/ps2pad | awk '$1==0 { print $5; }'`
if [ "$BUTTON" != "" ] && [ "$BUTTON" != "FFFF" ]
then
	if [ "$BUTTON" = "FFBF" ]
	then
		/usr/local/sbin/akload -r /boot/vmlinux-2.4.17_mvl21.ps2linux
	elif [ "$BUTTON" = "FFDF" ]
	then
		/usr/local/sbin/akload -r /boot/vmlinux-2.2.19_ps2.ps2linux
	elif [ "$BUTTON" = "FF7F" ]
	then
		/usr/local/sbin/akload -r /boot/vmlinux-2.2.1_ps2.ps2linux
	fi
fi
```

##### Controller Single Button Input Values (from /proc/ps2pad):

The code snippet above can be modified to use different controller buttons for booting different kernels. The possible button values are listed below.

| Button      | Value |
| ----------- | ----- |
| D-Pad Up    | EFFF  |
| D-Pad Down  | BFFF  |
| D-Pad Left  | 7FFF  |
| D-Pad Right | DFFF  |
| Triangle    | FFEF  |
| X           | FFBF  |
| Square      | FF7F  |
| Circle      | FFDF  |
| Select      | FEFF  |
| Start       | F7FF  |
| L1          | FFFB  |
| L2          | FFFE  |
| L3          | FDFF  |
| R1          | FFF7  |
| R2          | FFFD  |
| R3          | FBFF  |

## Usage Notes

![](boot_ps2linux_from_bbn.gif)  
*PS2 Linux booting from PSBBN*

The actual booting of PS2 Linux from PSBBN occurs after the black "Playstation 2" screen appears and while the spinning blue orb lights are displayed on the screen. To actually boot PS2 Linux, the correct controller button (depending on the setup used above) **MUST BE HELD DOWN** until the blue orb lights stop spinning and PS2 Linux boots.

Additionally, parts of the PS2 Linux booting process will not be displayed (for reasons currently unknown by the author). There is a gap between the boot procedure and the login screen being displayed.

**As indicated earlier:** In the author's experience at time of writing, Kernel 2.2.1. does NOT boot successfully from PSBBN. To boot into PS2 Linux with Kernel 2.2.1 from PSBBN, the author recommends first booting into Kernel 2.4.17_mvl21 or 2.2.19, then subsequently rebooting into Kernel 2.2.1 via AKMem.

### X11 Applications and Window Managers

If the PS2 Linux kernels being booted from PSBBN were not compiled with a specific code change (Indicated within the [2.2.19 Kernel](../../../Software&#32;Installation/Kernels/2.2.19_ps2-5), [2.4.17_mvl21 Beta](../../../Software&#32;Installation/Kernels/2.4.17_ps2-22), and [2.4.17_mvl21 Release](../../../Software&#32;Installation/Kernels/2.4.17_ps2-26) pages under **if planning on booting PS2 Linux from BB Navigator...**), the PS2 Linux bootup procedure will not display at all. Additionally, window managers launched from PS2 Linux after booting in this manner may also fail to display. Therefore, it is important to use kernels compiled with the necessary code changes.

