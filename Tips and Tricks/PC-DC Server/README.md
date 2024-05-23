# PC-DC Server on PS2 Linux

A PC-DC Server for connecting a Sega Dreamcast console to the internet can be setup on PS2 Linux with relative ease. Luckily, the software required to set this up (mgetty and pppd) comes pre-installed on PS2 Linux.

## References

* [https://www.dreamcast-talk.com/forum/app.php/page/ryochanpart0](https://www.dreamcast-talk.com/forum/app.php/page/ryochanpart0)

## Preliminary Considerations

This page only describes how to set up the PC-DC Server on PS2 Linux. It does NOT describe how to configure the Dreamcast console to use the PC-DC Server, how to construct or use a voltage line inducer, or any other procedures that may be required to get all of this work. The original PC-DC Server tutorial cited above should be consulted before performing any of the operations outlined on this page. The original tutorial can be followed mostly as-is to get the server working on PS2 Linux. This page should serve as an equivalency to Part 1 and a partial equivalency to Part 3 of the original tutorial.

Getting this server properly setup requires the use of a [USB Dial-Up Modem](../../USB&#32;Devices/Modems). This tutorial assumes that the modem device is registered as ```/dev/ttyACM0``` (this should be confirmed via ```dmesg``` output). As such, a configuration file leveraged by pppd is created with the filename ```options.ttyACM0```. If the modem device is registered as something else, the file extension should be changed to match the device. Additionally, any ```/dev/ttyACM0``` references in commands below should be changed to the correct device.

In the author's experience, the PC-DC Server only works on Kernels 2.2.1 and 2.2.19. This does not seem to work properly on Kernel 2.4.17_mvl21. The suspected root causes of this are
* mgetty and/or pppd must be compiled against a 2.4.x kernel in order to properly support a PC-DC Server.
* More fine-tuning of mgetty and/or pppd is required to setup a working PC-DC Server on a 2.4.x kernel.

Regardless of the actual root cause(s), the author did not perform any additional analysis to confirm and/or resolve the issues.

On PS2 Linux Release 1.0, it may be possible to use the dial-up modem included in the North American Playstation 2 Network Adapter. But this has not been fully researched by the author.

## Configuring PS2 Linux for a PC-DC Server (as root)

Backup stock configuration files for mgetty
```bash
cp /etc/mgetty+sendfax/dialin.config /etc/mgetty+sendfax/dialin.config.bak
cp /etc/mgetty+sendfax/login.config /etc/mgetty+sendfax/login.config.bak
cp /etc/mgetty+sendfax/mgetty.config /etc/mgetty+sendfax/mgetty.config.bak
```

&nbsp;  
Backup stock configuration files for pppd
```bash
cp /etc/ppp/options /etc/ppp/options.bak
cp /etc/ppp/pap-secrets /etc/ppp/pap-secrets.bak
```

&nbsp;  
Create system user (can be called literally anything, but most often ```dream``` is used, including by the author below) to be used for the PC-DC Server.
```bash
useradd -G dip,users,pppusers -c "Dreamcast user" -d /home/dream -g users -s /usr/sbin/pppd dream
```

&nbsp;  
Set password for newly-created user. A password containing only alphanumerics is recommended by the author (the way in which special characters are interpreted in pppd configuration files is unclear, and therefore special characters are not recommended to be used here).
```bash
passwd dream
```

&nbsp;  
Install [dialin.config](dialin.config), [login.config](login.config), and [mgetty.config](mgetty.config) configuration files for mgetty.
```bash
cp /path/to/dialin.config /path/to/login.config /path/to/mgetty.config /etc/mgetty+sendfax/.
chmod 600 /etc/mgetty+sendfax/dialin.config
chmod 600 /etc/mgetty+sendfax/login.config
chmod 600 /etc/mgetty+sendfax/mgetty.config
```

&nbsp;  
Edit the pppd [options](options) configuration file and replace ```X.X.X.X``` with the IP address of the DNS server that the Dreamcast console should use. In most cases, this will be the IP address of the user's home router which also contains a DNS server.

&nbsp;  
Edit the pppd [pap-secrets](pap-secrets) configuration file. Replace ```USERHERE``` with the name of the user created earlier. Replace ```PASSWORDHERE``` with the password for the user.

&nbsp;  
Edit the [options.ttyACM0](options.ttyACM0) configuration file. Replace ```M.M.M.M``` with the subnet mask used by the network that PS2 Linux is connected to (usually ```255.255.255.0```). Replace ```X.X.X.X``` with the start of the range of IP addresses to be allocated by the PC-DC Server (such as ```192.168.1.100```), and replace ```Y.Y.Y.Y``` with the end of the range (such as ```192.168.1.101```).

&nbsp;  
Install the edited configuration files for pppd
```bash
cp /path/to/options /path/to/options.ttyACM0 /path/to/pap-secrets /etc/ppp/.
chmod 600 /etc/ppp/options
chmod 600 /etc/ppp/options.ttyACM0
chmod 600 /etc/ppp/pap-secrets
```

## Using the PC-DC Server on PS2 Linux (as root or via sudo)

This procedure requires either two or three open terminal sessions open:
* The first session executes mgetty, which waits for an initial connection from the Dreamcast console. This session is HIGHLY recommended by the author to be established as a local session directly on PS2 Linux (NOT an SSH session).
* The second session is leveraged to send a signal to the mgetty process which "answers the phone" and fully establishes the connection between the Dreamcast console and PS2 Linux. This session can be established either locally on PS2 Linux or via SSH.
* The third session (which is optional, but can be leveraged to diagnose issues) monitors the log file from the mgetty session and displays information indicating the state of the Dreamcast and PS2 Linux connection. This session can be established either locally on PS2 Linux or via SSH.

&nbsp;  
Power on the Dreamcast console, load the game/software that will be connecting to the internet, and navigate to the menu/etc. to initiate the dialing sequence. But do NOT initiate the dialing sequence yet!

&nbsp;  
If not done already: On PS2 Linux, load the kernel driver for the USB modem device using the command below, then plug the device in and connect the Dreamcast modem to it.
```bash
/sbin/insmod acm
```

### Setting up connection between Dreamcast and PS2 Linux

In the first session on PS2 Linux: execute mgetty.
```bash
/sbin/mgetty -D /dev/ttyACM0 -m '"" ATM0'
```

&nbsp;  
In the second session on PS2 Linux: type the following command into the session but DO NOT execute it yet!
```bash
killall -USR1 mgetty
```

&nbsp;  
**(OPTIONAL)** In the third session on PS2 Linux: Execute the following command to display the log file for the mgetty process.
```bash
tail -f /var/log/mgetty.log.ttyACM0
```

&nbsp;  
On the Dreamcast console: initiate the dialing sequence.  
In the second session on PS2 Linux: wait about 5 seconds, then execute the ```killall``` command typed out earlier.

&nbsp;  
&nbsp;  
As long as the above procedure was followed correctly, the Dreamcast console should successfully connect to the PC-DC Server and should receive an internet connection. If the connection is ever closed for any reason, it can be re-established be re-following the steps above.

