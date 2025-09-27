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
            if sudo apt install -y "${DEBIAN_DEPS[@]}"
            then
                WAYDROID_INSTALLER_PART_1_INSTALL_1_SUCCESS
            else
                WAYDROID_INSTALLER_PART_1_INSTALL_1_ERROR
                exit 1
            fi

            if sudo curl "${WAYDROID_REPO_URL}" | bash 
            then
                WAYDROID_INSTALLER_PART_1_ADD_REPO_SUCCESS
            else
                WAYDROID_INSTALLER_PART_1_ADD_REPO_SUCCESS
                exit 1
            fi

            if sudo apt install -y waydroid
            then
                WAYDROID_INSTALLER_PART_1_INSTALL_2_SUCCESS
            else
                WAYDROID_INSTALLER_PART_1_INSTALL_2_ERROR
                exit 1
            fi
            ;;
        fedora)
            WAYDROID_INSTALLER_PART_1_FEDORA_INFO
            if sudo dnf install -y "${DEBIAN_DEPS[@]}"
            then
                WAYDROID_INSTALLER_PART_1_INSTALL_1_SUCCESS
            else
                WAYDROID_INSTALLER_PART_1_INSTALL_1_ERROR
                exit 1
            fi

            if sudo curl "${WAYDROID_REPO_URL}" | bash 
            then
                WAYDROID_INSTALLER_PART_1_ADD_REPO_SUCCESS
            else
                WAYDROID_INSTALLER_PART_1_ADD_REPO_SUCCESS
                exit 1
            fi

            if sudo dnf install -y waydroid
            then
                WAYDROID_INSTALLER_PART_1_INSTALL_2_SUCCESS
            else
                WAYDROID_INSTALLER_PART_1_INSTALL_2_ERROR
                exit 1
            fi
            ;;
        arch)
            WAYDROID_INSTALLELR_PART_1_ARCH_INFO
            if sudo pacman -S lxc python3 adb --noconfirm
            then 
                WAYDROID_INSTALLER_PART_1_INSTALL_1_SUCCESS
            else
                WAYDROID_INSTALLER_PART_1_INSTALL_1_ERROR
                exit 1
            fi

            if sudo curl https://repo.waydro.id | sudo bash
            then
                WAYDROID_INSTALLER_PART_1_ADD_REPO_SUCCESS
            else
                WAYDROID_INSTALLER_PART_1_ADD_REPO_ERROR
                exit 1
            fi

            if sudo pacman -S waydroid --noconfirm
            then
                WAYDROID_INSTALLER_PART_1_INSTALL_2_SUCCESS
            else
                WAYDROID_INSTALLER_PART_1_INSTALL_2_ERROR
                exit 1
            fi
            ;;
        *)
            WAYDROID_INSTALLELR_PART_1_UNSUPPORTED_OS_INFO
            exit 1
            ;;
    esac
}