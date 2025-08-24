#!/bin/bash

# =================================================================================================
# 脚本名称：   nvidia-driver-installer-part-2.sh
# 描述：       NVIDIA驱动安装脚本 - 第1部分
#              执行系统状态检查和初始化清理操作
# 作者：       XianYin
# 参考来源：   https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/
# 日期：       2025-08-19
# =================================================================================================

RED = "\033[31m"
GREEN = "\033[32m"
YELLOW = "\033[33m"
BLUE = "\033[34m"
RESET = "\033[0m"

#root check
if ["EUID" -ne 0]; then
  echo -e "$RED Please run its with root account $RESET"
  exit 1
fi

#step 1
echo -e "$BLUE ==================== NVIDIA driver installer - part 2 ==================== $RESET"
echo -e "$BLUE Step 1-Install driver $RESET"
read -p "Please enter the driver path:" DRIVER_PATH
if [ ! -f "$DRIVER_PATH" ]; then
  echo -e "$RED Driver file not found at $DRIVER_PATH $RESET"
  exit 1
fi
chmod +x "$DRIVER_PATH"
echo -e "$GREEN Driver file is ready $RESET"
echo -e "$YELLOW !!!Warning: $RESET"
echo -e "$YELLOW 1.if you enable the Secure Boot,please sign your moudle$RESET"
echo -e "$YELLOW 2.after installing, don't reboot your pc and please run the third part installer$RESET"
echo -e "Now,run the driver installer after you press Enter key"
read -p "Press Enter to continue or Ctrl+C to cancel..."
export CC="gcc -std=gnu17" ./"$DRIVER_PATH"
exit 0