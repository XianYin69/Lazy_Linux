#!/bin/bash
# =================================================================================================
# 脚本名称：lazy_linux.sh
# 描述：此为整个工具集的启动器
# 作者：XianYin69
# 参考来源：无
# 日期：9-10-2025 
# =================================================================================================

#变量定义
source ./.index.sh

source "./$VAR_FOLDER_PATH_INDEX"
source "./$VAR_FOLDER_PATH$STATE_FOLDER_PATH_INDEX"
source "./$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"
STATE_PATH="$STATE_SH_FILE_PATH"


OS_TYPE=""
KERNEL_VERSION=""
SESSION_TYPE=""

#系统检测
system_check() {
    source "/etc/os-release"
    OS_TYPE=$ID
    sed -i "s/OS_TYPE=.*/OS_TYPE=$OS_TYPE/g" $STATE_SH_PATH
    KERNEL_VERSION=$(uname -r)
    sed -i "s/KERNEL_VERSION=.*/KERNEL_VERSION=$KERNEL_VERSION/g" $STATE_SH_PATH
    SESSION_TYPE=$XDG_SESSION_TYPE
    sed -i "s/SESSION_TYPE=.*/SESSION_TYPE=$SESSION_TYPE/g" $STATE_SH_PATH
    source "./stack/state/STATE.sh"
    #检测是否是TTY模式
    if [ $SESSION_TYPE = "tty" ]; then
        TTY_MODE="Y"
        sed -i "s/TTY_MODE=.*/TTY_MODE=$TTY_MODE/g" $STATE_SH_PATH
    else
        TTY_MODE="N"
        sed -i "s/TTY_MODE=.*/TTY_MODE=$TTY_MODE/g" $STATE_SH_PATH
    fi
}

#语言选择
select_launcher_language() {
    while :
    do
        echo  "Please choose your language:"
        echo  "1.中文"
        echo  "2.English"
        read -p ":" LAUNCHER_LANGUAGE
        if [ "$LAUNCHER_LANGUAGE" -eq 1 ]; 
        then
            sed -i "s/STATE_LANG=.*/STATE_LANG=ch/g" $STATE_SH_PATH
            break
        elif [ "$LAUNCHER_LANGUAGE" -eq 2 ]; 
        then
            sed -i "s/STATE_LANG=.*/STATE_LANG=en/g" $STATE_SH_PATH
            break
        else
            echo "You must select one!"
        fi
    done
}

#语言初始化
language_choose() {
    if [ "$TTY_MODE" = "N" ]
    then
        if [ "$STATE_LANG" = "ch" ]; then
            source "$LANG_ZH_CN_PATH"
        elif [ "$STATE_LANG" = "en" ]; then
            source "$LANG_EN_US_PATH"
        elif [ "$STATE_LANG" = "initing" ]; then
            select_launcher_language
        else
            source "$LANG_EN_US_PATH"
        fi
    else
        source "$LANG_EN_US_PATH"
    fi
}

#子菜单
initialize_toolkit() {
    local choice
    while :
    do
        LAZY_LINUX_SH_INITIALIZE_TOOLKIT_INFO
        read -p ":" choice
        case $choice in
            1)
                sudo bash "$CHINESEIZATION_PATH"
                break
            ;;
            2)
                sudo bash "$INIT_GIT_PATH"
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
    if [[ $OS_TYPE == "fedora" || $OS_TYPE == "centos" || $OS_TYPE == "rhel" ]]
    then
        while :
        do
            LAZY_LINUX_SH_LINUX_CONFIGURER_INFO_FEDORA
            read -p ":" choice
            cat "$LINUX_CONFIGURER_WARNING_PATH"
            case $choice in
                1)
                    sudo bash "$NVIDIA_DRIVER_INSTALLER_PATH"
                    break
                ;;
                2)
                    sudo bash "$TOUCHPAD_CONFIGURER_PATH"
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
}

backup_and_restore() {
    local choice
    while :
    do
        LAZY_LINUX_SH_BACKUP_AND_RESTORE_INFO
        read -p ":" choice
        case $choice in
            1)
                sudo bash "$BACKUP_PATH"
                break
            ;;
            2)
                sudo bash "$RESTORE_PATH"
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
    while :
    do
        LAZY_LINUX_SH_SOFTWARE_INSTALLER_INFO
        read -p ":" choice
        if [[ $choice =~ ^[Yy] ]]
        then
            sudo bash "$SOFTWARE_INSTALLER_PATH"
            break
        else
            LAZY_LINUX_SH_SOFTWARE_INSTALLER_CHOICE_ERROR
        fi
    done
}

waydroid() {
    local choice
    while :
    do
        LAZY_LINUX_SH_WAYDROID_INFO
        read -p ":" choice
        case $choice in
            1)
                sudo bash "$WAYDROID_INSTALLER_PATH"
                break
            ;;
            2)
                sudo bash "$WAYDROID_APK_INSTALLER_PATH"
                break
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
}


#使用次数增加
time_plus() {
    local time=$(awk -F '=' '/TIME/{print $2}' $STATE_SH_PATH)
    time_plus=$(($time+1))
    sed -i "s/TIME=.*/TIME=$time_plus/g" $STATE_SH_PATH
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