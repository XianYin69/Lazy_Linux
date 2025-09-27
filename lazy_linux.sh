#!/bin/bash
# =================================================================================================
# 脚本名称：lazy_linux.sh
# 描述：此为整个工具集的启动器
# 作者：XianYin69
# 参考来源：无
# 日期：9-10-2025 
# =================================================================================================


#系统检测
system_check() {
    #变量定义
    source ./.index.sh
    source "./$VAR_FOLDER_PATH_INDEX"
    source "./$VAR_FOLDER_PATH$STATE_FOLDER_PATH_INDEX"
    source "./$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"
    local STATE_SH_PATH="./$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"

    OS_TYPE=""
    KERNEL_VERSION=""
    SESSION_TYPE=""

    source "/etc/os-release"
    case $ID in
        debian|ubuntu|kali)
            OS_TYPE="debian"
        ;;
        fedora|rhel|centos)
            OS_TYPE="fedora"
        ;;
        arch)
            OS_TYPE="arch"
        ;;
        *)
            OS_TYPE="Linux"
        ;;
    esac

    sed -i "s/OS_TYPE=.*/OS_TYPE=$OS_TYPE/g" $STATE_SH_PATH
    KERNEL_VERSION=$(uname -r)
    sed -i "s/KERNEL_VERSION=.*/KERNEL_VERSION=$KERNEL_VERSION/g" $STATE_SH_PATH
    SESSION_TYPE=${XDG_SESSION_TYPE}
    sed -i "s/SESSION_TYPE=.*/SESSION_TYPE=${XDG_SESSION_TYPE}/g" $STATE_SH_PATH
        # 获取会话类型
    if [[ -z "${XDG_SESSION_TYPE}" ]]; then
        SESSION_TYPE="tty"
    else
        SESSION_TYPE="${XDG_SESSION_TYPE}"
    fi
    sed -i "s/SESSION_TYPE=.*/SESSION_TYPE=${SESSION_TYPE}/g" $STATE_SH_PATH

    # 根据会话类型赋值 TTY_MODE
    if [[ "${SESSION_TYPE}" == "tty" ]]; then
        TTY_MODE="Y"
    else
        TTY_MODE="N"
    fi
    sed -i "s/TTY_MODE=.*/TTY_MODE=$TTY_MODE/g" $STATE_SH_PATH

    # 重新引用 STATE.sh，确保变量同步
    source "$STATE_SH_PATH"
}

#语言选择
language_selector() {
    source ./.index.sh
    source "./$LIB_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$LANG_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$LANG_FOLDER_PATH$SELECTOR_SH_FILE_PATH"
    cd "./$LIB_FOLDER_PATH$LANG_FOLDER_PATH"
    language_choose
    cd "../../"
}

langguage_init() {
    source "./.index.sh"
    source "./$VAR_FOLDER_PATH_INDEX"
    source "./$VAR_FOLDER_PATH$STATE_FOLDER_PATH_INDEX"
    source "./$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"
    local STATE_SH_PATH="./$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"

    source "./.index.sh"
    source "./$LIB_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$LANG_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$LANG_FOLDER_PATH$LANG_LIB_FOLDER_PATH_INDEX"
    local EN_US_SH_PATH="./$LIB_FOLDER_PATH$LANG_FOLDER_PATH$LANG_LIB_FOLDER_PATH$EN_US_SH_FILE_PATH"
    local ZH_CN_SH_PATH="./$LIB_FOLDER_PATH$LANG_FOLDER_PATH$LANG_LIB_FOLDER_PATH$ZH_CN_SH_FILE_PATH"

    source $STATE_SH_PATH
    if [[ "$TTY_MODE" == "N" ]]
    then
        if [[ "$STATE_LANG" == "ch" ]]
        then
            source "$ZH_CN_SH_PATH"
        else
            source "$EN_US_SH_PATH"
        fi
    else
        source "$EN_US_SH_PATH"
    fi

}

