#!/bin/bash
# =================================================================================================
# 脚本名称：   Chinese.sh
# 描述：       A Chinesization script 
# 作者：       XianYin_69
# 参考来源：   
# 日期：       9-2-2025
# =================================================================================================

# --- 颜色定义 ---
readonly COLOR_INFO="\033[0;34m"     # 蓝色
readonly COLOR_SUCCESS="\033[0;32m"   # 绿色
readonly COLOR_ERROR="\033[0;31m"     # 红色
readonly COLOR_WARN="\033[0;33m"      # 黄色
readonly COLOR_RESET="\033[0m"        # 重置颜色

#--日志函数---
log_info() {
    echo -e "${COLOR_INFO}[Info]${COLOR_RESET} $1"
}
log_success() {
    echo -e "${COLOR_SUCCESS}[Success]${COLOR_RESET} $1"
}
log_error() {
    echo -e "${COLOR_ERROR}[Error]${COLOR_RESET} $1"
}
log_warn() {
    echo -e "${COLOR_WARN}[Warning]${COLOR_RESET} $1"
}

# --- 检查root权限 ---
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo -e "Need root privileges"
        echo -e "Please run it as root: sudo $0"
        exit 1
    fi
}

#检测系统
check_os() {
    case $ID in
        fedora)
            echo -e " $COLOR_SUCCESS 系统是 $COLOR_RESET fedora"
            OS_TYPE="fedora"
            ;;
        debian|ubuntu)
            echo -e " $COLOR_SUCCESS 系统是 $COLOR_RESET debian/ubuntu"
            OS_TYPE="debian"
            ;;
        arch)
            echo -e " $COLOR_SUCCESS 系统是 $COLOR_RESET arch"
            OS_TYPE="arch"
            ;;
        *)
            echo -e " $COLOR_ERROR 不支持的操作系统: $ID $COLOR_RESET "
            exit 1
            ;;
    esac
}

#输入法
#fcitx5
FCITX5_PACKAGE=(
    "fcitx5"
    "fcitx5-chinese-addons"
    "fcitx5-configtool"
    "fcitx5-gtk"
    "fcitx5-qt"
    "fcitx5-rime"
    "rime-cantonese"
    "rime-simp"
    "rime-traditional"
    "rime-emoji"
    "rime-quick"
    "rime-words"
    "liberime"
    "fcitx5-qt5"
    "fcitx5-qt6"
    "fcitx5-gtk2"
    "fcitx5-gtk3"
    "fcitx5-gtk4"
    "fcitx5-module-cloudpinyin"
    "fcitx5-module-kimpanel"
    "fcitx5-module-x11"
    "fcitx5-module-wayland"
    "fcitx5-module-dbus"
    "fcitx5-module-gtk"
    "fcitx5-module-qt"
    "fcitx5-module-qt6"
    "fcitx5-module-qt5"
    "fcitx5-module-gtk3"
    "fcitx5-module-gtk4"
    "fcitx5-module-x11"
    "fcitx5-module-wayland"
    "fcitx5-module-dbus"
)
#ibus
IBUS_PACKAGE=(
    "ibus"
    "ibus-clutter"
    "ibus-gtk"
    "ibus-gtk3"
    "ibus-qt4"
    "ibus-qt5"
    "ibus-qt6"
    "ibus-rime"
    "rime-cantonese"
    "rime-simp"
    "rime-traditional"
    "rime-emoji"
    "rime-quick"
    "rime-words"
)
#输入法选择
INPUT_METHOD_SELECTION() {
    echo -e "Choose your input method firmware："
    echo "1) fcitx5 (Recommended)"
    echo "2) ibus"
    read -p "Option (1 or 2): " input_method_choice
    if [ "$input_method_choice" == "1" ]; then
        INPUT_METHOD="fcitx5"
        log_info " fcitx5 is selected "
    elif [ "$input_method_choice" == "2" ]; then
        INPUT_METHOD="ibus"
        log_info " ibus is selected "
    else
        log_error " Invalid choice. Please run the script again and select 1 or 2. "
        exit 1
    fi
}
#输入法配置
INPUT_METHOD_CONFIG() {
    if [ "$INPUT_METHOD" == "fcitx5" ]; then
        echo -e " $COLOR_INFO Configuring fcitx5 as the default input method... $COLOR_RESET "
        #设置环境变量
        echo "export XMODIFIERS=@im=fcitx5" >> /etc/profile.d/fcitx5.sh
        echo "export GTK_IM_MODULE=fcitx5" >> /etc/profile.d/fcitx5.sh
        echo "export QT_IM_MODULE=fcitx5" >> /etc/profile.d/fcitx5.sh
        echo "export CLUTTER_IM_MODULE=fcitx5" >> /etc/profile.d/fcitx5.sh
        source /etc/profile.d/fcitx5.sh
        log_success " fcitx5 configured successfully. Please log out and log back in for changes to take effect. "
    elif [ "$INPUT_METHOD" == "ibus" ]; then
        echo -e " $COLOR_INFO Configuring ibus as the default input method... $COLOR_RESET "
        #设置环境变量
        echo "export XMODIFIERS=@im=ibus" >> /etc/profile.d/ibus.sh
        echo "export GTK_IM_MODULE=ibus" >> /etc/profile.d/ibus.sh
        echo "export QT_IM_MODULE=ibus" >> /etc/profile.d/ibus.sh
        echo "export CLUTTER_IM_MODULE=ibus" >> /etc/profile.d/ibus.sh
        source /etc/profile.d/ibus.sh
        log_success " ibus configured successfully. Please log out and log back in for changes to take effect. "
    fi
}

