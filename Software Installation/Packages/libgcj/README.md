# libgcj 2.95.1

**Note:** Precompiled Binaries ([libgcj-2.95.1.mipsEEel-linux.tar.gz](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases/download/initial/libgcj-2.95.1.mipsEEel-linux.tar.gz)) are available in [Releases](https://github.com/Bort-Millipede/PS2Linux_BrainDump/releases)!

Source: libgcj-2.95.1.tar.gz present on [PS2 Linux Beta Release 1 DVD](https://archive.org/download/sony_playstation2_p/PS2%20Linux%20Beta%20Release%201%20%28Japan%29%20%28En%2CJa%29.zip) and [Linux (for Playstation 2) Release 1.0 Disc 2](https://archive.org/download/sony_playstation2_l/Linux%20%28for%20PlayStation%202%29%20Release%201.0%20%28USA%29%20%28Disc%202%29%20%28Software%20Packages%29.zip) under ```SOURCES``` (the files present on both discs are identical).  
**Build type:** native (directly on PS2 Linux)

## Prerequisites

### Preliminary Considerations

libgcj is the Java runtime that goes along with the ```gcj``` front end to GCC. Other software may also require this as a dependency.

Beyond this, libgcj is required for compiling Java code into native binaries via ```gcj```. At time of writing, the author has not been able to do this successfully for PS2 Linux, both via native compiling and cross-compiling. As such, building and installing this library onto PS2 Linux and into the cross-compiling environment for the purpose of compiling/cross-compiling Java binaries is purely optional.

To directly leverage this library to compile Java binaries, a native version of ```gcj``` must be built and installed directly on PS2 Linux. However, preliminary testing by the author showed issues with compiled binaries resulting in an "Illegal Instruction" (SIGILL) error. Executing the compiled binaries through a debugger showed "Segmentation Fault" (SIGSEGV) and "Bus Error" (SIGBUS) errors preceding the "Illegal Instruction" (SIGILL) error.

![](gcj_illegal_instruction_error.png?raw=true)  
*Illegal Instruction error when executing Java binary compiled with gcj*

![](gcj_strace_SIGSEGV_SIGBUS_SIGILL.png?raw=true)  
*Debugger showing SIGSEGV and SIGBUS errors preceding SIGILL error*

### Dependencies

* gcj 2.95.2: via [manually-built gcc 2.95.2](../gcc) installed alongside pre-installed version. Full source/build directory from this should be available on PS2 Linux when building libgcj (see "Troubleshooting" below).

## Extracting Required File From PS2 Linux Beta Release 1 DVD or Linux (for Playstation 2) Release 1.0 Disc 2 (directly on PS2 Linux or in Cross-Compiling Environment)

Mount the DVD as UDF.
```bash
mount -t udf /dev/cdrom /mnt/cdrom
```

Copy the **libgcj-2.95.1.tar.gz** file from the ```/mnt/cdrom/SOURCES/``` directory onto the system.

Unmount the DVD
```bash
umount /mnt/cdrom
```

## Building/Installing on PS2 Linux

Extract source archive.
```bash
tar xzf /path/to/libgcj-2.95.1.tar.gz
cd libgcj-2.95.1
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/local
```

&nbsp;  
Edit **mach_dep.c** file to prevent build failure.
```
perl -i.bak -pe "s/--> bad news <--/\/\/--> bad news <--/" boehm-gc/mach_dep.c
```

&nbsp;  
Create build directory.
```
mkdir build
cd build
```

&nbsp;  
Configure and build source.
```bash
../configure --prefix=$PREFIX
make
```

&nbsp;  
Edit generated Makefiles to enable DESTDIR support.
```bash
perl -i.bak -pe "s/\t\\$\(prefix\) \\\\/\t\\$\(DESTDIR\)\\$\(prefix\) \\\\/" Makefile
perl -i -pe "s/\t\\$\(exec_prefix\)/\t\\$\(DESTDIR\)\\$\(exec_prefix\)/" Makefile
for f in `find . -name Makefile`; do perl -i.bak -pe "s/^DESTDIR =$/# DESTDIR =/" "$f"; done
```

&nbsp;  
Install to current directory (as root or via sudo)  
**Note:** this process fails if not executed as root or via sudo. It seems that an actual system installation takes place, as well as an installation to the current directory. This is why an additional "unmodified" installation is executed again later.
```bash
rm -rf usr/
make DESTDIR=`pwd` install
```

&nbsp;  
Create installation archive (for easy installation onto future PS2 Linux installs).
```bash
tar czf libgcj-2.95.1.mipsEEel-linux.tar.gz usr
```

&nbsp;  
Revert Makefile edits.
```bash
for f in `find . -name "Makefile.bak"`; do cp "$f" "`echo $f | rev | cut -d"." -f 2- | rev`"; done
```

&nbsp;  
Install to PS2 Linux (as root or via sudo).
```bash
make install
```

## Building for Cross-Compiling Environment as Software Dependency

Extract source archive. Do NOT use the same extracted directory as was used above.
```bash
tar xzf /path/to/libgcj-2.95.1.tar.gz
mv libgcj-2.95.1_ummu
cd libgcj-2.95.1_ummu
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr
```

&nbsp;  
Edit **mach_dep.c** file to prevent build failure
```
perl -i.bak -pe "s/--> bad news <--/\/\/--> bad news <--/" boehm-gc/mach_dep.c
```

&nbsp;  
Create build directory
```
mkdir build
cd build
```

&nbsp;  
Configure and build source
```bash
../configure --prefix=$PREFIX
make
```

&nbsp;  
Edit generated Makefiles to enable DESTDIR support. Then install to current directory and create installation archive (for easy installation onto future PS2 Linux installs).
```bash
perl -i.bak -pe "s/\t\\$\(prefix\) \\\\/\t\\$\(DESTDIR\)\\$\(prefix\) \\\\/" Makefile
perl -i -pe "s/\t\\$\(exec_prefix\)/\t\\$\(DESTDIR\)\\$\(exec_prefix\)/" Makefile
for f in `find . -name Makefile`; do perl -i.bak -pe "s/^DESTDIR =$/# DESTDIR =/" "$f"; done
rm -rf usr/
make DESTDIR=`pwd` install
tar czf libgcj-2.95.1.mipsEEel-linux.cross-pc_ummu.tar.gz usr
```

### Installing on Cross-Compiling Environment as Software Dependency (as root)

Transfer **libgcj-2.95.1.mipsEEel-linux.cross-pc_ummu.tar.gz** archive to system with ```mipsEEel-linux-*``` toolchain installed, and install.
```bash
cd /
tar xzf /path/to/vcdimager-0.7.21.mipsEEel-linux.cross-pc_ummu.tar.gz usr
```

## Building for Cross-Compiling Environment for Cross-Compiling

Extract source archive. Do NOT use the same extracted directory as was used above.
```bash
tar xzf /path/to/libgcj-2.95.1.tar.gz
mv libgcj-2.95.1_um
cd libgcj-2.95.1_um
```

&nbsp;  
Set necessary environment variables.
```bash
export PREFIX=/usr/mipsEEel-linux
```

&nbsp;  
Edit **mach_dep.c** file to prevent build failure
```
perl -i.bak -pe "s/--> bad news <--/\/\/--> bad news <--/" boehm-gc/mach_dep.c
```

&nbsp;  
Create build directory
```
mkdir build
cd build
```

&nbsp;  
Configure and build source
```bash
../configure --prefix=$PREFIX
make
```

&nbsp;  
Edit generated Makefiles to enable DESTDIR support. Then install to current directory and create installation archive (for easy installation onto future PS2 Linux installs).
```bash
perl -i.bak -pe "s/\t\\$\(prefix\) \\\\/\t\\$\(DESTDIR\)\\$\(prefix\) \\\\/" Makefile
perl -i -pe "s/\t\\$\(exec_prefix\)/\t\\$\(DESTDIR\)\\$\(exec_prefix\)/" Makefile
for f in `find . -name Makefile`; do perl -i.bak -pe "s/^DESTDIR =$/# DESTDIR =/" "$f"; done
rm -rf usr/
make DESTDIR=`pwd` install
tar czf libgcj-2.95.1.mipsEEel-linux.cross-pc_um.tar.gz usr
```

### Installing on Cross-Compiling Environment for Cross-Compiling (as root)

Transfer **libgcj-2.95.1.mipsEEel-linux.cross-pc_um.tar.gz** archive to system with ```mipsEEel-linux-*``` toolchain installed, and install.
```bash
cd /
tar xzf /path/to/vcdimager-0.7.21.mipsEEel-linux.cross-pc_um.tar.gz usr
```

## Troubleshooting

If any of the above builds fail with a missing **gcc** directory error, here is a possible fix:  
Create a symbolic link in the ```libgcj-2.95.1/build``` directory to the source/build directory from ```gcj 2.95.2``` that was built earlier:
```bash
ln -s /path/to/gcc-2.95.2/build-tmp/gcc gcc
```

