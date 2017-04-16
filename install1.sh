#/bin/bash
# 请不要随意更改两个文件名 ins2.sh为第二个文件的名称
#分区
    parted /dev/sda mklabel gpt
    parted /dev/sda mkpart primary ext4 0% 3M    #sda1
    parted /dev/sda set 1 bios_grub on
    parted /dev/sda mkpart primary ext4 3M 6G    #sda2
    parted /dev/sda set 2 boot on
    parted /dev/sda mkpart primary ext4 6G 100%    #sda3
    mkfs.ext4 /dev/sda2
    mkfs.ext4 /dev/sda3

    mount /dev/sda2 /mnt
    mkdir /mnt/home
    mount /dev/sda3 /mnt/home
 
 #安装基本系统   
     echo Server = http://mirrors.aliyun.com/archlinux/\$repo/os/\$arch > /etc/pacman.d/mirrorlist
    pacstrap -i  /mnt base base-devel
    genfstab -U /mnt >> /mnt/etc/fstab
#    cp -p /etc/resolv.conf /mnt/etc/resolv.conf    #？？
#初步配置
    cp -p ins2.sh /mnt/ins2.sh
    arch-chroot /mnt /ins2.sh
    rm /mnt/ins2.sh
#退出重启    
    umount -R /mnt 
    reboot

