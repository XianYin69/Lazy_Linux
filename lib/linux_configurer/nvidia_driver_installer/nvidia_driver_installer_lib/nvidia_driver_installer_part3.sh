#!/bin/bash

# =================================================================================================
# 脚本名称：   nvidia-driver-installer-part-3.sh
# 描述：       NVIDIA驱动安装脚本 - 第3部分
#              启用服务并签署内核模块
# 作者：       XianYin_69
# 参考来源：   https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/
# 日期：       2025-08-19
# =================================================================================================

main() {
    #step 1
    NVIDIA_DRIVER_INSTALLER_PART_3_STEP_1_INFO
    sudo systemctl enable nvidia-suspend.service
    sudo systemctl enable nvidia-hibernate.service
    sudo systemctl enable nvidia-resume.service
    sudo MAKE[0]="CC='gcc -std=gnu17' 'make' -j16 NV_EXCLUDE_BUILD_MODULES='' KERNEL_UNAME=${kernelver} modules"
    NVIDIA_DRIVER_INSTALLER_PART_3_STEP_1_SUCCESS
    sudo echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" >> /etc/modprobe.d/nvidia.conf
    sudo echo "options nvidia-drm modeset=1 fbdev=1" >> /etc/modprobe.d/nvidia.conf
    NVIDIA_DRIVER_INSTALLER_PART_3_STEP_2_INFO
    if [ "$(command -v dmesg | grep -i Secure boot enabled)" &>/dev/null ]; then
        NVIDIA_DRIVER_INSTALLER_PART_3_STEP_2_SECURE_BOOT_ENABLED_INFO
        akmods --force
        mokutil --import /usr/share/nvidia/nvidia*.der
    fi
    sudo dracut --force
    grub2-mkconfig -o /boot/grub2/grub.cfg
    NVIDIA_DRIVER_INSTALLER_PART_3_STEP_2_SUCCESS
    NVIDIA_DRIVER_INSTALLER_PART_3_END_INFO
    sleep 10
    sudo reboot
}