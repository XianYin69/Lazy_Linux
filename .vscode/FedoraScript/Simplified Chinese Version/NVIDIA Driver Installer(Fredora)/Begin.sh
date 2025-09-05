#!/bin/bash
#
# =================================================================================================
# 脚本名称：   Begin.sh
# 描述：       NVIDIA驱动安装启动脚本
# 参考来源：   https://www.if-not-true-then-false.com
# 作者：       XianYin_69
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

log_warn "!!! 此脚本只限于版本号大于570.181（2025.Aug.05）的英伟达驱动安装包(.run)使用 !!!"
read -p "按回车键继续，按Ctrl+C取消..."
echo "1. 开始安装前的准备工作..."
FILE=(
    "./nvidia-driver-installer-part-1.sh"
    "./nvidia-driver-installer-part-2.sh"
    "./nvidia-driver-installer-part-3.sh"
)
sudo chmod +x ${FILE[*]}
log_success "准备工作完成！"
log_warn "请运行安装程序的第二部分"
read -p "按回车键继续，按Ctrl+C取消..."
exit 0