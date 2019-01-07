# lsblk output

When using the `-l` and `-O` arguments:

```
NAME KNAME MAJ:MIN FSTYPE MOUNTPOINT LABEL UUID                                 PARTTYPE PARTLABEL PARTUUID                             PARTFLAGS   RA RO RM HOTPLUG MODEL            SERIAL               SIZE STATE   OWNER GROUP MODE       ALIGNMENT MIN-IO OPT-IO PHY-SEC LOG-SEC ROTA SCHED RQ-SIZE TYPE DISC-ALN DISC-GRAN DISC-MAX DISC-ZERO WSAME WWN RAND PKNAME HCTL       TRAN SUBSYSTEMS      REV VENDOR   ZONED
sda  sda     8:0                                                                                                                                  4096  0  0       0 VBOX HARDDISK    VB273a1a53-4302f796   32G running root  disk  brw-rw----         0    512      0     512     512    1 cfq       128 disk        0        0B       0B         0    0B        1        0:0:0:0    ata  block:scsi:pci 1.0  ATA      none
sda1 sda1    8:1   ext4   /boot            05b58824-96c1-45e1-b545-c88828cf8d01 0x83               1dc4a209-01                          0x80      4096  0  0       0                                         1G         root  disk  brw-rw----         0    512      0     512     512    1 cfq       128 part        0        0B       0B         0    0B        1 sda                    block:scsi:pci               none
sda2 sda2    8:2   swap   [SWAP]           8eab6c5d-e327-4faa-910a-53e3f74edfc6 0x82               1dc4a209-02                                    4096  0  0       0                                       2.1G         root  disk  brw-rw----         0    512      0     512     512    1 cfq       128 part        0        0B       0B         0    0B        1 sda                    block:scsi:pci               none
sda3 sda3    8:3   xfs    /                043ca5fa-b051-4f10-a69a-eadbff6a0229 0x83               1dc4a209-03                                    4096  0  0       0                                        15G         root  disk  brw-rw----         0    512      0     512     512    1 cfq       128 part        0        0B       0B         0    0B        1 sda                    block:scsi:pci               none
```

When using the `-P` argument instead of `-l`:

```

```

## Explanation of fields

```
        NAME  device name
       KNAME  internal kernel device name
       KNAME  internal kernel device name
     MAJ:MIN  major:minor device number
      FSTYPE  filesystem type
  MOUNTPOINT  where the device is mounted
       LABEL  filesystem LABEL
        UUID  filesystem UUID
          RA  read-ahead of the device
          RO  read-only device
          RM  removable device
       MODEL  device identifier
        SIZE  size of the device
       STATE  state of the device
       OWNER  user name
       GROUP  group name
        MODE  device node permissions
   ALIGNMENT  alignment offset
      MIN-IO  minimum I/O size
      OPT-IO  optimal I/O size
     PHY-SEC  physical sector size
     LOG-SEC  logical sector size
        ROTA  rotational device
       SCHED  I/O scheduler name
     RQ-SIZE  request queue size
        TYPE  device type
    DISC-ALN  discard alignment offset
   DISC-GRAN  discard granularity
    DISC-MAX  discard max bytes
   DISC-ZERO  discard zeroes data
```