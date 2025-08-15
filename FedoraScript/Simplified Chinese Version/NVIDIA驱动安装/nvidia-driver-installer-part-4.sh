#!/bin/bash

# ==============================================================================
#                 NVIDIA 驱动安装脚本4
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
