#!/bin/bash

# ==============================================================================
#                 NVIDIA 驱动安装脚本2 
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

# 确保以 root 权限运行
if [[ $EUID -ne 0 ]]; then
   echo -e "${RED}此脚本需要 root 权限。请使用 'sudo bash $0' 运行。${NC}"; exit 1
fi

# 全局变量
GRUB_DEFAULT_FILE="/etc/default/grub"
GRUB_OUTPUT_PATH="/boot/grub2/grub.cfg"

# --- 安装函数 (基于 .run 文件) ---

echo -e "\n${CYAN}--- 阶段2:进入tty模式 ---${NC}"
echo "----------------------"
echo -e"\n${YELLOW}按Enter进入tty模式,出现标志时按${RED}Ctrl+Alt+F1${YELLOW}登录tty,然后运行三阶段shell..."
read -p ""
sudo systemctl isolate multi-user.target
exit 0