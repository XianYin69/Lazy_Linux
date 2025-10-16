#===============================================
#Name: ubuntu_update.sh
#Version: 1.0
#Description: Ubuntu系统更新脚本
#Author: EthanYan
#Date: 2025-10-16
#===============================================


main() {
    source ./.index.sh
    source "./$SUP_SYSTEM_UPDATE_HOME_PATH".index.sh
    source "./$SUP_SYSTEM_UPDATE_HOME_PATH$SUP_LIB_HOME_PATH".index.sh
    source "./$SUP_SYSTEM_UPDATE_HOME_PATH$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH_INDEX"
    source "./$SUP_SYSTEM_UPDATE_HOME_PATH$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH$STATE_FOLDER_PATH_INDEX"
    source "./$SUP_SYSTEM_UPDATE_HOME_PATH$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"

    if [[ "$OS_TYPE" == "ubuntu" || "$OS_TYPE" == "debian" ]]
    then
        UBUNTU_UPDATE_SH_OS_TYPE_INFO
        sudo apt update
        sudo apt upgrade -y
        sudo apt autoremove -y
        sudo do-release-upgrade
    else 
        UBUNTU_UPDATE_SH_UNSUPPORTED_OS_TYPE_ERROR
        sleep 5
        exit 1
    fi
}
