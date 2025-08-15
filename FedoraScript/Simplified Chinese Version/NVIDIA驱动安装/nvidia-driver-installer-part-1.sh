#!/bin/bash

# ==============================================================================
#                 NVIDIA 驱动安装脚本1
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

echo -e "\n${CYAN}--- 阶段1:禁用nouvean ---${NC}"
echo "----------------------"

# 1. 获取并验证 .run 文件路径
echo -e "\n${CYAN}--- 步骤 1: 获取 NVIDIA .run 安装文件路径 ---${NC}"
local RUN_FILE_PATH
read -p "请输入 NVIDIA .run 安装文件的绝对路径: " RUN_FILE_PATH
if [ -z "$RUN_FILE_PATH" ]; then
    echo -e "${RED}错误：未输入路径。脚本退出。${NC}"; exit 1
fi
if [[ ! -f "$RUN_FILE_PATH" ]] || [[ ! -x "$RUN_FILE_PATH" ]]; then
    echo -e "${RED}错误：文件不存在或不是一个可执行文件。请检查路径和权限 (chmod +x 文件名)。${NC}"
    echo -e "${RED}路径: '$RUN_FILE_PATH'${NC}"
    exit 1
fi
echo -e "\n${GREEN}文件验证成功: $RUN_FILE_PATH${NC}"

# 2. 安装编译依赖
echo -e "\n${CYAN}--- 步骤 2: 安装编译依赖 ---${NC}"
sudo dnf update --refresh -y
sudo dnf groupinstall "Development Tools"
sudo dnf install -y kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig kmodtool mokutil openssl dkms nvidia-vaapi-driver libva-utils vdpauinfo xrong-x11-server-Xwayland libxcb egl-wayland --skip-unavailable


# 3. 禁用 Nouveau 并更新 initramfs
echo -e "\n${CYAN}--- 步骤 3: 禁用 Nouveau 并更新 initramfs ---${NC}"
echo "blacklist nouveau" >> /etc/modprobe.d/blacklist.conf
echo "blacklist nova_core" >> /etc/modprobe.d/blacklist.conf
echo "options nvidia NVreg_PreserveVideoMemoryAllocations=1" >> /etc/modprobe.d/nvidia.conf #suit for 575 570 550
echo "options nvidia-drm modeset=1 fbdev=1" >> /etc/modprobe.d/nvidia.conf

if [ -f "$GRUB_DEFAULT_FILE" ]; then
    sudo cp "$GRUB_DEFAULT_FILE" "${GRUB_DEFAULT_FILE}.bak.$(date +%s)"
    sudo tee "$GRUB_DEFAULT_FILE" > /dev/null << EOF
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="\$(sed 's, release .*\$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="rhgb quiet rd.driver.blacklist=nouveau nouveau.modeset=0"
GRUB_DISABLE_RECOVERY="true"
GRUB_ENABLE_BLSCFG=true
EOF
fi
echo -e "${YELLOW}正在更新grub 以确保 Nouveau 被禁用...${NC}"
sudo mv /boot/initramfs-$(uname -r).img /boot/initramfs-$(uname -r)-nouveau-nova.img
sudo dracut /boot/initramfs-$(uname -r).img $(uname -r)
echo "/usr/lib64/tls/" > /etc/ld.so.conf.d/nvidia.conf
sudo ldconfig
echo -e "${RED}按下Enter重启系统并由您主动运行二阶段shell（注意：重启后提示Nvidia moudle is missing,Fail back to nouveau.属正常现象）..."
read -p ""
sudo systemctl reboot
exit 0
