#!/bin/bash

# =================================================================================================
# 脚本名称：   clean_kernel.sh
# 描述：       清理旧内核和initramfs，更新引导
# 作者：       XianYin_69
# 日期：       2025-08-22
# =================================================================================================

#定义函数
## --- 获取最新安装的内核版本 ---
get_lasted_kernel_version() {
    echo $(rpm -q kernel | sort -V | tail -n1 | sed 's/kernel-//')
}

#参数定义
current_kernel=$(uname -r)
lasted_kernel=$(get_lasted_kernel_version)

# --- 检查并处理内核版本不一致 ---
check_kernel_version() {
    if [[ "$current_kernel" != "$lasted_kernel" ]]; then
        SUPER_CLEAN_OLD_KERNEL_VERSION_DIFF_INFO
        SUPER_CLEAN_OLD_KERNEL_VERSION_INFO "$current_kernel"
        SUPER_CLEAN_OLD_KERNEL_LASTED_VERSION_INFO  "$lasted_kernel"
        SUPER_CLEAN_OLD_KERNEL_PROCESS_INITRAMFS_INFO
        return 1
    else
        SUPER_CLEAN_OLD_KERNEL_VERSION_SAME_INFO "$current_kernel"
        return 0
    fi
}

# ---清理boot文件夹下的旧文件
clean_old_files() {
    SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_BOOT_INFO
    find /boot -name "config-*" ! -name "config-${lasted_kernel}" -type f ! -delete
    find /boot -name "System.map-*" ! -name "System.map-${lasted_kernel}" -type f ! -delete
    find /boot -name "vmlinuz-*" ! -name "vmlinuz-${lasted_kernel}" -type f ! -name "vmlinuz-0-rescue-*" -type f ! -name "vmlinuz-${current_kernel}" -delete
}

# --- 清理旧的initramfs文件 ---
clean_old_initramfs() {
    SUPER_CLEAN_OLD_KERNEL_DELETE_INITRAMFS_INFO
    # 找到并删除旧的initramfs文件，保留当前内核的
    find /boot -name "initramfs-*.img" ! -name "initramfs-${lasted_kernel}.img" -type f -delete
    SUPER_CLEAN_OLD_KERNEL_DELETE_INITRAMFS_SUCCESS
}

# --- 重新生成initramfs ---
regenerate_initramfs() {
    SUPER_CLEAN_OLD_KERNEL_REGENERATE_INITRAMFS_INFO
    # 为当前内核生成
    dracut --force "/boot/initramfs-${current_kernel}.img" "${current_kernel}"
    # 如果最新内核不同，也为其生成
    if [[ "$current_kernel" != "$lasted_kernel" ]]; then
        SUPER_CLEAN_OLD_KERNEL_REGENERATING_INITRAMFS_INFO
        dracut --force "/boot/initramfs-${lasted_kernel}.img" "${lasted_kernel}"
    fi
    
    if [ $? -eq 0 ]; then
        SUPER_CLEAN_OLD_KERNEL_REGENERATE_INITRAMFS_SUCCESS
    else
        SUPER_CLEAN_OLD_KERNEL_REGENERATE_INITRAMFS_ERROR
        exit 1
    fi
}

# --- 更新GRUB ---
update_grub() {
    SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_GRUB_INFO
    grub2-mkconfig -o /boot/grub2/grub.cfg
    if [ $? -eq 0 ]; then
        SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_GRUB_SUCCESS
    else
        SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_GRUB_ERROR
        exit 1
    fi
}

#主函数
SUPER_CLEAN_OLD_KERNEL_INFO

SUPER_CLEAN_OLD_KERNEL_IF_INSTALLED_NVIDIA_WARNING

# 检查root权限
check_root

#更新系统
dnf update -y

# 检查内核版本一致性
check_kernel_version

# 清理旧boot
clean_old_files
clean_old_initramfs

# 重新生成initramfs（如果内核版本不一致，会同时生成最新内核的initramfs）
regenerate_initramfs

# 如果内核版本不一致或用户选择了备份，则更新GRUB
if [[ $kernel_check_result -eq 1 ]]; then
    SUPER_CLEAN_OLD_KERNEL_UPDATE_GRUB_INFO
    update_grub
fi

#再次更新系统
dnf update -y

SUPER_CLEAN_OLD_KERNEL_END_INFO
exit 0