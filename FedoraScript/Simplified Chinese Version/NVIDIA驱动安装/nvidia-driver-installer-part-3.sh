#!/bin/bash

# ==============================================================================
#                 NVIDIA 驱动安装脚本3
# ==============================================================================
# 作者: Your AI Assistant (基于与 EthanYan 的排错经验)
# 版本: Final Ultimate - FIXED
# 目标: 自动检测系统状态，并执行清理或安装操作。
#
# 用法:
# 1. 保存为 'ultimate-nvidia-installer.sh'
# 2. chmod +x ultimate-nvidia-installer.sh
# 3. sudo bash ultimate-nvidia-installer.sh
# ==============================================================================

# 定义颜色常量
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; CYAN='\033[0;36m'; BLUE='\033[0;34m'; NC='\033[0m'

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
