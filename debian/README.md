## Use fdisk to create partitions

Partitions layout should be something like this:
```
Device     Boot   Size  Id   Type
/dev/sda1  *      256M  83   Linux
/dev/sda2          20G  8e   Linux LVM
```

## Create LVM and file systems

Run `partitions_setup.sh`

## Creating installation environment

Run `create_env.sh`

## Installing system

Run `install.sh`

## Post install procedures

Run `setup.sh`

## fstab creation

Run `gen_fstab.sh`

## Other

Now you need to setup network in `/etc/network/interfaces` and preferred apt
sources in `/etc/apt/sources.list`
