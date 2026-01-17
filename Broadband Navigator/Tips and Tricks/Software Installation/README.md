# Software Installation in PSBBN

New software can be installed to PSBBN via prebuilt RPM packages.

Software can also likely be installed to PSBBN after first being built from source (via cross-compiling or by building on PS2 Linux first). However, no such installations have been attempted or tested by the author.

## Prerequisites

Installing new software requires accessing PSBBN in one of the following ways:
* By accessing SSH or Telnet on a running PSBBN installation (if accessing as a non-root user, requires sudoer rights on PSBBN).
* By [Chrooting into PSBBN from PS2 Linux](../Chrooting&#32;Into&#32;PSBBN).

## Installation

To install an RPM package in PSBBN, execute the following command (within Chroot, or directly on PSBBN as root or via sudo).
```bash
rpm -i PACKAGE.rpm
```

![](install_rpm.png?raw=true)  
*Installing Vim on PSBBN*

## Recommended Packages to Install

### Sudo & Vim

The author recommends installing the following RPM packages from PS2 Linux Release 1.0 onto PSBBN:
* sudo-1.6.3p3-5.mipsel.rpm
* vim-common-5.6-13.mipsel.rpm
* vim-minimal-5.6-13.mipsel.rpm

This allows non-admin users to execute commands via ```sudo```. Granting sudoer rights to non-admin users requires a console text editor, and therefore the Vim editor is also installed.

### SSH

To install SSH on PSBBN, the following RPM packages from PS2 Linux Release 1.0 must be installed:
* openssl-0.9.6b-2.mipsel.rpm
* openssh-2.9p1-7.mipsel.rpm
* openssh-server-2.9p1-7.mipsel.rpm
* openssh-clients-2.9p1-7.mipsel.rpm

It is recommended to install SSH using Telnet, as installing via Chroot may result in errors during host key generation (issues with ```/dev/urandom```).

