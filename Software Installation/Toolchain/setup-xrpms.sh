#!/bin/sh
PATH2RPMS=/mnt/cdrom/SCEI/RPMS
xtarget_arch=mipsEEel-linux

cd /usr/${xtarget_arch}/${xtarget_arch}
for r in ${PATH2RPMS}/*.rpm; do
        rpm2cpio $r | cpio -ivd
done
chmod -R 755 /usr/${xtarget_arch}/${xtarget_arch}
ln -sf usr/include sys-include
(cd usr/src && ln -sf linux-2.2.1_ps2 linux)
(cd lib && ln -sf ../usr/lib/*.o .)

# modify various build -config scripts
perl -i.bak -pe "s/\/usr/\/usr\/${xtarget_arch}\/${xtarget_arch}\/usr/g" usr/bin/{glib,gtk,libIDL,orbit}-config usr/lib/libc.so
perl -i.bak -pe "s/\/lib\/libc.so.6/\/usr\/${xtarget_arch}\/${xtarget_arch}\/lib\/libc.so.6/g" usr/lib/libc.so
rm -f usr/bin/{glib,gtk,libIDL,orbit}-config.bak usr/lib/libc.so.bak
