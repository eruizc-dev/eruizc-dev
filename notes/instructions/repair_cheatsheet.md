## Disk Drives

### List drives

 - `lsblk`
 - `fdisk -l`

### Repartition drive

Use `fdisk [drive]`

```
fdisk /dev/sda
```

### Format partition

Use `mkfs -t {ext4,ntfs,fat32}`

```
mkfs -t ext4 /dev/sda1
```

### Wipe drive

Overwrite disk with zeros
Use `dd if=/dev/zero of=[drive] bs=1M status=progress`

Overwrite partition with zeros

Use `dd if=/dev/zero of=[partition] bs=1M status=progress`

Can also replace `/dev/zero` with `/dev/urandom`

<https://www.looklinux.com/how-to-wipe-hard-drive-clean-using-dd-command-in-linux>

### Recover data

Use `ddrescue`

```
ddrescue -d -r1 /dev/sda ./backup.raw ./backup.log
```

<https://www.youtube.com/watch?v=ddrPnuvFV6E>
