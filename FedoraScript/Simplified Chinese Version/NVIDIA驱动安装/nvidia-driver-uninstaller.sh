#!/bin/bash

# ==============================================================================
#                 NVIDIA 驱动卸载脚本 
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
# 保留 NVIDIA_PACKAGES 用于清理检查
NVIDIA_PACKAGES=( "akmod-nvidia" "xorg-x11-drv-nvidia-cuda" "xorg-x11-drv-nvidia" "nvidia-settings" "nvidia-powerd" )

# 函数：使用 rpm -q 确保准确性
is_package_installed() { rpm -q "$1" >/dev/null 2>&1; }

# --- 清理函数 (保持不变) ---
run_cleanup() {
    echo -e "\n${CYAN}--- 阶段：焦土式清理 ---${NC}"
    echo "--------------------------------------------------------"

    echo -e "${YELLOW}正在停止所有相关服务...${NC}"
    sudo systemctl stop nvidia-powerd.service 2>/dev/null
    sudo systemctl disable nvidia-powerd.service 2>/dev/null

    echo -e "${YELLOW}正在强制卸载所有NVIDIA软件包...${NC}"
    sudo dnf remove -y "*nvidia*"
    sudo dnf autoremove -y

    echo -e "${YELLOW}正在清理所有已知NVIDIA残留文件和目录...${NC}"
    sudo rm -rf /etc/pki/akmods /etc/modprobe.d/blacklist-nouveau.conf /var/cache/akmods/* /usr/src/nvidia-* /etc/nvidia
    sudo find /etc/X11/xorg.conf.d -name '*-nvidia.conf' -delete

    echo -e "${YELLOW}正在强制重置 GRUB 引导参数...${NC}"
    if [ -f "$GRUB_DEFAULT_FILE" ]; then
        sudo cp "$GRUB_DEFAULT_FILE" "${GRUB_DEFAULT_FILE}.bak.$(date +%s)"
        sudo tee "$GRUB_DEFAULT_FILE" > /dev/null << EOF
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="\$(sed 's, release .*\$,,g' /etc/system-release)"
GRUB_DEFAULT=saved
GRUB_DISABLE_SUBMENU=true
GRUB_TERMINAL_OUTPUT="console"
GRUB_CMDLINE_LINUX="rhgb quiet"
GRUB_DISABLE_RECOVERY="true"
GRUB_ENABLE_BLSCFG=true
EOF
        sudo grub2-mkconfig -o "$GRUB_OUTPUT_PATH"
    fi

    echo -e "${YELLOW}正在重新生成initramfs以恢复Nouveau...${NC}"
    sudo dracut --force --verbose

    echo -e "\n${GREEN}==============================================${NC}"
    echo -e "${GREEN}      清理阶段完成。                        ${NC}"
    echo -e "${GREEN}==============================================${NC}"
    echo -e "${YELLOW}为了确保系统处于绝对干净的状态，现在必须重启。${NC}"
    echo -e "${RED}!!! 重启后，请再次运行此脚本以开始安装过程。!!!${NC}"
    read -p "按 Enter 键立即重启。"
    sudo systemctl reboot
    exit 0
}

# --- 主逻辑：检测并执行 ---
echo -e "\n${CYAN}--- 主逻辑：检测系统状态... ---${NC}"
NEEDS_CLEANUP=0
# 检查是否有任何NVIDIA包已安装
for pkg in "${NVIDIA_PACKAGES[@]}"; do
    if is_package_installed "$pkg"; then
        NEEDS_CLEANUP=1
        echo -e "${YELLOW}检测到残留软件包: ${pkg}${NC}"
        break
    fi
done
# 检查是否有残留的配置文件
if [ -d "/etc/pki/akmods" ] || [ -f "/etc/modprobe.d/blacklist-nouveau.conf" ]; then
    NEEDS_CLEANUP=1
    echo -e "${YELLOW}检测到残留的配置文件。${NC}"
fi
# 检查GRUB文件是否损坏
if [ -f "$GRUB_DEFAULT_FILE" ] && grep -qE "(^sed,|^,)" "$GRUB_DEFAULT_FILE"; then
    NEEDS_CLEANUP=1
    echo -e "${YELLOW}检测到损坏的 GRUB 文件。${NC}"
fi

if [ $NEEDS_CLEANUP -eq 1 ]; then
    echo -e "\n${YELLOW}【决策】: 系统存在NVIDIA残留或配置损坏。将自动执行【清理】流程。${NC}"
    run_cleanup
fi

exit 0


    