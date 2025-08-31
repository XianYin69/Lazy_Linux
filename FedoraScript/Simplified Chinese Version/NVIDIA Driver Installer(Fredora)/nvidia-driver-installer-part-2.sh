#!/bin/bash

# =================================================================================================
# 脚本名称：   nvidia-driver-installer-part-2.sh
# 描述：       NVIDIA驱动安装脚本 - 第1部分
#              执行系统状态检查和初始化清理操作
# 作者：       XianYin
# 参考来源：   https://www.if-not-true-then-false.com/2015/fedora-nvidia-guide/
# 日期：       2025-08-19
# =================================================================================================

# --- 颜色常量定义 ---
readonly COLOR_INFO="\033[34m"      # 蓝色
readonly COLOR_SUCCESS="\033[32m"    # 绿色
readonly COLOR_ERROR="\033[31m"      # 红色
readonly COLOR_WARN="\033[33m"       # 黄色
readonly COLOR_RESET="\033[0m"       # 重置颜色

# --- 日志工具函数 ---
log_info() {
    echo -e "${COLOR_INFO}[Info]${COLOR_RESET} $1"
}

log_success() {
    echo -e "${COLOR_SUCCESS}[Success]${COLOR_RESET} $1"
}

log_error() {
    echo -e "${COLOR_ERROR}[Error]${COLOR_RESET} $1"
}

log_warn() {
    echo -e "${COLOR_WARN}[Warning]${COLOR_RESET} $1"
}

#root check
if [ $EUID -ne 0 ]; then
  log_error "!!!Please run as root!!!"
  exit 1
fi

#check system runlevel
if systemctl is-active graphical.target &> /dev/null; then
  log_info "  !!!现在需要在单用户模式下运行此脚本!!! "
  log_warn "  请保存所有工作并关闭所有应用程序 "
  log_warn " 请进入单用户模式后重新运行此脚本 "
  read -p "按回车键继续，按Ctrl+C取消..."
  systemctl isolate rescue.target
else 
  #step 1
  echo  " ==================== NVIDIA driver installer - part 2 ==================== "
  echo  " Step 1-Install driver "
  read -p "Please enter the driver path:" DRIVER_PATH
  if [ ! -f "$DRIVER_PATH" ]; then
    log_error " Driver file not found at $DRIVER_PATH $RESET"
    exit 1
  fi
  chmod +x "$DRIVER_PATH"
  echo  " Driver file is ready "
  log_warn ":"
  echo  " 1.if you enable the Secure Boot,please sign your moudle"
  echo  " 2.after installing, don't reboot your pc and please run the third part installer"
  echo  "Now,run the driver installer after you press Enter key"
  read -p "Press Enter to continue or Ctrl+C to cancel..."
  export CC="gcc -std=gnu17" 
  $DRIVER_PATH
  exit 0
fi