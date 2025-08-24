#!/bin/bash
#
# =================================================================================================
# 脚本名称：   Begin.sh
# 描述：       NVIDIA驱动安装启动脚本
# 参考来源：   https://www.if-not-true-then-false.com
# 作者：       XianYin
# 日期：       2025-08-19
# =================================================================================================

#color
RED = "\033[31m"
YELLOW = "\033[33m"
GREEN = "\033[32m"
BLUE = "\033[34m"
RESET = "\033[0m"

#root check
if ["EUID" -ne 0]; then
  echo -e "${RED}请以root用户身份运行此脚本${RESET}"
  exit 1
fi

echo -e "$RED !!! 此脚本只限于版本号大于570.181（2025.Aug.05）的英伟达驱动安装包(.run)使用 !!! $RESET"
read -p "按回车键继续，按Ctrl+C取消..."
echo -e "$YELLOW 1. 开始安装前的准备工作... $RESET"
FILE = (
    "./nvidia-deiver-installer-part-1.sh"
    "./nvidia-deiver-installer-part-2.sh"
    "./nvidia-deiver-installer-part-3.sh"
)
sudo chmod +x ${FILE[*]}
echo -e "$GREEN 准备工作完成！ $RESET"
echo -e "$GREEN 请运行安装程序的第二部分 $RESET"
read -p "按回车键继续，按Ctrl+C取消..."
exit 0