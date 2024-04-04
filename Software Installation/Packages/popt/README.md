## popt 1.7

[Source link](https://web.archive.org/web/20070321192844/http://gd.tuwien.ac.at/utils/rpm.org/dist/rpm-4.1.x/popt-1.7.tar.gz)  
Build type: cross-compiling (on system with mipsEEel-linux-* toolchain installed)

#popt library (to be installed on cross-pc):
tar xzf popt-1.7.tar.gz
cd popt-1.7

export PREFIX=/usr/mipsEEel-linux/mipsEEel-linux/usr

for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-* /" "$f"; done

./configure --prefix=$PREFIX --host=mipsEEel-linux --enable-shared
make
make install


#popt library (to be installed on PS2 Linux):
#if using same extracted directory, skip these
tar xzf popt-1.7.tar.gz
cd popt-1.7

export PREFIX=/usr/local

#if using same extracted directory, skip these
for f in `find . -name config.sub`; do perl -i.bak -pe "s/\| mipsel /\| mipsel \| mipsEEel /" "$f"; done
for f in `find . -name config.sub`; do perl -i -pe "s/\| mipsel-\* /\| mipsel-\* | mipsEEel-* /" "$f"; done

make distclean #any errors can be ignored if not using same extracted directory

./configure --prefix=$PREFIX --host=mipsEEel-linux --enable-shared
make
rm -rf usr
make DESTDIR=`pwd` install
tar czf popt-1.7.mipsEEel-linux.tar.gz usr


#Installing popt library on PS2 Linux (as root):
#ensure /usr/local/lib is added to /etc/ld.so.conf
cd /
tar xzf /path/to/popt-1.7.mipsEEel-linux.tar.gz
/sbin/ldconfig