#Ubuntu安装函数
UBUNTU_INSTALL() {
    echo -e " $COLOR_INFO Begin to chinesization your system... $COLOR_RESET "
    #更新软件源
    apt upgrade -y
    #安装输入法
    if [ "$INPUT_METHOD" == "fcitx5" ]; then
        for package in "${FCITX5_PACKAGE[@]}"; do
            if dpkg -l | grep -qw "$package"; then
                echo -e " $COLOR_WARN $package is already installed, skip. $COLOR_RESET
            else
                echo -e " $COLOR_INFO Installing $package ... $COLOR_RESET "
                if apt install -y "$package"; then
                    echo -e " $COLOR_SUCCESS $package installed successfully. $COLOR_RESET "
                else
                    echo -e " $COLOR_ERROR Failed to install $package. $COLOR_RESET "
                fi
            fi
        done
    elif [ "$INPUT_METHOD" == "ibus" ]; then
        for package in "${IBUS_PACKAGE[@]}"; do
            if dpkg -l | grep -qw "$package"; then
                echo -e " $COLOR_WARN $package is already installed, skip. $COLOR_RESET
            else
                echo -e " $COLOR_INFO Installing $package ... $COLOR_RESET "
                if apt install -y "$package"; then
                    echo -e " $COLOR_SUCCESS $package installed successfully. $COLOR_RESET "
                else
                    echo -e " $COLOR_ERROR Failed to install $package. $COLOR_RESET "
                fi
            fi
        done
    fi
    #配置输入法
    INPUT_METHOD_CONFIG
    echo -e " $COLOR_SUCCESS Chinesization completed. Please restart your system to apply all changes. $COLOR_RESET "
}  

#修改locale
modify_locale() {
    echo -e " $COLOR_INFO Modifying system locale to zh_CN.UTF-8... $COLOR_RESET "
    local locale_file="/etc/locale.conf"
    
    # 备份当前locale文件
    cp "$locale_file" "${locale_file}.bak_$(date +%Y%m%d_%H%M%S)"
    
    # 修改locale文件
    echo "LANG=zh_CN.UTF-8" > "$locale_file"
    
    # 重新生成locale
    if [ -f /etc/locale.gen ]; then
        sed -i 's/^# *\(zh_CN.UTF-8 UTF-8\)/\1/' /etc/locale.gen
        locale-gen
    elif [ -f /etc/locale.gen.d/ ]; then
        echo "zh_CN.UTF-8 UTF-8" > /etc/locale.gen.d/zh_CN.conf
        locale-gen
    else
        log_warn " Locale generation file not found. Please ensure zh_CN.UTF-8 is generated manually if necessary. "
    fi
    
    # 应用新的locale设置
    source "$locale_file"
    
    echo -e " $COLOR_SUCCESS System locale modified to zh_CN.UTF-8. $COLOR_RESET "
}

