# GCC 2.95.2

Source: gcc-2.95.2-3a.src.rpm present on [Linux (for Playstation 2) Release 1.0 Disc 2](https://archive.org/download/sony_playstation2_l/Linux%20%28for%20PlayStation%202%29%20Release%201.0%20%28USA%29%20%28Disc%202%29%20%28Software%20Packages%29.zip) under ```SRPMS```.  
**Build type:** native (directly on PS2 Linux)

## References

* **Mozilla for PlayStation 2 Cross Compiling Mini-HOWTO**
  * Local backup [here](moz_cross_1.0.1.html) or rendered [here](https://html-preview.github.io/?url=https://github.com/Bort-Millipede/PS2Linux_BrainDump/blob/main/Software%20Installation/Toolchain/moz_cross_1.0.1.html)
  * [Backup site](http://ps2linux.no-ip.info/playstation2-linux.com/download/mozilla-ps2/moz_cross_1.0.1.html)

## Preliminary Considerations

PS2 Linux ships with GCC pre-installed. This pre-installed version supports compiling binaries from C, C++, Fortran 77, and Objective-C. As such, this procedure is entirely optional.

Beyond the programming languages listed prior, GCC 2.95.2 also supports compiling binaries from Java and [CHILL](https://en.wikipedia.org/wiki/CHILL) code. The procedure outlined here will install GCC onto PS2 Linux with support for these languages enabled. The GCC version installed here will be installed alongside the pre-installed version. It will NOT replace the pre-installed GCC version.

### Limitations

At time of writing, the author has been unable to successfully compile and execute Java-based binaries on PS2 Linux. Preliminary testing showed issues with compiled binaries resulting in an "Illegal Instruction" error.

Additionally, at time of writing the author has been unable to create an installation archive for GCC 2.95.2. Therefore, this will need to be built separately on every individual PS2 Linux installation to which it will be installed.

## Extracting Required File From PS2 Linux Beta Release 1 DVD or Linux (for Playstation 2) Release 1.0 Disc 2 (directly on PS2 Linux or in Cross-Compiling Environment)

Mount the DVD as UDF.
```bash
mount -t udf /dev/cdrom /mnt/cdrom
```

Copy the **gcc-2.95.2-3a.src.rpm** file from the ```/mnt/cdrom/SRPMS/``` directory onto the system.

Unmount the DVD
```bash
umount /mnt/cdrom
```

## Building/Installing on PS2 Linux

Extract source RPM and extract source archive.
```bash
rpm2cpio /path/to/gcc-2.95.2-3a.src.rpm | cpio -id
gzip -dc gcc-2.95.2.tar.gz |tar -xvf -
cd gcc-2.95.2
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
```

&nbsp;  
Apply included patches and create build directory.
```bash
patch -p1 < ../gcc-2.95.2-frankengcc-patches.patch
patch -p1 < ../gcc-2.95.2-single-float-const.patch
patch -p1 < ../gcc-ps2linux-1.0.0.patch
mkdir build-tmp
cd build-tmp
```

&nbsp;  
Configure and build source.
```bash
../configure --prefix=/usr/local
make
make LANGUAGES="c c++ CHILL java objc f77"
```

&nbsp;  
Install to PS2 Linux (as root or via sudo)
```bash
make LANGUAGES="c c++ CHILL java objc f77" install
```

## Usage

As indicated above, this newly-installed GCC will NOT replace the GCC pre-installed on PS2 Linux. This installation will instead be installed to ```/usr/local```. To specifically execute this newly-installed version, the individual components should be executed via absolute paths:
```bash
/usr/local/bin/gcc
```

### Test Binaries

* [C](../../Toolchain/Testbin/hello.c): ```gcc -o hello-c hello.c```
* [C++](../../Toolchain/Testbin/hello.cpp): ```g++ -o hello-cpp hello.cpp```
* [Fortran 77](../../Toolchain/Testbin/hello.f): ```g77 -o hello-g77 hello.f```
* [CHILL](../../Toolchain/Testbin/hello.ch): ```chill -o hello-chill hello.ch```
* [Objective-C](../../Toolchain/Testbin/hello.m): ```gcc -o hello-objc hello.m -lobjc```

