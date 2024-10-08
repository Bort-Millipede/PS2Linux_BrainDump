# PS2 Linux Kit Comparison (Beta and Release)

## General Differences

The Beta kit was only released in Japan. It was intended to be installed and used only on the following Playstation 2 hardware revisions (released only in Japan):
* A-chassis (v0): SCPH-10000, SCPH-15000
* A+-chassis (v0): SCPH-18000
* AB-chassis (v0): SCHP-18000

Because these units contain a PCMCIA bay instead of an Expansion Bay, the Beta kit was only intended to be used in conjunction with the PC card network adapter (SCPH-10190) and 40GB external HDD unit (SCPH-20400 with SCPH-10200 AC adapter). These items all came packaged together (SCPH-10210 or SCPH-10270K).

The Release kit was released in Japan, USA, and Europe. It was intended to be installed on the following Playstation 2 hardware revisions:
* B-chassis: SCPH-30001
* B'-chassis: SCPH-30001
* C-chassis: SCPH-30001 - SCPH-30004
* C'-chassis: SCPH-30001 - SCPH-30004
* D-chassis: SCPH-3000X, SCPH-3500X
* D'-chassis: SCPH-3000X, SCPH-3500X
* F-chassis: SCPH-3000X R
* G-chassis: SCPH-390XX, SCPH-37000

The Release kit could also be installed on the following hardware revisions with some modifications:
* H-chassis: SCPH-500XX, SCPH-55000 GU, SCPH-5500X G
* I-chassis: SCPH-500XX, SCPH-55000 GT
* J-chassis: SCPH-50000, SCPH-50004

The Releast kit required the use of an Expansion Bay network adapter and an internal HDD (SCPH-20401). Despite Sony claiming that the Release kit could only be used with an official PS2 HDD, OEM IDE drives (40GB and larger) work seamlessly with the Release kit without any additional required configurations/modifications.

Neither the Beta kit nor the Release kit could be installed and used on the slim Playstation 2 hardware revisions.

## Installed Package Comparison

When installing either the PS2 Linux Beta or Release kits and selecting all available packages during installation, both kits appear to install very similar packages.

### Simple Differences:

* For packages that are installed on both the Beta and Release kits, the package versions are almost identical: the Release kit mostly uses packages with a release number 1 higher than those used by the Beta kit.
  * Example: ```bash-1.14.7-23``` on PS2 Linux Beta Release 1, ```bash-1.14.7-24``` on PS2 Linux Release 1.0

### Noticeable Differences

* The OpenSSH packages used by the Beta kit are version ```2.3.0p1-5```, while the packages used by the Release kit are version ```2.9p1-7```.
* The Beta kit ships with an official SCEI version of ```ps2fdisk``` installed, because the Beta kit uses APA partitioning (the legacy version) by default.
* The Beta kit ships with various packages that seem to target (either exclusively or in conjunction with) the DTL-T10000 (the [PS2 TOOL](https://www.psdevwiki.com/ps2/PlayStation_2_Tool)) development unit. These include:
  * ```ee_powctrld-1.0-5EE```
  * ```kernel-modules-2.2.1_ps2-6```: Loadable kernel modules for the PS2 TOOL are included under ```lib/modules/2.2.1_t10000``` (which is also installed to PS2 Linux Beta by default).
* The Release kit ships with the Apache ```mod_ssl``` module package, while the Beta kit does not.

### [Full Installed Package Comparison](Installed&#32;Packages)

### Kernel Differences

Both the Beta kit and the Release kit ship with Kernel 2.2.1. The kernel that comes installed on the Beta kit is 2.2.1_ps2-6, whereas the kernel that comes installed on the Release kit is 2.2.1_ps2-7. It seems that a fair amount of the kernel source (especially items compiled as kernel modules by default, such as PS2-specific devices) was deliberately omitted from the available 2.2.1_ps2-6 kernel source RPMs.

## Other Differences

The OpenSSH Server that ships with the Beta kit is much less stable than the OpenSSH Server that ships with the Release kit. Sessions established on the Beta kit often timeout after a while, with the console session suddenly freezing up and no longer accepting user input. This necessitates establishing an entirely new SSH session.

Additionally, SFTP sessions established on the Beta kit OpenSSH server cannot seem to retrieve remote folder contents correctly.

The issues outlined above do not appear to be present in the Release kit OpenSSH server.

## References

* [https://www.psdevwiki.com/ps2/Chassis_types](https://www.psdevwiki.com/ps2/Chassis_types)
* [https://www.psdevwiki.com/ps2/Hard_Drive](https://www.psdevwiki.com/ps2/Hard_Drive)

