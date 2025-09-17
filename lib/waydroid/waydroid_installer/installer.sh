#!/bin/bash
# =================================================================================================
# 脚本名称：waydroid_installer.sh
# 描述：这个脚本是用来安装Waydroid的       
# 作者：XianYin69
# 参考来源：none   
# 日期：09-17-2025       
# =================================================================================================

source "../../../var/state/STATE.sh"

if [ $WAYDROID_INSTALLED_STAGE -eq 0 ]; then
    sed -i "s/WAYDROID_INSTALLED_STAGE=.*/WAYDROID_INSTALLED_STAGE=1/g" "../../../var/state/STATE.sh"
    ./waydroid_installer_lib/waydroid_installer_part1.sh
elif [ $WAYDROID_INSTALLED_STAGE -eq 1 ]; then
    sed -i "s/WAYDROID_INSTALLED_STAGE=.*/WAYDROID_INSTALLED_STAGE=0/g" "../../../var/state/STATE.sh"
    ./waydroid_installer_lib/waydroid_installer_part2.sh
fi