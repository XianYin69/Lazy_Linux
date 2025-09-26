#!/bin/bash
# =================================================================================================
# 脚本名称：waydroid_installer.sh
# 描述：这个脚本是用来安装Waydroid的       
# 作者：XianYin69
# 参考来源：none   
# 日期：09-17-2025       
# =================================================================================================
 
main() {
    source "./.index.sh"
    source "$WAYDROID_INSTALLLER_LIB_FOLDER_PATH_INDEX"
    local WAYDROID_INSTALLER_PART1_SH_PATH="$WAYDROID_INSTALLLER_LIB_FOLDER_PATH$WAYDROID_INSTALLER_PART1_SH_FILE_PATH"
    local WAYDROID_INSTALLER_PART2_SH_PATH="$WAYDROID_INSTALLLER_LIB_FOLDER_PATH$WAYDROID_INSTALLER_PART1_SH_FILE_PATH"

    source "./.index.sh"
    source "$SUP_WAYDROID_INSTALLER_HOME_PATH".index.sh
    source "$SUP_WAYDROID_INSTALLER_HOME$SUP_WAYDROID_HOME_PATH".index.sh
    source "$SUP_WAYDROID_INSTALLER_HOME$SUP_WAYDROID_HOME$SUP_LIB_HOME_PATH".index.sh
    source "$SUP_WAYDROID_INSTALLER_HOME$SUP_WAYDROID_HOME$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH_INDEX"
    source "$SUP_WAYDROID_INSTALLER_HOME$SUP_WAYDROID_HOME$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH$STATE_FOLDER_PATH_INDEX"
    local STATE_SH_PATH="$SUP_WAYDROID_INSTALLER_HOME$SUP_WAYDROID_HOME$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"

    if [ $WAYDROID_INSTALLED_STAGE -eq 0 ]; then
        sed -i "s/WAYDROID_INSTALLED_STAGE=.*/WAYDROID_INSTALLED_STAGE=1/g" $STATE_SH_PATH
        source "$WAYDROID_INSTALLER_PART1_SH_PATH"
        main
    elif [ $WAYDROID_INSTALLED_STAGE -eq 1 ]; then
        sed -i "s/WAYDROID_INSTALLED_STAGE=.*/WAYDROID_INSTALLED_STAGE=0/g" $STATE_SH_PATH
        source "$WAYDROID_INSTALLER_PART1_SH_PATH"
        main
    fi
}