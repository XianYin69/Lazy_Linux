#!/bin/bash
# =================================================================================================
# 脚本名称：lazy_linux.sh
# 描述：此为整个工具集的启动器
# 作者：XianYin69
# 参考来源：无
# 日期：9-10-2025 
# =================================================================================================

#定义行为
source_shell() {
    source "./var/index/filepath.sh"
    source $STATE_PATH
}

source_shell_end() {
    source "./var/index/filepath.sh"
}

OS_TYPE=""
KERNEL_VERSION=""
SESSION_TYPE=""

#系统检测
system_check() {
    source_shell
    source "/etc/os-release"
    OS_TYPE=$ID
    sed -i "s/OS_TYPE=.*/OS_TYPE=$OS_TYPE/g" $STATE_PATH
    KERNEL_VERSION=$(uname -r)
    sed -i "s/KERNEL_VERSION=.*/KERNEL_VERSION=$KERNEL_VERSION/g" $STATE_PATH
    SESSION_TYPE=$XDG_SESSION_TYPE
    sed -i "s/SESSION_TYPE=.*/SESSION_TYPE=$SESSION_TYPE/g" $STATE_PATH
    source "./stack/state/STATE.sh"
    #检测是否是TTY模式
    if [ $SESSION_TYPE = "tty" ]; then
        TTY_MODE="Y"
        sed -i "s/TTY_MODE=.*/TTY_MODE=$TTY_MODE/g" $STATE_PATH
    else
        TTY_MODE="N"
        sed -i "s/TTY_MODE=.*/TTY_MODE=$TTY_MODE/g" $STATE_PATH
    fi
    source_shell_end
}

#语言选择
select_launcher_language() {
    source_shell
    while :
    do
        echo  "Please choose your language:"
        echo  "1.中文"
        echo  "2.English"
        read -p ":" LAUNCHER_LANGUAGE
        if [ "$LAUNCHER_LANGUAGE" -eq 1 ]; 
        then
            sed -i "s/STATE_LANG=.*/STATE_LANG=ch/g" $STATE_PATH
            break
        elif [ "$LAUNCHER_LANGUAGE" -eq 2 ]; 
        then
            sed -i "s/STATE_LANG=.*/STATE_LANG=en/g" $STATE_PATH
            break
        else
            echo "You must select one!"
        fi
    done
    source_shell_end
}

#语言初始化
language_choose() {
    source_shell
    if [ "$TTY_MODE" = "N" ]
    then
        if [ "$STATE_LANG" = "ch" ]; then
            source "./lang/zh-CN-info.sh"
        elif [ "$STATE_LANG" = "en" ]; then
            source "./lang/en-US-info.sh"
        elif [ "$STATE_LANG" = "initing" ]; then
            select_launcher_language
        else
            source "./lang/en-US-info.sh"
        fi
    else
        source "./lang/en-US-info.sh"
    fi
    source_shell_end
}

#子菜单
initialize_toolkit() {
    source_shell
    local choice
    while :
    do
        LAZY_LINUX_SH_INITIALIZE_TOOLKIT_INFO
        read -p ":" choice
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
    source_shell_end
}

linux_configurer() {
    source_shell
    local choice
    if [[ $OS_TYPE == "fedora" || $OS_TYPE == "centos" || $OS_TYPE == "rhel" ]]
    then
        while :
        do
            LAZY_LINUX_SH_LINUX_CONFIGURER_INFO_FEDORA
            read -p ":" choice
            case $choice in
                1)
                    sudo bash ./lib/linux_configurer/nvidia_driver_installer/installer.sh
                    break
                ;;
                2)
                    sudo bash ./lib/linux_configurer/touchpad_configurer/touchpad_configurer.sh
                    break
                ;;
                *)
                    LAZY_LINUX_SH_LINUX_CONFIGURER_CHOICE_ERROR
                ;;
            esac
        done
    else
        log_error "仅支持Fedora系发行版！！！(Only Fedora-based distributions are supported!!!)"
        exit 1
    fi
    source_shell_end
}

backup_and_restore() {
    source_shell
    local choice
    while :
    do
        LAZY_LINUX_SH_BACKUP_AND_RESTORE_INFO
        read -p ":" choice
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
    source_shell_end
}

software_installer() {
    source_shell
    local choice
    while :
    do
        LAZY_LINUX_SH_SOFTWARE_INSTALLER_INFO
        read -p ":" choice
        if [[ $choice =~ ^[Yy] ]]
        then
            sudo bash ./lib/software_installer/software_installer.sh
            break
        else
            LAZY_LINUX_SH_SOFTWARE_INSTALLER_CHOICE_ERROR
        fi
    done
    source_shell_end
}

waydroid() {
    source_shell
    local choice
    while :
    do
        LAZY_LINUX_SH_WAYDROID_INFO
        read -p ":" choice
        case $choice in
            1)
                sudo bash ./lib/waydroid/waydroid_installer/installer.sh
                break
            ;;
            2)
                sudo bash ./lib/waydroid/waydroid_configurer/apk_installer.sh
                break
            ;;
            *)
                LAZY_LINUX_SH_WAYDROID_ERROR
            ;;
        esac
    done
    source_shell_end
}

#菜单
script_choice() {
    source_shell
    local choice
    while true
    do
        LAZY_LINUX_SH_SCRIPTS_SELECT_INFO
        read -p ":" choice 
        case $choice in
            1)
                initialize_toolkit
                break
            ;;
            2)
                software_installer
                break
            ;;
            3)
                linux_configurer
                break
            ;;
            4)
                waydroid
                break
            ;;
            5)
                backup_and_restore
                break
            ;;
            *)
                LAZY_LINUX_SH_SCRIPTS_SELECT_ERROR
            ;;
        esac 
    done
    source_shell_end
}


#使用次数增加
time_plus() {
    source_shell
    local time=$(awk -F '=' '/TIME/{print $2}' ./stack/state/STATE.sh)
    time_plus=$(($time+1))
    sed -i "s/TIME=.*/TIME=$time_plus/g" ./stack/state/STATE.sh
    source_shell_end
}

#主函数
language_choose
system_check
SYSTEM_OS_TYPE_INFO "$OS_TYPE"
SYSTEM_KERNEL_VERSION_INFO "$KERNEL_VERSION"
SYSTEM_SESSION_TYPE_INFO "$SESSION_TYPE"
time_plus
script_choice
exit 0