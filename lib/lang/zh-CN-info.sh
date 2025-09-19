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

LAZY_LINUX_SH_BACKUP_AND_RESTORE_CHOICE_INFO() {
    echo "========================================"
    echo "              备份与恢复工具            "
    echo "========================================"
    echo "1.备份文件"
    echo "2.恢复文件"
    echo "请输入你要使用的工具的选项"
}

LAZY_LINUX_SH_BACKUP_AND_RESTORE_CHOICE_ERROR() {
    log_error "没这个选项！"    
}

LAZY_LINUX_SH_SOFTWARE_INSTALLER_INFO() {
    echo "========================================"
    echo "               软件安装工具             "
    echo "========================================"
    echo "1.安装软件"
    echo "2.卸载软件"
    echo "请输入你要使用的工具的选项"
}

LAZY_LINUX_SH_SOFTWARE_INSTALLER_CHOICE_ERROR() {
    log_error "没这个选项！"    
}

LAZY_LINUX_SH_WAYDROID_INFO() {
    echo "========================================"
    echo "               WayDroid工具             "
    echo "========================================"
    echo "1.WayDroid安装及配置"
    echo "2.APK安装"
    echo "请输入你要使用的工具的选项"
}

LAZY_LINUX_SH_WAYDROID_ERROR() {
    echo "没这个选项！"
}

LAZY_LINUX_SH_SCRIPTS_SELECT_INFO() {
    echo "========================================"
    echo "               脚本选择                 "
    echo "========================================"
    echo "1.初始化工具"
    echo "2.软件安装"
    echo "3.系统配置"
    echo "4.WayDroid"
    echo "5.备份与恢复"
    echo "请输入你要使用的脚本的选项"
}

LAZY_LINUX_SH_SCRIPTS_SELECT_ERROR() {
    echo "没这个选项！"
}

SYSTEM_OS_TYPE_INFO() {
    log_info_custom "你的系统为：$1"
}

SYSTEM_KERNEL_VERSION_INFO() {
    log_info_custom "你的内核版本为：$1"
}

SYSTEM_SESSION_TYPE_INFO() {
    log_info_custom "你的桌面服务器是：$1"
}
#结束

#backup.sh提示信息
BACKUP_INFO() {
    echo "========================================"
    echo "               备份工具                 "
    echo "========================================"
}

BACKUP_PATH_INFO() {
    echo "请提供要备份的文件或目录的路径"
}

BACKUP_STORE_PATH_INFO() {
    echo "请提供备份文件存储的路径"
}

BACKUP_SUCCESS_INFO() {
    log_success "备份成功！"
}

BACKUP_FAIL_INFO() {
    log_error "备份失败！"
}

#restore.sh提示信息
RESTORE_INFO() {
    echo "========================================"
    echo "               恢复工具                 "
    echo "========================================"
}

RESTORE_PATH_INFO() {
    echo "请提供要恢复的文件或目录的路径"
}

RESTORE_SUCCESS_INFO() {
    log_success "恢复成功！"
}

RESTORE_FAIL_INFO() {
    log_error "恢复失败！"
}

#结束

#first_run.sh提示信息
FIRST_RUN_SH_ROOT_ERROR() {
    log_error "请以root用户运行此脚本！"
}
#结束


#chinesization.sh提示信息
##输入法选择
CHINESIZATION_INPUT_METHOD_INFO() {
    echo "========================================"
    echo "               输入法选择               "
    echo "========================================"
    echo "1)Fcitx 5"
    echo "2)ibus"
    echo "请选择输入法（1或2）"
}

CHINESIZATION_INPUT_METHOD_FCITX_5_SELECT_INFO() {
    echo "你选择的输入法是：Fcitx 5"
}

CHINESIZATION_INPUT_METHOD_IBUS_SELECT_INFO() {
    echo "你选择的输入法是：ibus"
}

CHINESIZATION_INPUT_METHOD_CHOICE_ERROR() {
    log_error "无效选择。请选择1或2。"
}