#fedora安装函数
FEDORA_INSTALL() {
    echo -e " $COLOR_INFO Begin to chinesization your system... $COLOR_RESET "
    #更新软件源
    dnf upgrade -y
    #安装输入法
    if [ "$INPUT_METHOD" == "fcitx5" ]; then
        for package in "${FCITX5_PACKAGE[@]}"; do
            if dnf list installed "$package" &> /dev/null; then
                echo -e " $COLOR_WARN $package is already installed, skip. $COLOR_RESET
            else
                echo -e " $COLOR_INFO Installing $package ... $COLOR_RESET "
                if dnf install -y "$package"; then
                    echo -e " $COLOR_SUCCESS $package installed successfully. $COLOR_RESET "
                else
                    echo -e " $COLOR_ERROR Failed to install $package. $COLOR_RESET "
                fi
            fi
        done
    elif [ "$INPUT_METHOD" == "ibus" ]; then
        for package in "${IBUS_PACKAGE[@]}"; do
            if dnf list installed "$package" &> /dev/null; then
                echo -e " $COLOR_WARN $package is already installed, skip. $COLOR_RESET
            else
                echo -e " $COLOR_INFO Installing $package ... $COLOR_RESET "
                if dnf install -y "$package"; then
                    echo -e " $COLOR_SUCCESS $package installed successfully. $COLOR_RESET "
                else
                    echo -e " $COLOR_ERROR Failed to install $package. $COLOR_RESET "
                fi
            fi
        done
    fi
    #配置输入法
    INPUT_METHOD_CONFIG
    echo -e " $COLOR_SUCCESS Chinesization completed. Please restart your system to apply all changes. $COLOR_RESET "
}

#arch安装函数
ARCH_INSTALL() {
    echo -e " $COLOR_INFO Begin to chinesization your system... $COLOR_RESET "
    #更新软件源
    pacman -Syu --noconfirm
    #安装输入法
    if [ "$INPUT_METHOD" == "fcitx5" ]; then
        for package in "${FCITX5_PACKAGE[@]}"; do
            if pacman -Qi "$package" &> /dev/null; then
                echo -e " $COLOR_WARN $package is already installed, skip. $COLOR_RESET
            else
                echo -e " $COLOR_INFO Installing $package ... $COLOR_RESET "
                if pacman -S --noconfirm "$package"; then
                    echo -e " $COLOR_SUCCESS $package installed successfully. $COLOR_RESET "
                else
                    echo -e " $COLOR_ERROR Failed to install $package. $COLOR_RESET "
                fi
            fi
        done
    elif [ "$INPUT_METHOD" == "ibus" ]; then
        for package in "${IBUS_PACKAGE[@]}"; do
            if pacman -Qi "$package" &> /dev/null; then
                echo -e " $COLOR_WARN $package is already installed, skip. $COLOR_RESET
            else
                echo -e " $COLOR_INFO Installing $package ... $COLOR_RESET "
                if pacman -S --noconfirm "$package"; then
                    echo -e " $COLOR_SUCCESS $package installed successfully. $COLOR_RESET "
                else
                    echo -e " $COLOR_ERROR Failed to install $package. $COLOR_RESET "
                fi
            fi
        done
    fi
    #配置输入法
    INPUT_METHOD_CONFIG
    echo -e " $COLOR_SUCCESS Chinesization completed. Please restart your system to apply all changes. $COLOR_RESET "
}

# --- 主程序 ---
check_root
#检测系统
if [ -f /etc/os-release ]; then
    source /etc/os-release
    check_os
else
    echo -e " $COLOR_ERROR Your system is not scanned $COLOR_RESET "
    exit 1
fi
#选择输入法
INPUT_METHOD_SELECTION
#根据系统类型调用相应的安装函数
case $OS_TYPE in
    fedora)
        FEDORA_INSTALL
        ;;
    debian)
        UBUNTU_INSTALL
        ;;
    arch)
        ARCH_INSTALL
        ;;
    *)
        echo -e " $COLOR_ERROR Unsupported System: $OS_TYPE $COLOR_RESET "
        exit 1
        ;;
esac
#修改locale
modify_locale
#提示
echo -e " $COLOR_SUCCESS Please restart your system to apply all changes. $COLOR_RESET "
read -p "You want to restart now? (y/n): " restart_choice
if [[ "$restart_choice" =~ ^[Yy]$ ]]; then
    reboot
else
    echo -e " $COLOR_INFO Please remember to restart your system later to apply all changes. $COLOR_RESET "
fi
exit 0