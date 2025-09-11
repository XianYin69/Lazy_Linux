#!/bin/bash
# =================================================================================================
# 脚本名称：   install_software.sh
# 描述：       软件批量安装器
# 作者：       XianYin_69
# 参考来源：   none
# 日期：       8-31-2025
# =================================================================================================

#颜色
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly BLUE='\033[0;34m'
readonly NC='\033[0m' # No Color

#日志函数
log_info() {
    echo -e "${BLUE}[信息]${NC} $1"
}
log_success() {
    echo -e "${GREEN}[成功]${NC} $1"
}
log_error() {
    echo -e "${RED}[错误]${NC} $1"
}
log_warn() {
    echo -e "${YELLOW}[警告]${NC} $1"
}

set -e  # 遇到错误立即退出

# 检查是否以root用户运行
ROOT_CHECK() {
    if [ $EUID -ne 0 ]; then
    log_error "请以root用户运行此脚本"
    exit 1
    fi
}

OS_TYPE() {
    source /etc/os-release
    case $ID in
        fedora|centos|rhel)
            OS_TYPE="fedora"
            log_info "你的系统是fedora,cent os或rhel及他们的衍生物"
        ;;
        debian|ubuntu|kali)
            OS_TYPE="debian"
            log_info "你的系统是debian,ubuntu或kali及他们的衍生物"            
        ;;
        arch)
            OS_TYPE="arch"
            log_info "你的系统是arch及其衍生物"
        ;;
        *)
            log_error "不受支持的操作系统"
            exit 1
        ;;
    esac
}


# 读取用户软件列表（software_list.txt）
SOFTWARE_LIST() {
    read -p "请输入文件路径:" FILE_PATH
    #检查文件是否存在
    if [ ! -f "$FILE_PATH" ]; then
        log_error "文件不存在，请检查路径后重试。"
        exit 1
    fi
    # 读取文件内容
    source "$FILE_PATH"
    if  [ ${#SOFTWARE_LIST[@]} -eq 0 ] && [ ${#SNAP_PREFERRED_LIST[@]} -eq 0 ] && [ ${#FLATPKG_LIST[@]} -eq 0 ]; then
        log_error "软件列表为空，请检查文件内容。"
        exit 1
    else
        log_success "软件列表读取成功。"
    fi
}
#fedora安装函数
FEDORA_INSTALL() {
    log_info "开始安装软件..."
    # 使用dnf安装软件
    for package in "${SOFTWARE_LIST[@]}"; do
        if dnf list installed "$package" &> /dev/null; then
            log_info "正在安装 $package ..."
            if dnf install -y "$package"; then
                log_success "$package 安装成功。"
            else
                log_error "$package 安装失败。"
            fi
        else
            log_warn "$package 已经安装，跳过。"
        fi
    done
}

#ubuntu安装函数
UBUNTU_INSTALL() {
    log_info "开始安装软件..."
    # 使用apt安装软件
    for package in "${SOFTWARE_LIST[@]}"; do
        if apt list --installed "$package" &> /dev/null; then
            log_info "正在安装 $package ..."
            if apt install -y "$package"; then
                log_success "$package 安装成功。"
            else
                log_error "$package 安装失败。"
            fi
        else
            log_warn "$package 已经安装，跳过。"
        fi
    done
}

#arch安装函数
ARCH_INSTALL() {
    log_info "开始安装软件..."
    # 使用pacman安装软件
    for package in "${SOFTWARE_LIST[@]}"; do
        if pacman -Qi "$package" &> /dev/null; then
            log_info "正在安装 $package ..."
            if pacman -S --noconfirm "$package"; then
                log_success "$package 安装成功。"
            else
                log_error "$package 安装失败。"
            fi
        else
            log_warn "$package 已经安装，跳过。"
        fi
    done
}

#snap检测及安装
SNAP_INSTALL() {
    if ! command -v snap &> /dev/null; then
        log_warn "Snap 未安装，正在安装 Snap..."
        case $OS_TYPE in
            fedora)
                dnf install -y snapd
                systemctl enable --now snapd.socket
                ln -s /var/lib/snapd/snap /snap
                ;;
            debian)
                apt update
                apt install -y snapd
                systemctl enable --now snapd.socket
                ;;
            arch)
                pacman -S --noconfirm snapd
                systemctl enable --now snapd.socket
                ;;
        esac
        log_success "Snap 安装完成。"
    else
        log_info "Snap 已安装。"
    fi

    # 使用snap安装软件
    for package in "${SNAP_PREFERRED_LIST[@]}"; do
        if snap list | grep -q "$package "; then
            log_warn "$package 已经通过 Snap 安装，跳过。"
        else
            log_info "正在通过 Snap 安装 $package ..."
            if snap install "$package"; then
                log_success "$package 通过 Snap 安装成功。"
            else
                log_error "$package 通过 Snap 安装失败。"
            fi
        fi
    done
}

#flatpak检测及安装
FLATPKG_INSTALL() {
    if ! command -v flatpak &> /dev/null; then
        log_warn "Flatpak 未安装，正在安装 Flatpak..."
        case $OS_TYPE in
            fedora)
                dnf install -y flatpak
                ;;
            debian)
                apt update
                apt install -y flatpak
                ;;
            arch)
                pacman -S --noconfirm flatpak
                ;;
        esac
        log_success "Flatpak 安装完成。"
    else
        log_info "Flatpak 已安装。"
    fi
    # 使用flatpak安装软件
    for package in "${FLATPKG_LIST[@]}"; do
        if flatpak list | grep -q "^$package "; then
            log_warn "$package 已经通过 Flatpak 安装，跳过。"
        else
            log_info "正在通过 Flatpak 安装 $package ..."
            if flatpak install -y flathub "$package"; then
                log_success "$package 通过 Flatpak 安装成功。"
            else
                log_error "$package 通过 Flatpak 安装失败。"
            fi
        fi
    done
}

# 主程序
ROOT_CHECK
OS_TYPE
SOFTWARE_LIST
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
esac
SNAP_INSTALL
FLATPKG_INSTALL
log_success "所有软件安装过程完成。"
exit 0