##显示服务器选择
CHINESIZATION_ENVIRONMENT_INIT_INFO() {
    echo "========================================"
    echo "               显示服务器选择           "
    echo "========================================"
    echo "1)X11"
    echo "2)Wayland"
    echo "请选择显示服务器（1或2）"
}

CHINESIZATION_ADD_PROFILE_FCITX_5_INFO() {
    echo "正在添加Fcitx 5配置文件..."
}

CHINESIZATION_ADD_PROFILE_FCITX_5_SUCCESS() {
    log_success " Fcitx 5配置文件添加成功。"
}

CHINESIZATION_ADD_PROFILE_IBUS_INFO() {
    echo "正在添加ibus配置文件..."
}

CHINESIZATION_ADD_PROFILE_IBUS_SUCCESS() {
    log_success " ibus配置文件添加成功。"
}

#桌面环境选择
CHINESIZATION_DESKTOP_ENVIRONMENT_INFO() {
    echo "========================================"
    echo "               桌面环境选择             "
    echo "========================================"
    echo "1)KDE"
    echo "2)GNOME"
    echo "请选择桌面环境（1或2）"
}

CHINESIZATION_DESKTOP_ENVIRONMENT_ERROR() {
    log_error "无效选择。请选择1或2。"
}

CHINESIZATION_ENVIRONMENT_INIT_ERROR() {
    log_error "无效选项。请选择1或2。"
}

#修改环境变量选择
CHINESIZATION_INPUT_METHOD_CONFIG_INFO() {
    echo "是否重新配置输入法环境变量？（Y/n）"
}

CHINESIZATION_INPUT_METHOD_CONFIG_ERROR() {
    log_warn "如果你需要配置输入法相关变量，请重新运行此脚本。"
}

##输入法安装程序
###ubuntu及其衍生版
CHINESIZATION_INSTALL_UBUNTU_INFO() {
    echo "正在为Ubuntu及其衍生版安装输入法..."
}

CHINESIZATION_INSTALL_UBUNTU_SUCCESS() {
    log_success "输入法安装成功。"
}

###Fedora及其衍生版
CHINESIZATION_INSTALL_FEDORA_INFO() {
    echo "正在为Fedora及其衍生版安装输入法..."
}

CHINESIZATION_INSTALL_FEDORA_SUCCESS() {
    log_success "输入法安装成功。"
}

###arch及其衍生版
CHINESIZATION_INSTALL_ARCH_INFO() {
    echo "正在为Arch及其衍生版安装输入法..."
}

CHINESIZATION_INSTALL_ARCH_SUCCESS() {
    log_success "输入法安装成功。"
}

##修改locale
CHINESIZATION_MODIFY_LOCALE_INFO() {
    echo "正在将系统语言修改为zh_CN.UTF-8..."
}

CHINESIZATION_MODIFY_LOCALE_ERROR() {
    log_error "找不到语言配置文件。"
    log_error "正在退出..."
}

CHINESIZATION_REBUILD_LOCALE_ERROR() {
    log_error "找不到语言生成文件。"
    log_error "如果需要，请确保手动生成zh_CN.UTF-8。"
    log_error "正在退出..."
}

CHINESIZATION_MODIFY_LOCALE_ERROR() {
    log_success "系统语言已修改为zh_CN.UTF-8。"
}

##主函数
###系统类型
CHINESIZATION_OS_TYPE_ERROR() {
    log_error "不支持的系统。"
    log_error "正在退出..."
}

###重启系统
CHINESIZATION_REBOOT_INFO() {
    echo "是否现在重启系统以应用更改？（Y/n）"
}

CHINESIZATION_REBOOT_CANCEL_INFO() {
    log_info "请记得稍后重启系统以应用更改。"
    log_info "正在退出..."
}

#结束

#init_git.sh提示信息
##git 安装
INIT_GIT_GIT_INSTALL_ERROR() {
    log_error "不支持的系统。"
    log_error "正在退出..."
}

