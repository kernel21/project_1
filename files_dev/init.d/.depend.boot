TARGETS = console-setup mountkernfs.sh resolvconf ufw hostname.sh x11-common apparmor plymouth-log screen-cleanup udev cryptdisks cryptdisks-early hwclock.sh networking urandom checkroot.sh lvm2 checkfs.sh open-iscsi iscsid mountdevsubfs.sh checkroot-bootclean.sh bootmisc.sh procps mountall-bootclean.sh mountall.sh kmod mountnfs-bootclean.sh mountnfs.sh
INTERACTIVE = console-setup udev cryptdisks cryptdisks-early checkroot.sh checkfs.sh
udev: mountkernfs.sh
cryptdisks: checkroot.sh cryptdisks-early udev lvm2
cryptdisks-early: checkroot.sh udev
hwclock.sh: mountdevsubfs.sh
networking: mountkernfs.sh urandom resolvconf procps
urandom: hwclock.sh
checkroot.sh: hwclock.sh mountdevsubfs.sh hostname.sh
lvm2: cryptdisks-early mountdevsubfs.sh udev
checkfs.sh: cryptdisks lvm2 checkroot.sh
open-iscsi: networking iscsid
iscsid: networking
mountdevsubfs.sh: mountkernfs.sh udev
checkroot-bootclean.sh: checkroot.sh
bootmisc.sh: checkroot-bootclean.sh mountall-bootclean.sh mountnfs-bootclean.sh udev
procps: mountkernfs.sh udev
mountall-bootclean.sh: mountall.sh
mountall.sh: lvm2 checkfs.sh checkroot-bootclean.sh
kmod: checkroot.sh
mountnfs-bootclean.sh: mountnfs.sh
mountnfs.sh: networking
