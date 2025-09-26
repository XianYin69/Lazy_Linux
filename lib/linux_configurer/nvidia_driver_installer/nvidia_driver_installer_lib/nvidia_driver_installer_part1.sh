#!/bin/bash

# =================================================================================================
# 脚本名称：   nvidia-driver-installer-part-1.sh
# 描述：       NVIDIA驱动安装脚本 - 第1部分
#              执行系统状态检查和初始化清理操作
# 作者：       XianYin_69
# 参考来源：   https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/
# 日期：       2025-08-19
# =================================================================================================

main() {
    #变量定义
    source "./.index.sh"
    source "$SUP_NVIDIA_DRIVER_INSTALLER_LIB_HOME_PATH".index.sh
    source "$SUP_NVIDIA_DRIVER_INSTALLER_LIB_HOME_PATH$SUP_NVIDIA_DRIVER_INSTALLER_HOME_PATH".index
    source "$SUP_NVIDIA_DRIVER_INSTALLER_LIB_HOME_PATH$SUP_NVIDIA_DRIVER_INSTALLER_HOME_PATH$SUP_LIB_HOME_PATH".index
    source "$SUP_NVIDIA_DRIVER_INSTALLER_LIB_HOME_PATH$SUP_NVIDIA_DRIVER_INSTALLER_HOME_PATH$SUP_LIB_HOME_PATH$SRC_FOLDER_PATH_INDEX"
    source "$SUP_NVIDIA_DRIVER_INSTALLER_LIB_HOME_PATH$SUP_NVIDIA_DRIVER_INSTALLER_HOME_PATH$SUP_LIB_HOME_PATH$SRC_FOLDER_PATH$PICTURE_FOLDER_PATH_INDEX"
    local JUST_FOR_FUN="$SUP_NVIDIA_DRIVER_INSTALLER_LIB_HOME_PATH$SUP_NVIDIA_DRIVER_INSTALLER_HOME_PATH$SUP_LIB_HOME_PATH$SRC_FOLDER_PATH$PICTURE_FOLDER_PATH$NVIDIA_FUCK_U_TXT_FILE_PATH"

    #只为了好玩
    cat $JUST_FOR_FUN

    #step 1
    NVIDIA_DRIVER_INSTALLER_PART_1_INFO
    NVIDIA_DRIVER_INSTALLER_PART_1_STEP_1_INFO
    sudo dnf update -y
    sudo dnf install -y @base-x kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig xorg-x11-server-Xwayland libxcb egl-wayland akmods vdpauinfo libva-vdpau-driver libva-utils
    NVIDIA_DRIVER_INSTALLER_PART_1_STEP_1_SUCCESS

    #step 2
    NVIDIA_DRIVER_INSTALLER_PART_1_STEP_2_INFO
    sduo echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
    sudo echo "blacklist nova_core" >> /etc/modprobe.d/blacklist.conf
    sudo echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" >> /etc/modprobe.d/nvidia.conf
    sudo echo "options nvidia-drm modeset=1 fbdev=0" >> /etc/modprobe.d/nvidia.conf
    sudo grub2-mkconfig -o /boot/grub2/grub.cfg
    sudo mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau-nova.img 
    sudo dracut /boot/initramfs-$(uname -r).img $(uname -r)
    NVIDIA_DRIVER_INSTALLER_PART_1_STEP_2_SUCCESS
    NVIDIA_DRIVER_INSTALLER_PART_1_END_INFO
    NVIDIA_DRIVER_INSTALLER_PART_1_REBOOT_WARNING
    sleep 10
    NVIDIA_DRIVER_INSTALLER_PART_1_REBOOTING_INFO
    sleep 3
    sudo reboot
}