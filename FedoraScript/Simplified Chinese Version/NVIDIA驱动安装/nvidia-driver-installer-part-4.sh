#!/bin/bash

# =================================================================================================
# 脚本名称：   nvidia-driver-installer-part-4.sh
# 描述：       NVIDIA驱动安装脚本 - 第4部分
#              执行最终配置和验证
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

echo -e "\n${YELLOW}-Due to in tty mode,guide will use English to lend you to install nvidia driver-${NC}"

# 确保以 root 权限运行
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}it shell needs root.Please login 'sudo bash $0' run!${NC}"; exit 1
fi

# 全局变量
GRUB_DEFAULT_FILE="/etc/default/grub"
GRUB_OUTPUT_PATH="/boot/grub2/grub.cfg"

# --- 安装函数 (基于 .run 文件) ---

echo -e "\n${CYAN}--- Stage 4 : Final setting ---${NC}"
echo "-----------------------"
echo -e "\n${RED}!!!Warning : it may let you set a password,please remember it !!!${NC}"
echo -e "\n${YELLOW}Attention : After reboot you will in a blue screen."
echo -e " You must press any key in 10s"
echo -e " Select Enroll MOK and press Enter it,than"Continue"->"Yes""
echo -e " Input your password is you setted,then select Reboot and press "Enter" it,then wait your computer reboot${NC}"
echo -e "Press ENTER to continue..."
read -p ""
sudo akmods --force
sudo dracut --force
sudo mokutil --import /usr/share/nvidia/nvidia*.der
sudo grub2-mkconfig -o $GRUB_OUTPUT_PATH
sudo systemctl enable nvidia-suspend.service
sudo systemctl enable nvidia-hibernate.service
sudo systemctl enable nvidia-resume.service
echo systemctl reboot
exit 0
