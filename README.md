build a grub efi executable
===========================

an example grubx86.efi loader embedding an early configuration file

can load modules before the actual configuration file grub.cfg or
loading it from non-standard locations


run
---

set the UUID of the EFI partition and the partition that contains the actual
configuration file grub.cfg in the Makefile

find UUIDs from /dev/disk/by-uuid


internals
---------

the grub executable contains an early configuration file:

- set the grub root as the linux root
- (other, like setting the terminal or loading other modules)
- load the actual configuration file

the modules loaded in the executable because they are required by the commands
in the early configuration file are in modules.txt



notes
-----

- useful when grub does not find the normal configuration file
- setting the terminal can be done in the normal configuration file too

