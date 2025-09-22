#!/bin/bash
# =================================================================================================
# 脚本名称：   appInstaller.sh
# 描述：       安装安卓应用
# 作者：       XianYin_69
# 参考来源：   none
# 日期：       8-31-2025
# =================================================================================================

source "../../../var/state/STATE.sh"
source "../../../var/index/filepath.sh"
 

#check waydroid status
if [ ! -d "/var/lib/waydroid" ]; then
    APK_INSTALLER_WAYDROID_NOT_INSTALLED_ERROR
    sleep 3
    exit 1
else
    APK_INSTALLER_WAYDROID_INSTALLED_INFO
    systemctl start waydroid-container
    APK_INSTALLER_FILE_PATH_INFO
    read -p ":" APK_PATH
    while :
    do
        if [ ! -f "$APK_PATH" ]; then
            APK_INSTALLER_FILE_PATH_ERROR
        else
            waydroid app install "$APK_PATH"
            if [ $? -eq 0 ]; then
                APK_INSTALLER_APP_INSTALL_SUCCESS
                break
            else
                APK_INSTALLER_APP_INSTALL_ERROR
            fi
        fi
    done
    exit 0
fi