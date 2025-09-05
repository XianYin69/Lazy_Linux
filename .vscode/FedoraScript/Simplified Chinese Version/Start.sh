#!/bin/bash

# =================================================================================================
# 脚本名称：   Start.sh
# 描述：       Shell脚本权限初始化工具
#              - 自动授权当前目录下所有.sh文件为可执行
#              - 递归处理所有子目录
# 作者：       XianYin with AI toolkit
# 日期：       2025-08-20
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
    
    log_info "开始授权脚本文件..."
    
    # 统计文件数量
    local TOTAL_FILES=$(find "$SCRIPT_DIR" -type f -name "*.sh" | wc -l)
    
    if [ "$TOTAL_FILES" -eq 0 ]; then
        log_warn "未找到任何.sh文件"
        exit 0
    fi
    
    # 授权所有.sh文件
    find "$SCRIPT_DIR" -type f -name "*.sh" -exec chmod +x {} \;
    
    log_success "已成功授权 $TOTAL_FILES 个.sh文件为可执行"
}

# 执行主程序
main