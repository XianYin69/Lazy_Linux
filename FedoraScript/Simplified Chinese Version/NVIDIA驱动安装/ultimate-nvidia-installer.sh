#!/bin/bash

# ==============================================================================
#                 NVIDIA 驱动终极安装与清理脚本 (单一文件版)
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

# --- 安装函数 (基于 .run 文件) ---
run_install() {
    echo -e "\n${CYAN}--- 阶段：使用官方 .run 文件安装NVIDIA驱动 ---${NC}"
    echo "--------------------------------------------------------"

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
    echo -e "${GREEN}文件验证成功: $RUN_FILE_PATH${NC}"

    # 2. 安装编译依赖
    echo -e "\n${CYAN}--- 步骤 2: 安装编译依赖 ---${NC}"
    sudo dnf update --refresh -y
    sudo dnf install -y kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx libglvnd-opengl libglvnd-devel pkgconfig nvidia-vaapi-driver libva-utils vdpauinfo


    # 3. 禁用 Nouveau 并更新 initramfs
    echo -e "\n${CYAN}--- 步骤 3: 禁用 Nouveau 并更新 initramfs ---${NC}"
    sudo tee /etc/modprobe.d/blacklist-nouveau.conf > /dev/null << EOF
blacklist nouveau
options nouveau modeset=0
EOF
    echo -e "${YELLOW}正在更新 initramfs 和 grub 以确保 Nouveau 被禁用...${NC}"
    sudo dracut --force --verbose
    sudo grub2-mkconfig -o "$GRUB_OUTPUT_PATH"

    # 4. 显示基于您提供的图文版手动安装指南
    sudo chmod +x $RUN_FILE_PATH
    echo -e "\n${GREEN}======================================================${NC}"
    echo -e "${GREEN}      准备就绪！请在当前终端中进行手动安装。      ${NC}"
    echo -e "${GREEN}======================================================${NC}"
    echo -e "\n${YELLOW}请【严格】按照以下指示在当前终端中完成安装：${NC}"
    echo -e "\n${CYAN}--- 手动操作指南 (当前终端) ---${NC}"
    echo -e "${BLUE}1. 执行安装程序:${NC}"
    echo -e "   - 执行: ${GREEN}sudo bash $RUN_FILE_PATH${NC}"
    echo -e "   - NVIDIA 安装程序可能会暂时关闭图形界面，这是正常的。"
    echo
    echo -e "${BLUE}2. NVIDIA 安装程序选项 :${NC}"
    echo -e "   - ${CYAN}(A) 如果看到 'The signed kernel module failed to load...'${NC}"
    echo -e "     - ${YELLOW}选择 -> Install signed kernel module${NC}"
    echo
    echo -e "   - ${CYAN}(B) 'Would you like to register the kernel module sources with DKMS?'${NC}"
    echo -e "     - ${YELLOW}选择 -> Yes${NC}"
    echo -e "     - ${YELLOW}注意:${NC} 之后可能会显示 'Failed to run '/usr/sbin/dkms ...' 错误，这是正常的，请忽略并OK继续。"
    echo
    echo -e "   - ${CYAN}(C) 'Install NVIDIA's 32-bit compatibility libraries?'${NC}"
    echo -e "     - ${YELLOW}选择 -> Yes${NC}"
    echo
    echo -e "   - ${CYAN}(D) 'Would you like to delete the private signing key?'${NC}"
    echo -e "     - ${YELLOW}选择 -> Yes${NC} (推荐，下次更新驱动时可以重新生成)"
    echo
    echo -e "   - ${CYAN}(E) 'Would you like to run the nvidia-xconfig utility?'${NC}"
    echo -e "     - ${YELLOW}选择 -> Yes${NC} (重要，自动配置X11)"
    echo
    echo -e "${BLUE}3. 安装后操作:${NC}"
    echo -e "   - 安装成功后，${RED}不要立即重启${NC}！"
    echo -e "   - NVIDIA 安装程序完成后，它通常会尝试恢复图形界面。如果恢复失败，请耐心等待或尝试切换到其他 TTY (Ctrl+Alt+F1/F2/F3) 检查，然后返回此终端。"
    echo -e "   - ${YELLOW}在 NVIDIA 安装完成后，脚本将自动继续执行后续步骤。${NC}"
    echo
    echo -e "${GREEN}脚本已暂停。请在 NVIDIA 安装完成后，直接在此终端键入Enter继续执行...${NC}"
    read -p "" # 等待用户完成手动安装

    # --- 基于图文指南的善后处理 ---
    echo -e "\n${CYAN}--- 步骤 4: 安装后善后处理与密钥注册 (自动执行) ---${NC}"
    echo "--------------------------------------------------------"
    
    echo -e "${YELLOW}正在强制重新编译内核模块 (akmods)...${NC}"
    sudo akmods --force
    
    echo -e "${YELLOW}正在强制刷新引导镜像 (dracut)...${NC}"
    sudo dracut --force --verbose

    if mokutil --sb-state | grep -q "enabled"; then
        echo -e "${YELLOW}检测到 Secure Boot 已启用，开始导入 NVIDIA 生成的密钥...${NC}"
        
        NVIDIA_DER_FILE=$(find /usr/share/nvidia -name "nvidia-*.der" -type f | head -n 1)
        
        if [ -f "$NVIDIA_DER_FILE" ]; then
            echo -e "${GREEN}已找到 NVIDIA 密钥: $NVIDIA_DER_FILE${NC}"
            echo -e "${YELLOW}现在将为您注册此密钥 (MOK)。${NC}"
            sudo mokutil --import "$NVIDIA_DER_FILE"
            
            echo -e "\n${RED}!!! 重要操作: 请设置 MOK 注册密码 !!!${NC}"
            echo -e "${RED}上面的命令会提示您输入一个【临时密码】。${NC}"
            echo -e "${RED}请输入一个您能记住的简单密码 (例如 8-16 位)，然后再次输入以确认。${NC}"
            echo -e "${RED}重启后，您会进入一个蓝色的 'MOK management' 界面，需要用到此密码。${NC}"
            echo
            echo -e "${BLUE}--- 重启后的 MOK Management 操作指南 ---${NC}"
            echo -e "1. 在蓝色界面选择 ${GREEN}Enroll MOK${NC}."
            echo -e "2. 选择 ${GREEN}Continue${NC}."
            echo -e "3. 系统会问您 'Enroll the key(s)?'，选择 ${GREEN}Yes${NC}."
            echo -e "4. 系统要求您输入之前设置的【临时密码】，输入密码后按 Enter。"
            echo -e "5. 选择 ${GREEN}Reboot${NC}。"
            echo
        else
            echo -e "${RED}错误：在 /usr/share/nvidia/ 目录下未找到由 NVIDIA 安装程序生成的 .der 密钥文件！${NC}"
            echo -e "${YELLOW}无法自动注册密钥。您可能需要手动查找并导入它。${NC}"
        fi
    else
        echo -e "\n${GREEN}Secure Boot 未启用，无需注册密钥。${NC}"
    fi
    
    echo -e "${YELLOW}正在更新 GRUB 引导配置...${NC}"
    sudo grub2-mkconfig -o "$GRUB_OUTPUT_PATH"

    # --- 最终重启 ---
    echo -e "\n${CYAN}--- 最终步骤: 重启系统 ---${NC}"
    echo -e "${GREEN}所有操作均已完成！现在需要重启以应用所有更改。${NC}"
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
else
    echo -e "\n${GREEN}【决策】: 系统状态干净。将自动执行【安装】流程。${NC}"
    run_install
fi

exit 0
