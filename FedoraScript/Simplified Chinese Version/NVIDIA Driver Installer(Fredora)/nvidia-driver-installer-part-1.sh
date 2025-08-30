#!/bin/bash

# =================================================================================================
# 脚本名称：   nvidia-driver-installer-part-1.sh
# 描述：       NVIDIA驱动安装脚本 - 第1部分
#              执行系统状态检查和初始化清理操作
# 作者：       XianYin
# 参考来源：   https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/
# 日期：       2025-08-19
# =================================================================================================

readonly RED="\033[31m"
readonly GREEN="\033[32m"
readonly YELLOW="\033[33m"
readonly BLUE="\033[34m"
readonly RESET="\033[0m"

#root check
if [ $EUID -ne 0 ]; then
  echo -e "$RED 请以root用户身份运行此脚本 $RESET"
  exit 1
fi

#step 1
echo  -e "$BLUE ==================== NVIDIA驱动安装脚本 - 第1部分 ==================== $RESET"
echo  -e "$BLUE 步骤 1-安装必要软件包 $RESET"
sudo dnf update -y
sudo dnf install -y @base-x kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig xorg-x11-server-Xwayland libxcb egl-wayland akmods vdpauinfo libva-vdpau-driver libva-utils
echo -e "$GREEN 必要软件包安装完成 $RESET"

#step 2
echo  -e "$BLUE 步骤 2-禁用nouveau $RESET"
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
echo "blacklist nova_core" >> /etc/modprobe.d/blacklist.conf
echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" >> /etc/modprobe.d/nvidia.conf
echo "options nvidia-drm modeset=1 fbdev=0" >> /etc/modprobe.d/nvidia.conf
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau-nova.img 
sudo dracut /boot/initramfs-$(uname -r).img $(uname -r)
echo -e "$GREEN nouveau禁用完成 $RESET"

echo -e "$RED 现在需要重启电脑 $RESET"
read -p "按回车键继续，按Ctrl+C取消..."
sudo reboot
exit 0