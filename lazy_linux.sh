#!/bin/bash
# =================================================================================================
# 脚本名称：lazy_linux.sh
# 描述：此为整个工具集的启动器
# 作者：XianYin69
# 参考来源：无
# 日期：9-10-2025 
# =================================================================================================

source "./stack/state/STATE.txt"

OS_TYPE=""
KERNEL_VERSION=""
SESSION_TYPE=""

#系统检测
system_check() {
    source "/etc/os-release"
    OS_TYPE=$ID
    sed -i 's/OS_TYPE=*/OS_TYPE=$OS_TYPE' ./stack/state/STATE.txt
    KERNEL_VERSION=${uname -r}
    sed -i 's/KERNEL_VERSION=*/KERNEL_VERSION=$KERNEL_VERSION' ./stack/state/STATE.txt
    SESSION_TYPE=$XDG_SESSION_TYPE
    sed -i 's/SESSION_TYPE=*/SESSION_TYPE=$SEESION_TYPE' ./stack/state/STATE.txt
}

#语言选择
select_luncher_language() {
    while :
    do
        echo  "Please choose your language:"
        echo  "1.中文"
        echo  "2.English"
        read -p ":" LUNCHER_LANGUAGE
        if [ $LUNCHER_LANGUAGE -eq 1 ]
        then
            sed 's/STATE_LANG=*/STATE_LANG=ch' ./stack/state/STATE.txt
            break
        elif [ $LUNCHER_LANGUAGE -eq 2 ]
        then
            sed 's/STATE_LANG=*/STATE_LANG=en' ./stack/state/STATE.txt
            break
        else
            echo "You must select one!"
        fi
    done
}

#语言初始化
language_choose() {
    if [ TTY_MODE -eq "N" ]
    then
        if [ STATE_LANG -eq "ch" ]; then
            source "./lang/zh-CN-info.sh"
        elif [ STATE_LANG -eq "en" ]; then
            source "./lang/en-US-info.sh"
        elif [ STATE_LANG -eq "initing" ]; then
            select_luncher_language
        else
            source "./lang/en-US-info.sh"
        fi
    else
        source "./lang/en-US-info.sh"
    fi
}

#子菜单
initialize_toolkit() {
    LAZY_LINUX_SH_INITIALIZE_TOOLKIT_INFO
    local choice
    read -p ":" choice
    while :
    do
        case $choice in
            1)
                sudo bash ./lib/initialize_toolkit/chinesization.sh
                break
            ;;
            2)
                sudo bash ./lib/initialize_toolkit/init_git.sh
                break
            ;;
            *)
                LAZY_LINUX_SH_INITIALIZE_TOOLKIT_CHOICE_ERROR
            ;;
        esac
    done
}

linux_configurer() {
    local choice
    LOG_WARN 'cat ./lib/linux_configurer/NOTICE.txt'
    LAZY_LINUX_SH_LINUX_CONFIGURER_INFO
    read -p ":" choice
    while :
    do
        case $choice in
            1)
                sudo bash ./lib/linux_configurer/kernel_cleaner/super_clean_old_kernel.sh
            ;;
            2)
                sudo bash ./lib/linux_configurer/nvidia_driver_installer/nvidia_driver_installer_init.sh
            ;;
            *)
                LAZY_LINUX_SH_LINUX_CONFIGURER_CHOICE_ERROR
            ;;
        esac
    done
}

backup_and_restore() {
    local choice
    LAZY_LINUX_SH_BACKUP_AND_RESTORE_INFO
    read -p ":" choice
    while :
    do
        case $choice in
            1)
                sudo bash ./lib/backup_and_restore/backup.sh
                break
            ;;
            2)
                sudo bash ./lib/backup_and_restore/restore.sh
                break
            ;;
            *)
                LAZY_LINUX_SH_BACKUP_AND_RESTORE_CHOICE_ERROR
            ;;
        esac
    done
}

software_installer() {
    local choice
    LAZY_LINUX_SH_SOFTWARE_INSTALLER_INFO
    read -p ":" choice
    while :
    do
        if choice ~= ^[Yy]
        then
            sudo bash ./lib/software_installer/software_installer.sh
            break
        else
            LAZY_LINUX_SH_SOFTWARE_INSTALLER_CHOICE_ERROR
        fi
    done
}

waydroid() {
    local choice
    LAZY_LINUX_SH_WAYDROID_INFO
    read -p ":" choice
    while :
    do
        case $choice in
            1)
                sudo bash ./lib/waydroid_installer_init.sh
            ;;
            2)
                sduo bash ./lib/apk_installer.sh
            ;;
            *)
                LAZY_LINUX_SH_WAYDROID_ERROR
            ;;
        esac
    done
}

#菜单
script_choice() {
    local choice
    LAZY_LINUX_SH_SCRIPTS_SELECT_INFO
    read -p ":" choice 
    case $choice in
        1)
            initialize_toolkit
        ;;
        2)
            software_installer
        ;;
        3)
            linux_configurer
        ;;
        4)
            waydroid
        ;;
        5)
            backup_and_restore
        ;;
        *)
            LAZY_LINUX_SH_SCRIPTS_SELECT_ERROR
        ;;
    esac
}


#使用次数增加
time_plus() {
    local time=$(grep -oP 'TIME=\k.*' ./stack/state/STATE.txt)
    time_plus=$(($time+1))
    sed -i "s/TIME=.*/TIME=$time_plus/" ./stack/state/STATE.txt
}

#主函数
language_choose
system_check
SYSTEM_OS_TYPE_INFO "OS_TYPE"
SYSTEM_KERNEL_VERSION_INFO "KERNEL_VERSION"
SYSTEM_SESSION_TYPE_INFO "SESSION_TYPE"
time_plus
script_choice
exit 0