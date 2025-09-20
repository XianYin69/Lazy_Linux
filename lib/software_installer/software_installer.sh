#!/bin/bash
# =================================================================================================
# 脚本名称：   install_software.sh
# 描述：       软件批量安装器
# 作者：       XianYin_69
# 参考来源：   none
# 日期：       8-31-2025
# =================================================================================================

OS_TYPE() {
    source /etc/os-release
    case $ID in
        fedora|centos|rhel)
            OS_TYPE="fedora"
            SOFTWARE_INSTALLER_FEDORA_INFO
        ;;
        debian|ubuntu|kali)
            OS_TYPE="debian"
            SOFTWARE_INSTALLER_DEBIAN_INFO            
        ;;
        arch)
            OS_TYPE="arch"
            SOFTWARE_INSTALLER_ARCH_INFO
        ;;
        *)
            SOFTWARE_INSTALLER_OS_NOT_SUPPORTED_ERROR
            exit 1
        ;;
    esac
}


# 读取用户软件列表（software_list.txt）
SOFTWARE_LIST() {
    check_software_list_file() {
        SOFTWARE_INSTALLER_READING_SOFTWARE_LIST_INFO
        read -p ":" FILE_PATH
    }
    while :
    do
        check_software_list_file
        if [ -f "$FILE_PATH" ]; then
            SOFTWARE_INSTALLER_SOFTWARE_LIST_PATH_SUCCESS
            break
        elif [ -f "$SOFTWARE_LIST_PATH" ]; then
            FILE_PATH="$SOFTWARE_LIST_PATH"
            SOFTWARE_INSTALLER_SOFTWARE_LIST_PATH_SUCCESS
            break
        else
            check_software_list_file
        fi
    done
    # 读取文件内容
    while :
    do
        source "$FILE_PATH"
        if  [ ${#SOFTWARE_LIST[@]} -eq 0 ] && [ ${#SNAP_PREFERRED_LIST[@]} -eq 0 ] && [ ${#FLATPKG_LIST[@]} -eq 0 ]; then
            SOFTWARE_INSTALLER_FILE_READING_ERROR
            sleep 10
            nano "$FILE_PATH"
        else
            SOFTWARE_INSTALLER_FILE_READING_SUCCESS
            break
        fi
    done
}
#fedora安装函数
FEDORA_INSTALL() {
    SOFTWARE_INSTALELR_FEDORA_INSTALLER_INFO
    # 使用dnf安装软件
    for package in "${SOFTWARE_LIST[@]}"; do
        if dnf list installed "$package" &> /dev/null; then
            SOFTWARE_INSTALLER_FEODRA_DNF_INFO $package
            if dnf install -y "$package"; then
                SOFTWARE_INSTALLER_FEDORA_DNF_SUCCESS $package
            else
                SOFTWARE_INSTALLER_FEDORA_DNF_ERROR $package
            fi
        else
            SOFTWARE_INSTALLER_FEDORA_DNF_SKIP_WARN $package
        fi
    done
}

#ubuntu安装函数
UBUNTU_INSTALL() {
    SOFTWARE_INSTALLER_DEBIAN_INFO
    # 使用apt安装软件
    for package in "${SOFTWARE_LIST[@]}"; do
        if apt list --installed "$package" &> /dev/null; then
            SOFTWARE_INSTALLER_DEBIAN_APT_INFO
            if apt install -y "$package"; then
                SOFTWARE_INSTALLER_DEBIAN_APT_SUCCESS $package
            else
                SOFTWARE_INSTALLER_DEBIAN_APT_ERROR $package
            fi
        else
            SOFTWARE_INSTALLER_DEBIAN_APT_SKIP_WARN $package
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