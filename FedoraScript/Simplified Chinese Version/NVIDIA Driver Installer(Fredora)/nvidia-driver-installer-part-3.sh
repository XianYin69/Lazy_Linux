#!/bin/bash

# =================================================================================================
# 脚本名称：   nvidia-driver-installer-part-3.sh
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
  echo -e "$RED !!!Please run as root!!! $RESET"
  exit 1
fi

#step 1
echo -e "$BLUE ==================== NVIDIA driver installer - part 3 ==================== $RESET"
echo -e "$BLUE Step 1-Enable services $RESET"
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service
MAKE[0]="CC='gcc -std=gnu17' 'make' -j16 NV_EXCLUDE_BUILD_MODULES='' KERNEL_UNAME=${kernelver} modules"
echo -e "$GREEN Services enabled $RESET"
echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" >> /etc/modprobe.d/nvidia.conf
echo "options nvidia-drm modeset=1 fbdev=1" >> /etc/modprobe.d/nvidia.conf
echo -e "$BLUE Step 2-Sing your moudle $RESET"
sudo akmods --force
sudo dracut --force
sudo mokutil --import /usr/share/nvidia/nvidia*.der
grub2-mkconfig -o /boot/grub2/grub.cfg
echo -e "$GREEN Over installed,run the nvidia settings after reboot your pc to check the situation $RESET"
read -p "Press Enter to continue or Ctrl+C to cancel..."
sudo reboot
exit 0