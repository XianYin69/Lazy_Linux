#!/bin/bash
#
# =================================================================================================
# 脚本名称：   Begin.sh
# 描述：       NVIDIA驱动安装启动脚本
# 参考来源：   https://www.if-not-true-then-false.com
# 作者：       XianYin with AI toolkit
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

# --- 主程序 ---
main() {
    local SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
    local INSTALLER_SCRIPTS=(
        "nvidia-driver-installer-part-1.sh"
        "nvidia-driver-installer-part-2.sh"
        "nvidia-driver-installer-part-3.sh"
        "nvidia-driver-installer-part-4.sh"
        "nvidia-driver-uninstaller.sh"
    )

    log_info "开始NVIDIA驱动安装程序..."

    # 设置脚本执行权限
    for script in "${INSTALLER_SCRIPTS[@]}"; do
        if [ -f "$SCRIPT_DIR/$script" ]; then
            chmod +x "$SCRIPT_DIR/$script"
            log_success "已设置 $script 的执行权限"
        else
            log_error "找不到脚本文件：$script"
            exit 1
        fi
    done

    # 开始安装过程
    log_info "启动安装程序第一部分..."
    if ! sudo bash "$SCRIPT_DIR/nvidia-driver-installer-part-1.sh"; then
        log_error "安装过程失败"
        exit 1
    fi

    log_success "初始化安装过程完成"
}

# 执行主程序
main
