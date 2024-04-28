# ps2fs

[Source link](http://achurch.org/ps2/ps2fs.tar.gz)
**Build type:** native (directly on PS2 Linux)

## Preliminary Considerations

ps2fs allows partitions on the PS2 HDD that were NOT created by PS2 Linux to be accessed. The software is compiled as a loadable kernel module. Therefore, it will need to be built separately for every kernel version under which it is intended to be used.

In the author's experience, ps2fs works under all kernel versions EXCEPT 2.2.1_ps2-6 (the 2.2.1 kernel that ships with the Linux Kit Beta). The kernel module builds fine but displays "Unresolved symbol:" errors when being loaded which subsequently fails. Conversely, ps2fs works fine under 2.2.1_ps2-7 (the 2.2.1 kernel that ships with the Linux Kit Release 1.0).

## Building for PS2 Linux

Extract source archive.
```bash
tar xzf ps2fs.tar.gz
cd ps2fs
```

### Building for Kernel 2.2.1

Ensure ```/usr/src/linux``` symbolic link is referencing correct kernel source directory.
```bash
rm /usr/src/linux
ln -s linux-2.2.1_ps2 /usr/src/linux
```

&nbsp;  
Build source.
```bash
make clean
make mips
```

&nbsp;  
Install to current directory and create installation archive (for easy installation onto future PS2 Linux installs).
```bash
mkdir -p 2.2.1/misc
cp ps2fs.o 2.2.1/misc/ps2fs.o
tar czf ps2fs-2.2.1.mipsEEel-linux.tar.gz 2.2.1
```

### Building for Kernel 2.2.19

Ensure ```/usr/src/linux``` symbolic link is referencing correct kernel source directory.
```bash
rm /usr/src/linux
ln -s linux-2.2.19_ps2 /usr/src/linux
```

&nbsp;  
Build source.
```bash
make clean
make mips
```

&nbsp;  
Install to current directory and create installation archive (for easy installation onto future PS2 Linux installs).
```bash
mkdir -p 2.2.19/misc
cp ps2fs.o 2.2.19/misc/ps2fs.o
tar czf ps2fs-2.2.19.mipsEEel-linux.tar.gz 2.2.19
```

### Building for Kernel 2.4.17_mvl21

Ensure ```/usr/src/linux``` symbolic link is referencing correct kernel source directory.
```bash
rm /usr/src/linux
ln -s linux-2.4.17_ps2 /usr/src/linux
```

&nbsp;  
Build source.
```bash
make clean
make mips
```

&nbsp;  
Install to current directory and create installation archive (for easy installation onto future PS2 Linux installs).
```bash
mkdir -p 2.4.17_mvl21/kernel/drivers/ps2
cp ps2fs.o 2.4.17_mvl21/kernel/drivers/ps2/ps2fs.o
tar czf ps2fs-2.4.17_mvl21.mipsEEel-linux.tar.gz 2.4.17_mvl21
```

## Installing on PS2 Linux (as root)

Copy built kernel module(s) to ```/lib/modules```:
```
cp 2.2.1/misc/ps2fs.o /lib/modules/2.2.1/misc/ps2fs.o
cp 2.2.19/misc/ps2fs.o /lib/modules/2.2.19/misc/ps2fs.o
cp 2.4.17_mvl21/kernel/drivers/ps2/ps2fs.o /lib/modules/2.4.17_mvl21/kernel/drivers/ps2/ps2fs.o
```

### (OPTIONAL) Install [helper script](mount-ps2fs) for easily mounting partitions with ps2fs (as root)

Install **mount-ps2fs** script to ```/usr/local/bin```.

```bash
cp /path/to/mount-ps2fs /usr/local/sbin
chmod 755 /usr/local/sbin/mount-ps2fs
chown root.root /usr/local/sbin/mount-ps2fs
```

## Usage Notes

ps2fs can only reliably mount non-PS2 Linux partitions in read-only mode. The provided [helper script](mount-ps2fs) can assist in doing this a little more easily. The original Japanese-language ps2fs README can be found [here](http://achurch.org/ps2/ps2fs.README.txt). This can be semi-reliably translated using Google Translate.

