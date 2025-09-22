#!/bin/bash
# =================================================================================================
# 脚本名称：   install_software.sh
# 描述：       软件批量安装器
# 作者：       XianYin_69
# 参考来源：   none
# 日期：       8-31-2025
# =================================================================================================

# 读取用户软件列表（software_list.txt）
software_list() {
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
fedora_install() {
    SOFTWARE_INSTALLER_FEDORA_INSTALLER_INFO
    # 使用dnf安装软件
    for package in "${SOFTWARE_LIST[@]}"; do
        if dnf list installed "$package" &> /dev/null; then
            SOFTWARE_INSTALLER_FEDORA_DNF_INFO $package
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
ubuntu_install() {
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
arch_installer() {
    SOFTWARE_INSTALLER_ARCH_PACMAN_INFO
    # 使用pacman安装软件
    for package in "${SOFTWARE_LIST[@]}"; do
        if pacman -Qi "$package" &> /dev/null; then
            SOFTWARE_INSTALLER_ARCH_PACMAN_INFO $package
            if pacman -S --noconfirm "$package"; then
                SOFTWARE_INSTALLER_ARCH_PACMAN_SUCCESS $package
            else
                SOFTWARE_INSTALLER_ARCH_PACMAN_ERROR $package
            fi
        else
            SOFTWARE_INSTALLER_ARCH_PACMAN_SKIP_WARN $package
        fi
    done
}

#snap检测及安装
snap_install() {
    if ! command -v snap &> /dev/null; then
        SOFTWARE_INSTALLER_SNAP_NOT_INSTALLED_INFO
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
        SOFTWARE_INSTALLER_SNAP_INSTALL_SUCCESS
    else
        SOFTWARE_INSTALLER_SNAP_INSTALLED_INFO
    fi

    # 使用snap安装软件
    for package in "${SNAP_PREFERRED_LIST[@]}"; do
        if snap list | grep -q "$package "; then
            SOFTWARE_INSTALLER_SNAP_INSTALL_SKIP_WARN $package
        else
            SOFTWARE_INSTALLER_SNAP_INSTALLER_INFO $package
            if snap install "$package"; then
                SOFTWARE_INSTALLER_SNAP_INSTALL_SUCCESS $package
            else
                SOFTWARE_INSTALLER_SNAP_INSTALL_ERROR $package
            fi
        fi
    done
}

#flatpak检测及安装
flatpak_install() {
    if ! command -v flatpak &> /dev/null; then
        SOFTWARE_INSTALLER_FLATPAK_NOT_INSTALLED_INFO
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
        SOFTWARE_INSTALLER_FLATPAK_INSTALL_SUCCESS
    else
        SOFTWARE_INSTALLER_FLATAPAK_INSTALL_SKIP_WARN
    fi
    # 使用flatpak安装软件
    for package in "${FLATPKG_LIST[@]}"; do
        if flatpak list | grep -q "^$package "; then
            SOFTWARE_INSTALLER_FLATPAK_INSTALLER_SKIP_WARN $package
        else
            SOFTWARE_INSTALLER_FLATPAK_INSTALL_INFO $package
            if flatpak install -y flathub "$package"; then
                SOFTWARE_INSTALLER_FLATPAK_INSTALL_SUCCESS $package
            else
                SOFTWARE_INSTALLER_FLATPAK_INSTALL_ERROR $package
            fi
        fi
    done
}

# 主程序
software_list
snap_install
flatpak_install
exit 0