#!/bin/bash

# =================================================================================================
# 脚本名称：   waydroid_installer_part1.sh
# 描述：       Waydroid(安卓模拟器)安装脚本 - 第1部分
#              完成系统检查和基础环境配置
# 作者：       XianYin_69
# 参考来源：   https://www.tqhyg.net/post517.html
# 日期：       2025-08-19
# =================================================================================================

main() {
    # --- 常量定义 ---
    readonly DEBIAN_DEPS=(
        "lxc"
        "python3"
        "adb"
        "waydroid"
    )

    readonly FEDORA_DEPS=(
        "lxc"
        "python3"
        "adb"
        "waydroid"
    )

    readonly WAYDROID_REPO_URL="https://repo.waydro.id"

    # 根据系统类型安装
    case $OS_TYPE in
        debian)
            WAYDROID_INSTALLER_PART_1_DEBIAN_INFO
            apt install -y "${DEBIAN_DEPS[@]}" ; WAYDROID_INSTALLER_PART_1_DEBIAN_SUCCESS
            curl "${WAYDROID_REPO_URL}" | bash ; WAYDROID_INSTALLER_PART_1_DEBIAN_ADD_REPO_SUCCESS
            apt install -y waydroid ; WAYDROID_INSTALLER_PART_1_DEBIAN_INSTALL_SUCCESS
            ;;
            
        fedora)
            WAYDROID_INSTALLER_PART_1_FEDORA_INFO
            dnf install -y "${FEDORA_DEPS[@]}" ; WAYDROID_INSTALLER_PART_1_FEDORA_SUCCESS
            curl "${WAYDROID_REPO_URL}" | bash ; WAYDROID_INSTALLER_PART_1_FEDORA_ADD_REPO_SUCCESS
            dnf install -y waydroid ; WAYDROID_INSTALLER_PART_1_FEDORA_INSTALL_SUCCESS
            ;;
        arch)
            WAYDROID_INSTALLELR_PART_1_ARCH_INFO
            sudo pacman -S lxc python3 adb --noconfirm
            curl https://repo.waydro.id | sudo bash
            sudo pacman -S waydroid --noconfirm
            ;;
        *)
            WAYDROID_INSTALLELR_PART_1_UNSUPPORTED_OS_INFO
            exit 1
            ;;
    esac
}