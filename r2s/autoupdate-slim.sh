#!/bin/sh

cd /mnt/mmcblk0p2
rm -rf FriendlyWrt*img* R2S*
wget https://github.com/ardanzhu/Opwrt_Actions/releases/download/R2S/R2S-slim-$(date +%Y-%m-%d).zip
if [ -f /mnt/mmcblk0p2/R2S*.zip ]; then
	echo -e '\e[92m今天固件已下载，准备解压\e[0m'
else
	echo -e '\e[91m今天的固件还没更新，尝试下载昨天的固件\e[0m'
	wget https://github.com/ardanzhu/Opwrt_Actions/releases/download/R2S/R2S-slim-$(date -d "@$(( $(busybox date +%s) - 86400))" +%Y-%m-%d).zip
	if [ -f /mnt/mmcblk0p2/R2S*.zip ]; then
		echo -e '\e[92m昨天的固件已下载，准备解压\e[0m'
	else
		echo -e '\e[91m没找到最新的固件，脚本退出\e[0m'
		exit 1
	fi
fi
unzip R2S*.zip
rm R2S*.zip
if [ -f /mnt/mmcblk0p2/FriendlyWrt*.img.gz ]; then
	pv /mnt/mmcblk0p2/FriendlyWrt*.img.gz | gunzip -dc > FriendlyWrt.img
	echo -e '\e[92m准备解压镜像文件\e[0m'
fi
rm -rf /mnt/img
mkdir /mnt/img
losetup -o 100663296 /dev/loop0 /mnt/mmcblk0p2/FriendlyWrt.img
mount /dev/loop0 /mnt/img
echo -e '\e[92m解压已完成，准备编辑镜像文件，写入备份信息\e[0m'
cd /mnt/img
sysupgrade -b /mnt/img/back.tar.gz
tar zxf back.tar.gz
echo -e '\e[92m备份文件已经写入，移除挂载\e[0m'
rm back.tar.gz
cd /tmp
umount /mnt/img
losetup -d /dev/loop0
echo -e '\e[92m准备重新打包\e[0m'
zstdmt /mnt/mmcblk0p2/FriendlyWrt.img -o /tmp/FriendlyWrtupdate.img.zst
echo -e '\e[92m打包完毕，准备刷机\e[0m'
if [ -f /tmp/FriendlyWrtupdate.img.zst ]; then
	echo 1 > /proc/sys/kernel/sysrq
	echo u > /proc/sysrq-trigger || umount /
	pv /tmp/FriendlyWrtupdate.img.zst | zstdcat | dd of=/dev/mmcblk0 conv=fsync
	echo -e '\e[92m刷机完毕，正在重启...稍等片刻后重新登录\e[0m'	
	echo b > /proc/sysrq-trigger
fi
