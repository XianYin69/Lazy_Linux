#!/bin/bash

# =================================================================================================
# 脚本名称：   nvidia-driver-installer-part-3.sh
# 描述：       NVIDIA驱动安装脚本 - 第3部分
#              启用服务并签署内核模块
# 作者：       XianYin_69
# 参考来源：   https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/
# 日期：       2025-08-19
# =================================================================================================

# --- 颜色常量定义 ---
readonly COLOR_INFO="\033[34m"      # 蓝色
readonly COLOR_SUCCESS="\033[32m"    # 绿色
readonly COLOR_ERROR="\033[31m"      # 红色
readonly COLOR_WARN="\033[33m"       # 黄色
readonly COLOR_RESET="\033[0m"       # 重置颜色

# --- 日志工具函数 ---
log_info() {
    echo -e "${COLOR_INFO}[Info]${COLOR_RESET} $1"
}

log_success() {
    echo -e "${COLOR_SUCCESS}[Success]${COLOR_RESET} $1"
}

log_error() {
    echo -e "${COLOR_ERROR}[Error]${COLOR_RESET} $1"
}

log_warn() {
    echo -e "${COLOR_WARN}[Warning]${COLOR_RESET} $1"
}

#root check
if [ $EUID -ne 0 ]; then
  echo -e "$RED !!!Please run as root!!! $RESET"
  exit 1
fi

#step 1
echo  " ==================== NVIDIA driver installer - part 3 ==================== "
echo  " Step 1-Enable services "
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service
MAKE[0]="CC='gcc -std=gnu17' 'make' -j16 NV_EXCLUDE_BUILD_MODULES='' KERNEL_UNAME=${kernelver} modules"
echo -e "$COLOR_SUCCESS Services enabled $COLOR_RESET"
echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" >> /etc/modprobe.d/nvidia.conf
echo "options nvidia-drm modeset=1 fbdev=1" >> /etc/modprobe.d/nvidia.conf
echo  " Step 2-Sing your moudle "
sudo akmods --force
sudo dracut --force
sudo mokutil --import /usr/share/nvidia/nvidia*.der
grub2-mkconfig -o /boot/grub2/grub.cfg
log_success " Over installed,run the nvidia settings after reboot your pc to check the situation "
read -p "Press Enter to continue or Ctrl+C to cancel..."
sudo reboot
exit 0