INIT_GIT_GIT_ERROR() {
    log_error "未检测到git。正在安装git..."
}

##欢迎信息
INIT_GIT_WELCOME_INFO() {
    echo "========================================="
    echo "        Git 配置与仓库克隆工具        "
    echo "========================================="
    echo
}

##用户信息输入
INIT_GIT_INIT_INFO() {
    echo "此脚本将帮助您配置Git并克隆仓库。"
}

INIT_GIT_INIT_USERNAME_INFO() {
    echo "请输入您的GitHub用户名"
}

INIT_GIT_USERNAME_ERROR() {
    log_error "用户名不能为空。请重新输入。"
}

INIT_GIT_INIT_EMAIL_INFO() {
    echo "请输入您的GitHub邮箱"
}

INIT_GIT_EMAIL_ERROR() {
    log_error "邮箱不能为空。请重新输入。"
}

INIT_GIT_URL_INFO() {
    echo "请输入要克隆的Git仓库URL"
}

INIT_GIT_URL_ERROR() {
    log_error "URL不能为空。请重新输入。"
}

##git 配置
INIT_GIT_CONFIG_INFO() {
    log_info "正在配置Git凭据..."
}

INIT_GIT_CONFIG_SUCCESS() {
    log_success "Git用户名和邮箱已全局设置完成。"
}

##克隆仓库
INIT_GIT_CLONE_INFO() {
    log_info "正在克隆仓库..."
}

INIT_GIT_CLONE_SUCCESS() {
    log_success "仓库克隆成功。"
}

INIT_GIT_CLONE_ERROR() {
    log_error "仓库克隆失败。请检查URL和您的权限。"
}

#结束

#super_clean_old_kernel.sh提示信息
##内核检查
SUPER_CLEAN_OLD_KERNEL_VERSION_DIFF_INFO() {
    echo "========================================"
    log_error_custom "           内核版本不一致               "
    echo "========================================"
}

SUPER_CLEAN_OLD_KERNEL_VERSION_INFO() {
    log_info "当前运行的内核版本: $1"
}

SUPER_CLEAN_OLD_KERNEL_LASTED_VERSION_INFO() {
    log_warn "最新安装的内核版本: $1"
}

SUPER_CLEAN_OLD_KERNEL_PROCESS_INITRAMFS_INFO() {
    log_info "将为最新内核生成initramfs并更新引导配置"
}

SUPER_CLEAN_OLD_KERNEL_LASTED_VERSION_INFO() {
    echo "========================================"
    log_success_custom "内核版本一致：$1"
    echo "========================================"
}

##删除旧的启动文件
SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_BOOT_INFO() {
    log_info "正在清理旧的启动文件..."
}

##删除旧的initramfs文件
SUPER_CLEAN_OLD_KERNEL_DELETE_INITRAMFS_INFO() {
    log_info "正在清理旧的initramfs文件..."
}

SUPER_CLEAN_OLD_KERNEL_DELETE_INITRAMFS_SUCCESS() {
    log_success "旧的initramfs文件已清理完成"
}

##重新生成initramfs
SUPER_CLEAN_OLD_KERNEL_REGENERATE_INITRAMFS_INFO() {
    log_info "正在重新生成initramfs..."
}

SUPER_CLEAN_OLD_KERNEL_REGENERATING_INITRAMFS_INFO() {
    log_info "为最新内核 $lasted_kernel 生成initramfs..."
}

SUPER_CLEAN_OLD_KERNEL_REGENERATE_INITRAMFS_SUCCESS() {
    log_success "initramfs生成完成"
}

SUPER_CLEAN_OLD_KERNEL_REGENERATE_INITRAMFS_ERROR() {
    log_error "initramfs生成失败"
}

##更新GRUB
SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_GRUB_INFO() {
    log_info "正在更新GRUB配置..."
}

SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_GRUB_SUCCESS() {
    log_success "GRUB配置更新完成"
}

SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_GRUB_ERROR() {
    log_error "GRUB配置更新失败"
}