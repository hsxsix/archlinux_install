#/bin/bash
 
 #时区   
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    hwclock --systohc --utc
#语言
    echo en_US .UTF-8 UTF-8 >> /etc/locale.gen
    echo en_US ISO-8859-1 >> /etc/locale.gen
    echo zh_CN.UTF-8 UTF-8 >> /etc/locale.gen
    echo zh_CN.GB18030 GB18030   >> /etc/locale.gen
    echo zh_CN.GBK GBK   >> /etc/locale.gen
    echo zh_CN GB2312  >> /etc/locale.gen
    locale-gen
    echo LANG=en_US.UTF-8 > /etc/locale.conf
#引导    
    pacman -S --noconfirm wicd grub
    mkinitcpio -p linux
    grub-install --target=i386-pc /dev/sda
    grub-mkconfig -o /boot/grub/grub.cfg
#用户和密码
    echo "root:PASSWORD" |chpasswd
    useradd -d /home/myusername -m myusername
    echo "myusername:PASSWORD"|chpasswd
    echo "myusername	ALL=(ALL) NOPASSWD:ALL" >>/etc/sudoers
#网络？？
    echo myhostname > /etc/hostname
    systemctl enable dhcpcd.service
    
    exit
