#!/bin/bash

# =================================================================================================
# 脚本名称：   waydroid_installer_part1.sh
# 描述：       Waydroid(安卓模拟器)安装脚本 - 第1部分
#              完成系统检查和基础环境配置
# 作者：       XianYin_69
# 参考来源：   https://www.tqhyg.net/post517.html
# 日期：       2025-08-19
# =================================================================================================

set -e  # 遇到错误立即退出

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

# --- 常量定义 ---
readonly DEBIAN_DEPS=(
    "lxc"
    "python3"
    "adb"
    "waydroid"
)

readonly FEDORA_DEPS=(
    "lxc"
    "python3"
    "adb"
    "waydroid"
)

readonly WAYDROID_REPO_URL="https://repo.waydro.id"

# --- 工具函数 ---
check_os() {
    if [[ ! -f /etc/os-release ]]; then
        log_error "无法检测操作系统版本"
        log_error "请确保脚本在支持的Linux发行版上运行"
        exit 1
    fi
    
    . /etc/os-release
    readonly OS_NAME=$NAME
    readonly OS_VERSION=$VERSION_ID
    
    log_info "检测到操作系统: $OS_NAME $OS_VERSION"
}

# --- 主函数 ---
main() {
    # 检查root权限
    if [[ $EUID -ne 0 ]]; then
        log_error "请使用 root 权限运行此脚本"
        log_error "请使用: sudo $0"
        exit 1
    fi
    
    # 检测操作系统
    check_os
    
    # 根据系统类型安装
    case "$OS_NAME" in
        "Ubuntu"|"Debian GNU/Linux")
            log_info "检测到 Debian/Ubuntu 系统，开始安装 Waydroid..."
            apt install -y "${DEBIAN_DEPS[@]}" || log_error "依赖包安装失败"
            curl "${WAYDROID_REPO_URL}" | bash || log_error "添加Waydroid仓库失败"
            apt install -y waydroid || log_error "Waydroid安装失败"
            ;;
            
        "Fedora"|"CentOS Linux"|"Red Hat Enterprise Linux")
            log_info "检测到 Fedora/CentOS/Red Hat 系统，开始安装 Waydroid..."
            dnf install -y "${FEDORA_DEPS[@]}" || log_error "依赖包安装失败"
            curl "${WAYDROID_REPO_URL}" | bash || log_error "添加Waydroid仓库失败"
            dnf install -y waydroid || log_error "Waydroid安装失败"
            ;;
        *)
            log_error "不支持的操作系统: $OS_NAME"
            log_error "本脚本仅支持 Debian、Ubuntu、Fedora、CentOS 和 Red Hat"
            exit 1
            ;;
    esac
    
    # 检查安装结果
    if command -v waydroid &> /dev/null; then
        log_success "Waydroid 安装成功！"
        log_info "请运行第二部分脚本完成配置"
    else
        log_error "Waydroid 安装失败，请检查错误信息"
        exit 1
    fi
}

# 执行主程序
main

#arch linux 系统安装
if [[ "$OS_NAME" == "Arch Linux" ]]; then
    echo "检测到 Arch Linux 系统，正在安装 Waydroid..."
    sudo pacman -S lxc python3 adb --noconfirm
    curl https://repo.waydro.id | sudo bash
    sudo pacman -S waydroid --noconfirm
fi

# snap 安装
if command -v snap &> /dev/null; then
    echo "检测到 Snap，正在安装 Waydroid..."
    sudo snap install waydroid
else
    echo "Snap 未安装，无法通过 Snap 安装 Waydroid。"
fi

# --- 检查安装状态 ---
if command -v waydroid &> /dev/null; then
    echo "Waydroid 安装成功！"
    echo "第一阶段安装完成。请继续执行第二阶段安装。命令行输入：waydroid init（注意：SyatemOTA => https://ota.waydro.id/system; VendorOTA => https://ota.waydro.id/vendor）"
else
    echo "Waydroid 安装失败，请检查错误信息并重试。"    