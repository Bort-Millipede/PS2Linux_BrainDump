# Netcat 1.10

[Source link](https://sourceforge.net/code-snapshots/git/n/nc/nc110/git.git/nc110-git-607401678236b608280b291ad849a109b8d9a8f2.zip) (downloaded file renamed to nc110.zip)  
**Build type**: cross-compiling (on system with ```mipsEEel-linux-*``` toolchain installed)

## Building

Extract source archive and rename source directory.
```bash
unzip nc110.zip
mv nc110-git-* nc110
cd nc110
```

&nbsp;  
Configure for cross-compiling, then build
```bash
perl -i.bak -pe "s/CC = cc/CC = mipsEEel-linux-gcc/" Makefile
make generic
```

## Installing on PS2 Linux (as root)

transfer **nc** binary to PS2 Linux and install
```bash
cp /path/to/nc /usr/local/bin/nc
chmod 755 /usr/local/bin/nc
```

