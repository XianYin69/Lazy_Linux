#!/bin/bash
# =================================================================================================
# 脚本名称：zh-CN-info.sh
# 描述：汉化
# 作者：XianYin69       
# 参考来源：none   
# 日期：9-11-2025       
# =================================================================================================

#定义颜色
readonly INFO="\e[34m"
readonly SUCCESS="\e[32m"
readonly ERROR="\e[31m"
readonly WARNING="\e[33m"
readonly RESET="\e[0m"

#日志函数
log_info() {
    echo -e "${INFO}[信息]${RESET} $1"
}
log_success() {
    echo -e "${SUCCESS}[成功]${RESET} $1"
}
log_error() {
    echo -e "${ERROR}[错误]${RESET} $1"
}
log_warning() {
    echo -e "${WARNING}[注意]${RESET} $1"
}
log_info_custom() {
    echo -e "${INFO}$1${RESET}"
}
log_success_custom() {
    echo -e "${INFO}$1${RESET}"
}
log_error_custom() {
    echo -e "${INFO}$1${RESET}"
}
log_warning_custom() {
    echo -e "${INFO}$1${RESET}"
}

#lazy_linux.sh提示信息
LAZY_LINUX_SH_INITIALIZE_TOOLKIT_INFO() {
    echo "========================================"
    echo "               初始化工具               "
    echo "========================================"
    echo "1.中文本地化及中文输入法配置工具"
    echo "2.git仓库克隆及开发者配置工具"
    echo "请输入你要使用的工具的选项"
}

LAZY_LINUX_SH_INITIALIZE_TOOLKIT_CHOICE_ERROR() {
    log_error "没这个选项！"
}

LAZY_LINUX_SH_LINUX_CONFIGURER_INFO() {
    echo "========================================"
    echo "               系统修改工具             "
    echo "========================================"
    echo "1.清理旧的内核及其映像"
    echo "2.英伟达驱动程序安装"
    echo "请输入你要使用的工具的选项"
}

LAZY_LINUX_SH_LINUX_CONFIGURER_CHOICE_ERROR() {
    log_error "没这个选项！"    
}