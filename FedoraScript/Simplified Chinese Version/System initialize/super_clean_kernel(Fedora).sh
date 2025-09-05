#!/bin/bash

# =================================================================================================
# 脚本名称：   clean_kernel.sh
# 描述：       清理旧内核和initramfs，更新引导
# 作者：       XianYin_69
# 日期：       2025-08-22
# =================================================================================================

# --- 颜色定义 ---
readonly COLOR_INFO="\033[0;34m"     # 蓝色
readonly COLOR_SUCCESS="\033[0;32m"   # 绿色
readonly COLOR_ERROR="\033[0;31m"     # 红色
readonly COLOR_WARN="\033[0;33m"      # 黄色
readonly COLOR_RESET="\033[0m"        # 重置颜色

# --- 检查root权限 ---
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "此脚本需要root权限"
        echo -e "请使用 sudo 运行: sudo $0"
        exit 1
    fi
}

# --- 获取最新安装的内核版本 ---
get_lasted_kernel_version() {
    echo $(rpm -q kernel | sort -V | tail -n1 | sed 's/kernel-//')
}


#参数定义
current_kernel=$(uname -r)
lasted_kernel=$(get_lasted_kernel_version)

# --- 检查并处理内核版本不一致 ---
check_kernel_version() {
    if [[ "$current_kernel" != "$lasted_kernel" ]]; then
        echo -e "== $COLOR_ERROR 检测到内核版本不一致 $COLOR_RESET =="
        echo -e "当前运行的内核版本: $current_kernel"
        echo -e "最新安装的内核版本: $lasted_kernel"
        echo -e "将为最新内核生成initramfs并更新引导配置"
        return 1
    else
        echo -e "== $COLOR_SUCCESS 内核版本一致：$current_kernel $COLOR_RESET =="
        return 0
    fi
}

# ---清理boot文件夹下的旧文件
clean_old_files() {
    echo -e "正在清理旧文件"
    find /boot -name "config-*" ! -name "config-${lasted_kernel}" -type f ! -delete
    find /boot -name "System.map-*" ! -name "System.map-${lasted_kernel}" -type f ! -delete
    find /boot -name "vmlinuz-*" ! -name "vmlinuz-${lasted_kernel}" -type f ! -name "vmlinuz-0-rescue-*" -type f ! -name "vmlinuz-${current_kernel}" -delete
}

# --- 清理旧的initramfs文件 ---
clean_old_initramfs() {
    echo -e "正在清理旧的initramfs文件..."
    
    # 找到并删除旧的initramfs文件，保留当前内核的
    find /boot -name "initramfs-*.img" ! -name "initramfs-${lasted_kernel}.img" -type f -delete
    
    echo -e "$COLOR_SUCCESS 旧的initramfs文件已清理完成 $COLOR_RESET"
}

# --- 重新生成initramfs ---
regenerate_initramfs() {
    echo -e "正在重新生成initramfs..."
    # 为当前内核生成
    dracut --force "/boot/initramfs-${current_kernel}.img" "${current_kernel}"
    # 如果最新内核不同，也为其生成
    if [[ "$current_kernel" != "$lasted_kernel" ]]; then
        echo -e "为最新内核 $lasted_kernel 生成initramfs..."
        dracut --force "/boot/initramfs-${lasted_kernel}.img" "${lasted_kernel}"
    fi
    
    if [ $? -eq 0 ]; then
        echo -e "$COLOR_SUCCESS initramfs生成完成 $COLOR_RESET"
    else
        echo -e "$COLOR_ERROR initramfs生成失败 $COLOR_RESET"
        exit 1
    fi
}

# --- 更新GRUB ---
update_grub() {
    echo -e "正在更新GRUB配置..."
    grub2-mkconfig -o /boot/grub2/grub.cfg
    if [ $? -eq 0 ]; then
        echo -e "$COLOR_SUCCESS GRUB配置更新完成 $COLOR_RESET"
    else
        echo -e "$COLOR_ERROR GRUB配置更新失败 $COLOR_RESET"
        exit 1
    fi
}

echo -e "==================================================="
echo -e "    内核清理与更新工具"
echo -e "==================================================="
echo

log_warn "如果你使用nvidia显卡，则重启后需要重新安装nvidia驱动"

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
    echo -e "由于存在新内核，将更新引导配置..."
    update_grub
fi

#再次更新系统
dnf update -y

echo -e "$COLOR_INFO 所有操作已完成！"
echo -e "建议重启系统以应用更改。"
echo -e "如果系统无法启动，可以通过GRUB菜单选择备份的内核版本启动。$COLOR_RESET"
exit 0