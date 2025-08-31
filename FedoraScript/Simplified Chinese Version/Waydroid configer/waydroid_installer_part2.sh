#!/bin/bash

# =================================================================================================
# 脚本名称：   waydroid_installer_part2.sh
# 描述：       Waydroid(安卓模拟器)安装脚本 - 第2部分
#              完成Waydroid配置和初始化
# 作者：       XianYin_69
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

# 检查Waydroid是否已安装
if ! command -v waydroid &> /dev/null; then
    log_error "Waydroid 未安装，请先运行第一部分安装脚本。"
    exit 1
    else
    waydroid session stop
    systemctl stop waydroid-container
fi

# 检查root权限
if [[ $EUID -ne 0 ]]; then
    log_error "请使用 root 权限运行此脚本。"
    exit 1
fi

# 检测操作系统
if [[ -f /etc/os-release ]]; then
    . /etc/os-release
    OS_NAME=$NAME
    OS_VERSION=$VERSION_ID
else
    echo "无法检测操作系统版本，请确保脚本在支持的Linux发行版上运行。"
    exit 1
fi

#一些额外的配置
log_info "正在配置 Waydroid..."
waydroid prop set persist.waydroid.multi_windows true
waydroid prop set persist.waydroid.width ""
waydroid prop set persist.waydroid.height ""
waydroid prop set persist.waydroid.cursor_on_subsurface true
log_info "正在安装ARM支持..."#检测是否安装git
if ! command -v git &> /dev/null; then
    log_info "Git 未安装，正在安装..."
    if [[ "$OS_NAME" == "Ubuntu" || "$OS_NAME" == "Debian GNU/Linux" ]]; then
        sudo apt install git lzip -y
    elif [[ "$OS_NAME" == "Fedora" || "$OS_NAME" == "CentOS Linux" || "$OS_NAME" == "Red Hat Enterprise Linux" ]]; then
        sudo dnf install git lzip -y
    elif [[ "$OS_NAME" == "Arch Linux" ]]; then
        sudo pacman -S git lzip --noconfirm
    else
        log_error "不支持的操作系统，请手动安装 Git。"
        exit 1
    fi
fi

#克隆 Waydroid ARM 支持仓库
log_info "正在克隆 Waydroid ARM 支持仓库..."
read -p "输入保存路径：" GIT_PATH
cd "$GIT_PATH"

# 运行安装脚本
log_info "正在运行安装脚本..."
while true; do
    if [ -d waydroid_script ]; then
            cd waydroid_script
        python3 -m venv venv
        ./venv/bin/pip install -r requirements.txt
        venv/bin/python3 main.py
        sudo venv/bin/python3 main.py install libhoudini
        sudo systemctl restart waydroid-container
        log_success "Waydroid ARM 支持安装成功！"
        break
    else
        git clone https://github.com/casualsnek/waydroid_script
        if [[ $? -ne 0 ]]; then
            log_error "克隆仓库失败，请检查网络连接或仓库地址。"
            exit 1
        fi
    fi
done
log_success "Waydroid installer 全部运行脚本已完成运行！"
