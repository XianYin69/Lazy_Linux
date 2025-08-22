#!/bin/bash

# =================================================================================================
# 脚本名称：   clean_kernel.sh
# 描述：       清理旧内核和initramfs，更新引导
# 作者：       XianYin with AI toolkit
# 日期：       2025-08-22
# =================================================================================================

# --- 颜色定义 ---
readonly COLOR_INFO="\033[0;34m"     # 蓝色
readonly COLOR_SUCCESS="\033[0;32m"   # 绿色
readonly COLOR_ERROR="\033[0;31m"     # 红色
readonly COLOR_WARN="\033[0;33m"      # 黄色
readonly COLOR_RESET="\033[0m"        # 重置颜色

# --- 日志函数 ---
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

# --- 检查root权限 ---
check_root() {
    if [ "$EUID" -ne 0 ]; then
        log_error "此脚本需要root权限"
        log_error "请使用 sudo 运行: sudo $0"
        exit 1
    fi
}

# --- 检测系统类型 ---
detect_os() {
    if [ -f "/etc/os-release" ]; then
        . /etc/os-release
        case "$ID" in
            "fedora")
                OS_TYPE="fedora"
                ;;
            "ubuntu"|"debian")
                OS_TYPE="debian"
                ;;
            "arch"|"manjaro")
                OS_TYPE="arch"
                ;;
            *)
                log_error "不支持的Linux发行版：$ID"
                exit 1
                ;;
        esac
        echo "$OS_TYPE"
    else
        log_error "无法检测操作系统类型"
        exit 1
    fi
}

# --- 获取最新安装的内核版本 ---
get_latest_kernel_version() {
    case "$OS_TYPE" in
        "fedora")
            echo $(rpm -q kernel | sort -V | tail -n1 | sed 's/kernel-//')
            ;;
        "debian")
            echo $(dpkg --list | grep 'linux-image-[0-9]' | awk '{print $2}' | sort -V | tail -n1 | sed 's/linux-image-//')
            ;;
        "arch")
            echo $(pacman -Q linux | awk '{print $2}')
            ;;
    esac
}

# --- 检查并处理内核版本不一致 ---
check_kernel_version() {
    local current_kernel=$(uname -r)
    local latest_kernel=$(get_latest_kernel_version)
    
    if [[ "$current_kernel" != "$latest_kernel" ]]; then
        log_warn "检测到内核版本不一致："
        log_info "当前运行的内核版本: $current_kernel"
        log_info "最新安装的内核版本: $latest_kernel"
        log_info "将为最新内核生成initramfs并更新引导配置"
        return 1
    else
        log_success "内核版本一致：$current_kernel"
        return 0
    fi
}

# --- 备份当前initramfs ---
backup_current_initramfs() {
    local current_kernel=$(uname -r)
    local backup_dir="/boot/backup_$(date +%Y%m%d_%H%M%S)"
    
    # 询问用户是否要备份
    read -p "是否要备份当前的initramfs文件？(y/n): " backup_choice
    
    if [[ "$backup_choice" =~ ^[Yy]$ ]]; then
        log_info "正在备份当前initramfs..."
        mkdir -p "$backup_dir"
        cp "/boot/initramfs-${current_kernel}.img" "$backup_dir/"
        
        if [ $? -eq 0 ]; then
            log_success "备份完成：$backup_dir"
        else
            log_error "备份失败"
            exit 1
        fi
    else
        log_info "跳过备份initramfs"
    fi
}

# --- 清理旧内核 ---
clean_old_kernels() {
    local current_kernel=$(uname -r)
    
    log_info "正在清理旧内核，将只保留当前内核和最新内核..."
    
    case "$OS_TYPE" in
        "fedora")
            # 获取所有已安装的内核版本
            local installed_kernels=($(rpm -q kernel | sort -V))
            local latest_kernel=${installed_kernels[-1]}
            
            # 遍历所有内核，除了当前和最新的都删除
            for kernel in "${installed_kernels[@]}"; do
                if [[ "$kernel" != *"$current_kernel"* ]] && [[ "$kernel" != "$latest_kernel" ]]; then
                    log_info "正在删除内核：$kernel"
                    dnf remove -y "$kernel"
                fi
            done
            ;;
        "debian")
            # 获取所有已安装的内核包
            local installed_kernels=($(dpkg --list | grep 'linux-image-[0-9]' | awk '{print $2}' | sort -V))
            local latest_kernel=${installed_kernels[-1]}
            local current_kernel_pkg="linux-image-${current_kernel}"
            
            # 遍历所有内核，除了当前和最新的都删除
            for kernel in "${installed_kernels[@]}"; do
                if [[ "$kernel" != "$current_kernel_pkg" ]] && [[ "$kernel" != "$latest_kernel" ]]; then
                    log_info "正在删除内核：$kernel"
                    apt purge -y "$kernel"
                fi
            done
            ;;
        "arch")
            # Arch Linux通常只保留最新内核，但我们也要确保当前内核不被删除
            local installed_kernels=($(pacman -Q | grep '^linux ' | sort -V))
            local latest_kernel=${installed_kernels[-1]}
            
            for kernel in "${installed_kernels[@]}"; do
                local kernel_version=$(echo "$kernel" | awk '{print $2}')
                if [[ "$kernel_version" != "$current_kernel" ]] && [[ "$kernel" != "$latest_kernel" ]]; then
                    log_info "正在删除内核：$kernel"
                    pacman -R --noconfirm "$kernel"
                fi
            done
            ;;
    esac
    
    log_success "内核清理完成"
}