#子菜单
initialize_toolkit() {
    source "./.index.sh"
    source "./$LIB_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$INITIALIZE_TOOLKIT_FOLDER_PATH_INDEX"

    local CHINESIZATION_PATH="./$LIB_FOLDER_PATH$INITIALIZE_TOOLKIT_FOLDER_PATH$CHINESIZATION_SH_FILE_PATH"
    local INIT_GIT_PATH="./$LIB_FOLDER_PATH$INITIALIZE_TOOLKIT_FOLDER_PATH$INIT_GIT_SH_FILE_PATH"
    
    local choice

    while :
    do
        LAZY_LINUX_SH_INITIALIZE_TOOLKIT_INFO
        read -p ":" choice
        case $choice in
            1)
                source "$CHINESIZATION_PATH"
                main
                break
            ;;
            2)
                source "$INIT_GIT_PATH"
                main
                break
            ;;
            *)
                LAZY_LINUX_SH_INITIALIZE_TOOLKIT_CHOICE_ERROR
            ;;
        esac
    done
}

linux_configurer() {

    source "./.index.sh"
    source "./$SRC_FOLDER_PATH_INDEX"
    source "./$SRC_FOLDER_PATH$LINUX_CONFIGURER_WARNING_FOLDER_PATH_INDEX"
    local LINUX_CONFIGURER_WARNING_PATH="./$SRC_FOLDER_PATH$LINUX_CONFIGURER_WARNING_FOLDER_PATH$NOTICE_TXT_FILE_PATH"
    
    source "./.index.sh"
    source "./$LIB_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$LINUX_CONFIGURER_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$LINUX_CONFIGURER_FOLDER_PATH$KERNEL_CLEANER_FOLDER_PATH_INDEX"
    local CLEAN_BOOT_PATH="./$LIB_FOLDER_PATH$LINUX_CONFIGURER_FOLDER_PATH$KERNEL_CLEANER_FOLDER_PATH$SUPER_CLEAN_OLD_KERNEL_SH_FILE_PATH"

    source "./.index.sh"
    source "./$LIB_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$LINUX_CONFIGURER_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$LINUX_CONFIGURER_FOLDER_PATH$NVIDIA_DRIVER_INSTALLER_FOLDER_PATH_INDEX"
    local NVIDIA_DRIVER_INSTALLER_FILE="./$LIB_FOLDER_PATH$LINUX_CONFIGURER_FOLDER_PATH$NVIDIA_DRIVER_INSTALLER_FOLDER_PATH$INSTALLER_SH_FILE_PATH"
    local NVIDIA_DRIVER_INSTALLER_PATH="./$LIB_FOLDER_PATH$LINUX_CONFIGURER_FOLDER_PATH$NVIDIA_DRIVER_INSTALLER_FOLDER_PATH"

    local choice
    if [[ $OS_TYPE == "fedora" || $OS_TYPE == "centos" || $OS_TYPE == "rhel" ]]
    then
        while :
        do
            cat "$LINUX_CONFIGURER_WARNING_PATH"
            LAZY_LINUX_SH_LINUX_CONFIGURER_INFO
            read -p ":" choice
            case $choice in
                1)
                    source "$CLEAN_BOOT_PATH"
                    main
                    break
                ;;
                2)
                    source "$NVIDIA_DRIVER_INSTALLER_FILE"
                    cd "$NVIDIA_DRIVER_INSTALLER_PATH"
                    main
                    cd "../../.."
                    break
                ;;
                *)
                    LAZY_LINUX_SH_LINUX_CONFIGURER_CHOICE_ERROR
                ;;
            esac
        done
    else
        LAZY_LINUX_SH_FEDORA_ONLY_ERROR
        exit 1
    fi
}

