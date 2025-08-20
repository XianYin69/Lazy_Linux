#!/bin/bash

# =================================================================================================
# 脚本名称：   nvidia-driver-installer-part-3.sh
# 描述：       NVIDIA驱动安装脚本 - 第3部分
#              执行驱动安装和初始配置
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

echo -e "${YELLOW}-Due to in tty mode,guide will use English to lend you to install nvidia driver-${NC}"

# 确保以 root 权限运行
if [[ $EUID -ne 0 ]]; then
   echo -e "\n${RED}it shell needs root.Please login 'sudo bash $0' run!${NC}"; exit 1
fi

# 全局变量
GRUB_DEFAULT_FILE="/etc/default/grub"
GRUB_OUTPUT_PATH="/boot/grub2/grub.cfg"

# --- 安装函数 (基于 .run 文件) ---

echo -e "\n${CYAN}--- Stage 3 : install driver ---${NC}"
echo "-----------------------"
    echo -e "\n${CYAN}--- step 1 : make sure your (.run) file path ---${NC}"
local RUN_FILE_PATH
read -p "Please enter your (.run) file abs path: " RUN_FILE_PATH
if [ -z "$RUN_FILE_PATH" ]; then
    echo -e "${RED}ERROR : A bad path${NC}"; exit 1
fi
if [[ ! -f "$RUN_FILE_PATH" ]] || [[ ! -x "$RUN_FILE_PATH" ]]; then
    echo -e "${RED}ERROR : A bad file${NC}"
    echo -e "${RED}path: '$RUN_FILE_PATH'${NC}"
    exit 1
fi
echo -e "\n${GREEN}===Attention==="
echo -e "1. If your computer enable "Secure Boot",please select"Sign the kernel moudule""
echo -e "2.Just select"Continue install","yes","ok" or any looks good"
echo -e "3.Don't turn off your computer after installed,please run the stage 4 shell in tty mode"
echo -e "Press ENTER to continue...${NC}"
read -p ""
echo -e "\n${GREEN}File looks good!!!: $RUN_FILE_PATH${NC}"
export CC="gcc -std=gnu17"
sudo chmod +x $RUN_FILE_PATH
sudo $RUN_FILE_PATH
exit 0
