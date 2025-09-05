#!/bin/bash
# =================================================================================================
# 脚本名称：   appInstaller.sh
# 描述：       安装安卓应用
# 作者：       XianYin_69
# 参考来源：   none
# 日期：       8-31-2025
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

#check waydroid status
if [ ! -d "/var/lib/waydroid" ]; then
    log_error "Waydroid未安装或未初始化，请先安装并初始化Waydroid"
    exit 1
else
    log_success "检测到Waydroid已安装"
    systemctl start waydroid-container
    echo "请输入要安装的APK文件路径："
    read APK_PATH
    if [ ! -f "$APK_PATH" ]; then
        log_error "指定的APK文件不存在，请检查路径后重试"
        exit 1
    else
        waydroid app install "$APK_PATH"
        if [ $? -eq 0 ]; then
            log_success "APK安装成功"
        else
            log_error "APK安装失败，请检查文件是否有效"
            exit 1
        fi
    fi

fi