# --- 清理旧的initramfs文件 ---
clean_old_initramfs() {
    local current_kernel=$(uname -r)
    
    log_info "正在清理旧的initramfs文件..."
    
    # 找到并删除旧的initramfs文件，保留当前内核的
    find /boot -name "initramfs-*.img" ! -name "initramfs-${current_kernel}.img" -type f -delete
    
    log_success "旧的initramfs文件已清理完成"
}

# --- 重新生成initramfs ---
regenerate_initramfs() {
    local current_kernel=$(uname -r)
    local latest_kernel=$(get_latest_kernel_version)
    
    log_info "正在重新生成initramfs..."
    
    case "$OS_TYPE" in
        "fedora")
            # 为当前内核生成
            dracut --force "/boot/initramfs-${current_kernel}.img" "${current_kernel}"
            # 如果最新内核不同，也为其生成
            if [[ "$current_kernel" != "$latest_kernel" ]]; then
                log_info "为最新内核 $latest_kernel 生成initramfs..."
                dracut --force "/boot/initramfs-${latest_kernel}.img" "${latest_kernel}"
            fi
            ;;
        "debian")
            # 为当前内核更新
            update-initramfs -u -k "${current_kernel}"
            # 如果最新内核不同，也为其生成
            if [[ "$current_kernel" != "$latest_kernel" ]]; then
                log_info "为最新内核 $latest_kernel 生成initramfs..."
                update-initramfs -c -k "${latest_kernel}"
            fi
            ;;
        "arch")
            # Arch Linux会自动为所有安装的内核生成initramfs
            mkinitcpio -P
            ;;
    esac
    
    if [ $? -eq 0 ]; then
        log_success "initramfs生成完成"
    else
        log_error "initramfs生成失败"
        exit 1
    fi
}

# --- 更新GRUB ---
update_grub() {
    log_info "正在更新GRUB配置..."
    
    case "$OS_TYPE" in
        "fedora")
            grub2-mkconfig -o /boot/grub2/grub.cfg
            ;;
        "debian")
            update-grub
            ;;
        "arch")
            grub-mkconfig -o /boot/grub/grub.cfg
            ;;
    esac
    
    if [ $? -eq 0 ]; then
        log_success "GRUB配置更新完成"
    else
        log_error "GRUB配置更新失败"
        exit 1
    fi
}

# --- 主函数 ---
main() {
    log_info "==================================================="
    log_info "    内核清理与更新工具"
    log_info "==================================================="
    echo
    
    # 检查root权限
    check_root
    
    # 检测系统类型
    OS_TYPE=$(detect_os)
    log_info "检测到系统类型: $OS_TYPE"
    
    # 检查内核版本一致性
    check_kernel_version
    local kernel_check_result=$?
    
    # 清理旧内核
    clean_old_kernels
    
    # 清理旧的initramfs
    clean_old_initramfs
    
    # 询问是否备份当前initramfs
    backup_current_initramfs
    
    # 重新生成initramfs（如果内核版本不一致，会同时生成最新内核的initramfs）
    regenerate_initramfs
    
    # 如果内核版本不一致或用户选择了备份，则更新GRUB
    if [[ $kernel_check_result -eq 1 ]]; then
        log_info "由于存在新内核，将更新引导配置..."
        update_grub
    fi
    
    log_success "所有操作已完成！"
    log_warn "建议重启系统以应用更改。"
    log_warn "如果系统无法启动，可以通过GRUB菜单选择备份的内核版本启动。"
}

# 执行主程序
main
