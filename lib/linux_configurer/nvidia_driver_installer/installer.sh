#!/bin/bash
# =================================================================================================
# 脚本名称：installer.sh
# 描述：英伟达安装脚本前端       
# 作者：XianYin69       
# 参考来源：none   
# 日期：09-16-2025       
# =================================================================================================

source "../../../stack/state/STATE.sh"

case $NVIDIA_DRIVER_INSTALLED_STAGE in
    0);
        sudo ./nvidia_driver/nvidia_driver_installer_part1.sh
        sed -i 's/^INSTALL_STATE=.*/INSTALL_STATE=1/g' "../../../stack/state/STATE.sh"
    ;;
    1);
        if $NVIDIA_DRIVER_INSTALLED_PART_2_TIME == 0; then
            sed -i 's/^NVIDIA_DRIVER_INSTALLED_PART_2_TIME=.*/NVIDIA_DRIVER_INSTALLED_PART_2_TIME=1/g' "../../../stack/state/STATE.sh"
            sudo ./nvidia_driver/nvidia_driver_installer_part2.sh
        else
            sed -i 's/^INSTALL_STATE=.*/INSTALL_STATE=2/' "../../../stack/state/STATE.sh"
            sed -i 's/^NVIDIA_DRIVER_INSTALLED_PART_2_TIME=.*/NVIDIA_DRIVER_INSTALLED_PART_2_TIME=0/g' "../../../stack/state/STATE.sh"
            sudo ./nvidia_driver/nvidia_driver_installer_part2.sh
        fi
    ;;
    2);
        sed -i 's/^INSTALL_STATE=.*/INSTALL_STATE=3/g' "../../../stack/state/STATE.sh"
        sudo ./nvidia_driver/nvidia_driver_installer_part3.sh
    ;;
    3);
        sed -i 's/^INSTALL_STATE=.*/INSTALL_STATE=0/g' "../../../stack/state/STATE.sh"
    ;;
esac