#!/bin/bash

# =================================================================================================
# 脚本名称：   nvidia-driver-installer-part-2.sh
# 描述：       NVIDIA驱动安装脚本 - 第2部分
#              安装.run驱动程序
# 作者：       XianYin_69
# 参考来源：   https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/
# 日期：       2025-08-19
# =================================================================================================

main() {
  #check system runlevel
  if systemctl is-active graphical.target &> /dev/null; then
    NVIDIA_DRIVER_INSTALLER_PART_2_ENVIRONMENT_ERROR
    read -p ":"
    systemctl isolate rescue.target
  else 
    #step 1
    while :
    do
        NVIDIA_DRIVER_INSTALLER_PART_2_INFO
      read -p ":" DRIVER_PATH
      if [ ! -f "$DRIVER_PATH" ]; then
        NVIDIA_DRIVER_INSTALLER_PART_2_PATH_ERROR
      else
        NVIDIA_DRIVER_INSTALLER_PART_2_PATH_SUCCESS
        break
      fi
    done
    chmod +x "$DRIVER_PATH"
    NVIDIA_DRIVER_INSTALLER_PART_2_DRIVER_READY_INFO
    log_warn ":"
    NVIDIA_DRIVER_INSTALLER_PART_2_DRIVER_INSTALLING_WARNING
    sleep 30
    export CC="gcc -std=gnu17" $DRIVER_PATH
  fi
}