#!/bin/bash

# =================================================================================================
# 脚本名称：   nvidia-driver-installer-part-1.sh
# 描述：       NVIDIA驱动安装脚本 - 第1部分
#              执行系统状态检查和初始化清理操作
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
    echo -e "${COLOR_INFO}[信息]${COLOR_RESET} $1"
}

log_success() {
    echo -e "${COLOR_SUCCESS}[成功]${COLOR_RESET} $1"
}

log_error() {
    echo -e "${COLOR_ERROR}[错误]${COLOR_RESET} $1"
}

log_warn() {
    echo -e "${COLOR_WARN}[警告]${COLOR_RESET} $1"
}

#root check
if [ $EUID -ne 0 ]; then
  log_error "请以root用户身份运行此脚本"
  exit 1
fi

#变量定义
JUST_FOR_FUN="../../../src/picture/nvidia_fuck_you.txt"

#只为了好玩
cat $JUST_FOR_FUN

#step 1
echo  -e " ==================== NVIDIA驱动安装脚本 - 第1部分 ==================== "
echo  -e " 步骤 1-安装必要软件包 "
sudo dnf update -y
sudo dnf install -y @base-x kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig xorg-x11-server-Xwayland libxcb egl-wayland akmods vdpauinfo libva-vdpau-driver libva-utils
log_success " 必要软件包安装完成 "

#step 2
echo  -e " 步骤 2-禁用nouveau "
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
echo "blacklist nova_core" >> /etc/modprobe.d/blacklist.conf
echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" >> /etc/modprobe.d/nvidia.conf
echo "options nvidia-drm modeset=1 fbdev=0" >> /etc/modprobe.d/nvidia.conf
sudo grub2-mkconfig -o /boot/grub2/grub.cfg
sudo mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau-nova.img 
sudo dracut /boot/initramfs-$(uname -r).img $(uname -r)
log_success " nouveau禁用完成 "

log_warn " 现在需要重启电脑 "
read -p "按回车键继续，按Ctrl+C取消..."
sudo reboot
exit 0