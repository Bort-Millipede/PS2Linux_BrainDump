# Adding System Users to PSBBN

By default, PSBBN executes commands as the ```bn``` user. This user does not have a password set in the ```/etc/shadow``` file. For that reason and others, it would be more feasible to create another system user. 

## Prerequisites

If the user being created is the first system user besides ```bn```, this should be accomplished by [Chrooting into PSBBN from PS2 Linux](../Chrooting&#32;Into&#32;PSBBN).

If the user being created is yet another system user, this can be accomplished in Chroot, Telnet, or SSH. For Telnet or SSH, root access or a system user with sudoer rights (requiring that ```sudo``` and ```Vim``` are installed on PSBBN: outlined [HERE](../Software&#32;Installation)) is required.

## Creating User

**NOTE:** If creating the new user via Telnet or SSH, all commands below must be executed as root or via sudo.

In case the ```/home``` directory does not already exist, create it with the following command.
```bash
mkdir -p /home
```

&nbsp;  
Create the user (ex. **ps2**).
```bash
useradd -d /home/ps2 -s /bin/bash -m ps2
```

&nbsp;  
Set a password for the newly-created user.
```bash
passwd ps2
```

