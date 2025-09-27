#!/bin/bash
# =================================================================================================
# 脚本名称：zh-CN-info.sh
# 描述：汉化
# 作者：XianYin69       
# 参考来源：none   
# 日期：9-11-2025       
# =================================================================================================

#定义颜色
INFO="\e[34m"
SUCCESS="\e[32m"
ERROR="\e[31m"
WARNING="\e[33m"
RESET="\e[0m"

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
    echo "6.语言选择"
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

LAZY_LINUX_SH_FEDORA_ONLY_ERROR() {
    log_error "仅支持Fedora系发行版！！！(Only Fedora-based distributions are supported!!!)"
}

LAZY_LINUX_SH_LANGUAGE_OPTION_INFO() {
    echo "=========================="
    echo "         语言选择         "
    echo "=========================="
    echo "1.中文"
    echo "2.English"
    echo "请输入选项"
}

LAZY_LINUX_SH_LANGUAGE_OPTION_WARN() {
    log_warn "需要重新运行此脚本以应用修改！！！"
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

BACKUP_STORE_INFO() {
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
    log_warning "如果你需要配置输入法相关变量，请重新运行此脚本。"
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

INIT_GIT_PATH_INFO() {
    echo "请输入克隆到本地的路径"
}

INIT_GIT_PATH_ERROR() {
    log_error "路径不能为空，请重新输入。"
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
    log_warning "最新安装的内核版本: $1"
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

##主函数
SUPER_CLEAN_OLD_KERNEL_INFO() {
    echo "========================================"
    echo "         超级清理旧内核工具            "
    echo "========================================"
}

SUPER_CLEAN_OLD_KERNEL_IF_INSTALLED_NVIDIA_WARNING() {
    log_warning "如果你使用nvidia显卡，则重启后需要重新安装nvidia驱动"
}

SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_GRUB_INFO() {
    log_info "由于存在新内核，将更新引导配置..."
}

SUPER_CLEAN_OLD_KERNEL_END_INFO() {
    log_success "所有操作已完成！"
    log_success "建议重启系统以应用更改。"
    log_success "如果系统无法启动，可以通过GRUB菜单选择备份的内核版本启动。"
}

#结束

#nvidia_driver_installer_part1.sh提示信息
NVIDIA_DRIVER_INSTALLER_PART_1_INFO() {
    echo "========================================"
    echo "       NVIDIA驱动安装脚本 - 第1部分    "
    echo "========================================"
}

NVIDIA_DRIVER_INSTALLER_PART_1_STEP_1_INFO() {
    echo " 步骤 1-安装必要软件包 "
}

NVIDIA_DRIVER_INSTALLER_PART_1_STEP_1_SUCCESS() {
    log_success " 必要软件包安装完成 "
}

NVIDIA_DRIVER_INSTALLER_PART_1_STEP_2_INFO() {
    echo " 步骤 2-禁用nouveau "
}

NVIDIA_DRIVER_INSTALLER_PART_1_STEP_2_SUCCESS() {
    log_success " nouveau禁用完成 "
}

NVIDIA_DRIVER_INSTALLER_PART_1_END_INFO() {
    log_info " 第1部分完成！ "
    log_warning " 重启后请运行nvidia-driver-installer-part-2.sh继续安装NVIDIA驱动"
}

NVIDIA_DRIVER_INSTALLER_PART_1_REBOOT_WARNING() {
    log_warning " 系统将于10秒后重启,你可以按Ctrl+C取消重启"
}

NVIDIA_DRIVER_INSTALLER_PART_1_REBOOTING_INFO() {
    log_info " 系统正在重启..."
}
#结束

#nvidia_driver_installer_part2.sh提示信息
NVIDIA_DRIVER_INSTALLER_PART_2_ENVIRONMENT_ERROR() {
    log_error " !!!现在需要在单用户模式下运行此脚本!!! "
    log_warning " 请保存所有工作并关闭所有应用程序 "
    log_warning " 按下Enter进入单用户模式，或按Ctrl+C取消 "
}

NVIDIA_DRIVER_INSTALLER_PART_2_INFO() {
    echo "========================================"
    echo "       NVIDIA驱动安装脚本 - 第2部分    "
    echo "========================================"
    echo " 步骤 1-安装驱动 "
    log_info " 请输入驱动程序的完整路径 "
}

NVIDIA_DRIVER_INSTALLER_PART_2_PATH_ERROR() {
    log_error " 驱动文件未找到 "
    log_error " 请检查路径是否正确 "
}

NVIDIA_DRIVER_INSTALLER_PART_2_PATH_SUCCESS() {
    log_success " 驱动文件找到 "
}

NVIDIA_DRIVER_INSTALLER_PART_2_DRIVER_READY_INFO() {
    log_info " 驱动程序已准备好安装 "
}

NVIDIA_DRIVER_INSTALLER_PART_2_DRIVER_INSTALLING_WARNING() {
    log_warning " 驱动安装程序即将在30秒后运行 "
    log_warning " 请确保已保存所有工作 "
    log_warning " 安装程序里的选项全选“yes”"
    log_warning " 按下Enter继续，或按Ctrl+C取消 "
}

NVIDIA_DRIVER_INSTALLER_PART_3_STEP_1_INFO() {
    echo "========================================"
    echo "       NVIDIA驱动安装脚本 - 第3部分    "
    echo "========================================"
    echo " 步骤 1-启动守护进程 "
}   

NVIDIA_DRIVER_INSTALLER_PART_3_STEP_1_SUCCESS() {
    log_success " 守护进程已启用 "
}

NVIDIA_DRIVER_INSTALLER_PART_3_STEP_2_INFO() {
    echo " 步骤 2-签署内核模块 "
}

NVIDIA_DRIVER_INSTALLER_PART_3_STEP_2_SECURE_BOOT_ENABLED_INFO() {
    log_info " 检测到安全启动已启用 "
    log_info " 正在签署内核模块 "
    log_warning " 你可能需要输入MOK密码 "
}

NVIDIA_DRIVER_INSTALLER_PART_3_STEP_2_SUCCESS() {
    log_success " 内核模块签署完成 "
}

NVIDIA_DRIVER_INSTALLER_PART_3_END_INFO() {
    log_success " 安装完成，将在10秒后重启，你可以按Ctrl+C取消重启 "
}
#结束

#software_installer.sh提示信息

##读取用户软件列表
SOFTWARE_INSTALLER_READING_SOFTWARE_LIST_INFO() {
    log_info "请输入软件列表文件的路径"
}

##读取文件
SOFTWSARE_INSTALLER_FILE_READING_ERROR() {
    log_error "软件列表文件读取失败"
    log_error "请检查文件格式是否正确"
    log_error "将在10秒后重新编辑文件"
}

SOFTWARE_INSTALLER_FILE_READING_SUCCESS() {
    log_success "软件列表文件读取成功"
}

##fedora安装函数
SOFTWARE_INSTALELR_FEDORA_INSTALLER_INFO() {
    log_info "开始安装软件..."
}

SOFTWARE_INSTALLER_FEDORA_DNF_INFO() {
    log_info "正在安装 $1 ..."
}

SOFTWARE_INSTALLER_FEDORA_DNF_SUCCESS() {
    log_success "$1 安装成功。"
}

SOFTWARE_INSTALLER_FEDORA_DNF_ERROR() {
    log_error "$1 安装失败。"
}

SOFTWARE_INSTALLER_FEDORA_DNF_SKIP_WARN() {
    log_warning "$1 已经安装，跳过。"
}

##debian安装函数
SOFTWARE_INSTALLER_DEBIAN_INFO() {
    log_info "开始安装软件..."
}

SOFTWARE_INSTALLER_DEBIAN_APT_INFO() {
    log_info "正在安装 $1 ..."
}

SOFTWARE_INSTALLER_DEBIAN_APT_SUCCESS() {
    log_success "$1 安装成功。"
}

SOFTWARE_INSTALLER_DEBIAN_APT_ERROR() {
    log_error "$1 安装失败。"
}

SOFTWARE_INSTALLER_DEBIAN_APT_SKIP_WARN() {
    log_warning "$1 已经安装，跳过。"
}

##arch安装函数
SOFTWARE_INSTALLER_ARCH_INSTALLER_INFO() {
    log_info "开始安装软件..."
}

SOFTWARE_INSTALLER_ARCH_PACMAN_INFO() {
    log_info "正在安装 $1 ..."
}

SOFTWARE_INSTALLER_ARCH_PACMAN_SUCCESS() {
    log_success "$1 安装成功。"
}

SOFTWARE_INSTALLER_ARCH_PACMAN_ERROR() {
    log_error "$1 安装失败。"
}

SOFTWARE_INSTALLER_ARCH_PACMAN_SKIP_WARN() {
    log_warning "$1 已经安装，跳过。"
}

##snap检测及安装
SOFTWARE_INSTALLER_SNAP_NOT_INSTALLED_INFO() {
    log_warning "Snap 未安装，正在安装 Snap..."
}

SOFTWARE_INSTALLER_SNAP_INSTALLED_INFO() {
    log_info "已经安装 Snap，跳过。"
}

SOFTWARE_INSTALLER_SNAP_INSTALL_SUCCESS() {
    log_success "Snap 安装成功。"
}

SOFTWARE_INSTALLER_SNAP_INSTALLER_INFO() {
    log_info "正在安装 $1 ..."
}

SOFTWARE_INSTALLER_SNAP_INSTALL_SUCCESS() {
    log_success "$1 通过 Snap 安装成功。"
}

SOFTWARE_INSTALLER_SNAP_INSTALL_ERROR() {
    log_error "$1 通过 Snap 安装失败。"
}

SOFTWARE_INSTALLER_SNAP_INSTALL_SKIP_WARN() {
    log_warning "$1 已经通过 Snap 安装，跳过。"
}

##flatpak检测及安装
SOFTWARE_INSTALLER_FLATPAK_NOT_INSTALLED_INFO() {
    log_warning "Flatpak 未安装，正在安装 Flatpak..."
}

SOFTWARE_INSTALLER_FLATAPAK_INSTALL_SKIP_WARN() {
    log_info "已经安装 Flatpak，跳过。"
}

SOFTWARE_INSTALLER_FLATPAK_INSTALL_SUCCESS() {
    log_success "$1 通过 Flatpak 安装成功。"
}

SOFTWARE_INSTALLER_FLATPAK_INSTALL_ERROR() {
    log_error "$1 通过 Flatpak 安装失败。"
}

SOFTWARE_INSTALLER_FLATPAK_INSTALLER_SKIP_WARN() {
    log_warning "$1 已经通过 Flatpak 安装，跳过。"
}

#结束

#apk_installer.sh提示信息
APK_INSTALLER_WAYDROID_NOT_INSTALLED_ERROR() {
    log_error "Waydroid未安装或未初始化，请先安装并初始化Waydroid"
}

APK_INSTALLER_WAYDROID_INSTALLED_INFO() {
    log_success "检测到Waydroid已安装"
}

APK_INSTALLER_FILE_PATH_INFO() {
    echo "请输入要安装的APK文件路径"
}

APK_INSTALLER_FILE_PATH_ERROR() {
    log_error "指定的APK文件不存在，请检查路径后重试"
}

APK_INSTALLER_APP_INSTALL_SUCCESS() {
    log_success "APK安装成功"
}

APK_INSTALLER_APP_INSTALL_ERROR() {
    log_error "APK安装失败，请检查文件是否有效"
}

#结束

#waydroid_installer_part1.sh提示信息

##debian及其衍生版
WAYDROID_INSTALLER_PART_1_DEBIAN_INFO() {
    echo "========================================"
    echo "       Waydroid安装脚本 - 第1部分    "
    echo "========================================"
    echo "检测到Debian/Ubuntu系统，开始安装Waydroid..."
}

##fedora及其衍生版
WAYDROID_INSTALLER_PART_1_FEDORA_INFO() {
    echo "========================================"
    echo "       Waydroid安装脚本 - 第1部分    "
    echo "========================================"
    echo "检测到Fedora/CentOS/Red Hat系统，开始安装Waydroid..."
}

##arch及其衍生版
WAYDROID_INSTALLER_PART_1_ARCH_INFO() {
    echo "========================================"
    echo "       Waydroid安装脚本 - 第1部分       "
    echo "========================================"
    echo "检测到Arch Linux系统，正在安装Waydroid..."
}

#安装
WAYDROID_INSTALLER_PART_1_INSTALL_1_SUCCESS() {
    log_success "Waydroid 依赖安装成功"
}

WAYDROID_INSTALLER_PART_1_INSTALL_1_ERROR() {
    log_error "Waydroid 依赖安装失败"
}

WAYDROID_INSTALLER_PART_1_ADD_REPO_SUCCESS() {
    log_success "Waydroid 仓库添加成功"
}

WAYDROID_INSTALLER_PART_1_ADD_REPO_ERROR() {
    log_error "Waydroid 仓库添加失败"
}

WAYDROID_INSTALLER_PART_1_INSTALL_2_SUCCESS() {
    log_success "Waydroid 安装器安装成功"
}

WAYDROID_INSTALLER_PART_1_INSTALL_2_ERROR() {
    log_error "Waydroid 安装器安装失败"
}

##不支持的系统
WAYDROID_INSTALLELR_PART_1_UNSUPPORTED_OS_INFO() {
    log_error "不支持的操作系统！"
}

#结束

#waydroid_installer_part.sh提示信息
##配置waydroid
WAYDROID_INSTALLER_PART_2_CONFIG_WAYDROID_INFO() {
    echo "========================================"
    echo "       Waydroid安装脚本 - 第2部分       "
    echo "========================================"
    log_info "正在配置waydroid..."
}

WAYDROID_INSTALLER_PART_2_FILES_STORE_INFO() {
    log_info "需要你提供ARM支持补丁安装脚本的安装路径"
}

WAYDROID_INSTALLLER_PART_2_RUN_SCRIPT_INFO() {
    log_info "正在运行补丁安装脚本..."
}

WAYDROID_INSTALLLER_PART_2_RUN_SCRIPT_SUCCESS() {
    log_success "安装成功"
}

WAYDROID_INSTALLLER_PART_2_RUN_SCRIPT_ERROR() {
    log_error "安装失败"
}

WAYDROID_INSTALLER_PART_2_END_INFO() {
    log_info "Waydroid安装结束"
}
#结束