backup_and_restore() {
    source "./.index.sh"
    source "./$LIB_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$BACKUP_AND_RESTORE_FOLDER_PATH_INDEX"
    local BACKUP_PATH="./$LIB_FOLDER_PATH$BACKUP_AND_RESTORE_FOLDER_PATH$BACKUP_SH_FILE_PATH"
    local RESTORE_PATH="./$LIB_FOLDER_PATH$BACKUP_AND_RESTORE_FOLDER_PATH$RESTORE_SH_FILE_PATH"

    local choice
    while :
    do
        LAZY_LINUX_SH_BACKUP_AND_RESTORE_CHOICE_INFO
        read -p ":" choice
        case $choice in
            1)
                source "$BACKUP_PATH"
                main
                break
            ;;
            2)
                source "$RESTORE_PATH"
                main
                break
            ;;
            *)
                LAZY_LINUX_SH_BACKUP_AND_RESTORE_CHOICE_ERROR
            ;;
        esac
    done
}

software_installer() {
    source "./.index.sh"
    source "./$LIB_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$SOFTWARE_INSTALLER_FOLDER_PATH_INDEX"
    local SOFTWARE_INSTALLER_PATH="./$LIB_FOLDER_PATH$SOFTWARE_INSTALLER_FOLDER_PATH$SOFTWARE_INSTALLER_SH_FILE_PATH"

    while :
    do
        LAZY_LINUX_SH_SOFTWARE_INSTALLER_INFO
        read -p ":" choice
        if [[ "$choice" == 1 ]]
        then
            source "$SOFTWARE_INSTALLER_PATH"
            main
            break
        else
            LAZY_LINUX_SH_SOFTWARE_INSTALLER_CHOICE_ERROR
        fi
    done
}

waydroid() {
    source "./.index.sh"
    source "./$LIB_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$WAYDROID_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$WAYDROID_FOLDER_PATH$WAYDROID_INSTALLER_FOLDER_PATH_INDEX"
    local WAYDROID_INSTALLER_FILE="./$LIB_FOLDER_PATH$WAYDROID_FOLDER_PATH$WAYDROID_INSTALLER_FOLDER_PATH$INSTALLER_SH_FILE_PATH"
    local WAYDROID_INSTALLER_PATH="./$LIB_FOLDER_PATH$WAYDROID_FOLDER_PATH$WAYDROID_INSTALLER_FOLDER_PATH"
    
    source "./.index.sh"
    source "./$LIB_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$WAYDROID_FOLDER_PATH_INDEX"
    source "./$LIB_FOLDER_PATH$WAYDROID_FOLDER_PATH$WAYDROID_CONFIGURER_FOLDER_PATH_INDEX"
    local WAYDROID_APK_INSTALLER_FILE="./$LIB_FOLDER_PATH$WAYDROID_FOLDER_PATH$WAYDROID_CONFIGURER_FOLDER_PATH$APK_INSTALLER_SH_FILE_PATH"
    local WAYDROID_APK_INSTALLER_PATH="./$LIB_FOLDER_PATH$WAYDROID_FOLDER_PATH$WAYDROID_CONFIGURER_FOLDER_PATH"

    local choice
    while :
    do
        LAZY_LINUX_SH_WAYDROID_INFO
        read -p ":" choice
        case $choice in
            1)
                source "$WAYDROID_INSTALLER_FILE"
                cd "$WAYDROID_INSTALLER_PATH"
                main
                cd "../../.."
                break
            ;;
            2)
                source "$WAYDROID_APK_INSTALLER_FILE"
                cd "$WAYDROID_APK_INSTALLER_PATH"
                main
                cd "../../.."
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
    source ./.index.sh
    source "./$VAR_FOLDER_PATH_INDEX"
    source "./$VAR_FOLDER_PATH$STATE_FOLDER_PATH_INDEX"
    source "./$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"
    local STATE_SH_PATH="./$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"
    time_plus=$(( TIME + 1 ))
    sed -i "s/TIME=.*/TIME=$time_plus/g" $STATE_SH_PATH
}

#主函数
time_plus
system_check
language_selector
langguage_init
SYSTEM_OS_TYPE_INFO "$ID"
SYSTEM_KERNEL_VERSION_INFO "$KERNEL_VERSION"
SYSTEM_SESSION_TYPE_INFO "$SESSION_TYPE"
script_choice
exit 0