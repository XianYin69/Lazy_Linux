# Language Variables Documentation

本文档整理了 `lib/lang/lang_lib/` 目录下英文（`en_us.sh`）和中文（`zh_cn.sh`）语言包中的所有变量定义。

---

## 颜色变量

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `INFO` | `\e[34m` | `\e[34m` |
| `SUCCESS` | `\e[32m` | `\e[32m` |
| `ERROR` | `\e[31m` | `\e[31m` |
| `WARNING` | `\e[33m` | `\e[33m` |
| `RESET` | `\e[0m` | `\e[0m` |

---

## 日志函数

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `log_info()` | `echo -e "${INFO}[INFO]${RESET} $1"` | `echo -e "${INFO}[信息]${RESET} $1"` |
| `log_success()` | `echo -e "${SUCCESS}[SUCCESS]${RESET} $1"` | `echo -e "${SUCCESS}[成功]${RESET} $1"` |
| `log_error()` | `echo -e "${ERROR}[ERROR]${RESET} $1"` | `echo -e "${ERROR}[错误]${RESET} $1"` |
| `log_warning()` | `echo -e "${WARNING}[WARNING]${RESET} $1"` | `echo -e "${WARNING}[注意]${RESET} $1"` |
| `log_info_custom()` | `echo -e "${INFO}$1${RESET}"` | `echo -e "${INFO}$1${RESET}"` |
| `log_success_custom()` | `echo -e "${INFO}$1${RESET}"` | `echo -e "${INFO}$1${RESET}"` |
| `log_error_custom()` | `echo -e "${INFO}$1${RESET}"` | `echo -e "${INFO}$1${RESET}"` |
| `log_warning_custom()` | `echo -e "${INFO}$1${RESET}"` | `echo -e "${INFO}$1${RESET}"` |

---

## lazy_linux.sh 主脚本

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `LAZY_LINUX_SH_INITIALIZE_TOOLKIT_INFO()` | `========================================\n          Initialize Toolkit            \n========================================\n1.Chinese Localization and Chinese Input Method Configuration Tool\n2.git Repository Cloning and Developer Configuration Tool\nPlease enter the option you want to use` | `========================================\n               初始化工具               \n========================================\n1.中文本地化及中文输入法配置工具\n2.git仓库克隆及开发者配置工具\n请输入你要使用的工具的选项` |
| `LAZY_LINUX_SH_INITIALIZE_TOOLKIT_CHOICE_ERROR()` | `log_error "No such option!"` | `log_error "没这个选项！"` |
| `LAZY_LINUX_SH_LINUX_CONFIGURER_INFO()` | `========================================\n          System Modification Tool      \n========================================\n1.Clean up Old Kernels and Images\n2.NVIDIA Driver Installation\nPlease enter the option you want to use` | `========================================\n               系统修改工具             \n========================================\n1.清理旧的内核及其映像\n2.英伟达驱动程序安装\n请输入你要使用的工具的选项` |
| `LAZY_LINUX_SH_LINUX_CONFIGURER_CHOICE_ERROR()` | `log_error "No such option!"` | `log_error "没这个选项！"` |
| `LAZY_LINUX_SH_BACKUP_AND_RESTORE_CHOICE_INFO()` | `========================================\n           Backup and Restore Tool      \n========================================\n1.Backup Files\n2.Restore Files\nPlease enter the option you want to use` | `========================================\n              备份与恢复工具            \n========================================\n1.备份文件\n2.恢复文件\n请输入你要使用的工具的选项` |
| `LAZY_LINUX_SH_BACKUP_AND_RESTORE_CHOICE_ERROR()` | `log_error "No such option!"` | `log_error "没这个选项！"` |
| `LAZY_LINUX_SH_SOFTWARE_INSTALLER_INFO()` | `========================================\n            Software Installer          \n========================================\n1.Install software\n2.Remove software\nPlease enter the option you want to use` | `========================================\n               软件安装工具             \n========================================\n1.安装软件\n2.卸载软件\n请输入你要使用的工具的选项` |
| `LAZY_LINUX_SH_SOFTWARE_INSTALLER_CHOICE_ERROR()` | `log_error "No such option!"` | `log_error "没这个选项！"` |
| `LAZY_LINUX_SH_WAYDROID_INFO()` | `========================================\n            WayDroid Tools              \n========================================\n1.WayDroid install and configure\n2.APK package installer\nPlease enter the option you want to use` | `========================================\n               WayDroid工具             \n========================================\n1.WayDroid安装及配置\n2.APK安装\n请输入你要使用的工具的选项` |
| `LAZY_LINUX_SH_WAYDROID_ERROR()` | `echo "No such option!"` | `echo "没这个选项！"` |
| `LAZY_LINUX_SH_SCRIPTS_SELECT_INFO()` | `========================================\n              Scripts Select            \n========================================\n1.Initialize Tool\n2.Software Installer\n3.System Configuration\n4.WayDroid Tools\n5.Backup and Restore\n6.System Update\n7.Seclect language\nPlease enter the option you want to use` | `========================================\n               脚本选择                 \n========================================\n1.初始化工具\n2.软件安装\n3.系统配置\n4.WayDroid\n5.备份与恢复\n6.系统更新\n7.语言选择\n请输入你要使用的脚本的选项` |
| `LAZY_LINUX_SH_SCRIPTS_SELECT_ERROR()` | `echo "No such option!"` | `echo "没这个选项！"` |
| `SYSTEM_OS_TYPE_INFO()` | `log_info_custom "Your system：$1"` | `log_info_custom "你的系统为：$1"` |
| `SYSTEM_KERNEL_VERSION_INFO()` | `log_info_custom "Your kernel version：$1"` | `log_info_custom "你的内核版本为：$1"` |
| `SYSTEM_SESSION_TYPE_INFO()` | `log_info_custom "Your sessoin：$1"` | `log_info_custom "你的桌面服务器是：$1"` |
| `LAZY_LINUX_SH_LANGUAGE_OPTION_INFO()` | `==========================\n     Select Language      \n==========================\n1.中文\n2.English\nPlease enter the option` | `==========================\n         语言选择         \n==========================\n1.中文\n2.English\n请输入选项` |
| `LAZY_LINUX_SH_LANGUAGE_OPTION_WARN()` | `log_warn "Need re-run Lazy_Linux.sh to apply change!!!"` | `log_warn "需要重新运行此脚本以应用修改！！！"` |
| `LAZY_LINUX_SH_FEDORA_ONLY_ERROR()` | `-` | `log_error "仅支持Fedora系发行版！！！(Only Fedora-based distributions are supported!!!)"` |

---

## backup.sh 备份工具

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `BACKUP_INFO()` | `========================================\n               Backup Tool              \n========================================` | `========================================\n               备份工具                 \n========================================` |
| `BACKUP_PATH_INFO()` | `echo "Please provide the path of the file or directory to back up"` | `echo "请提供要备份的文件或目录的路径"` |
| `BACKUP_STORE_INFO()` | `echo "Please provide the path to store the backup file"` | `echo "请提供备份文件存储的路径"` |
| `BACKUP_SUCCESS_INFO()` | `log_success "Backup successful!"` | `log_success "备份成功！"` |
| `BACKUP_FAIL_INFO()` | `log_error "Backup failed!"` | `log_error "备份失败！"` |

---

## restore.sh 恢复工具

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `RESTORE_INFO()` | `========================================\n               Restore Tool            \n========================================` | `========================================\n               恢复工具                 \n========================================` |
| `RESTORE_PATH_INFO()` | `echo "Please provide the path of the file or directory to restore"` | `echo "请提供要恢复的文件或目录的路径"` |
| `RESTORE_SUCCESS_INFO()` | `log_success "Restore successful!"` | `log_success "恢复成功！"` |
| `RESTORE_FAIL_INFO()` | `log_error "Restore failed!"` | `log_error "恢复失败！"` |

---

## first_run.sh 首次运行

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `FIRST_RUN_SH_ROOT_ERROR()` | `log_error "Please run this script as root!"` | `log_error "请以root用户运行此脚本！"` |

---

## chinesization.sh 中文本地化

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `CHINESIZATION_INPUT_METHOD_INFO()` | `========================================\n         Input Method Selection         \n========================================\n1)Fcitx 5\n2)ibus\nPlease select the input method (1 or 2)` | `========================================\n               输入法选择               \n========================================\n1)Fcitx 5\n2)ibus\n请选择输入法（1或2）` |
| `CHINESIZATION_INPUT_METHOD_FCITX_5_SELECT_INFO()` | `echo "You have selected the input method: Fcitx 5"` | `echo "你选择的输入法是：Fcitx 5"` |
| `CHINESIZATION_INPUT_METHOD_IBUS_SELECT_INFO()` | `echo "You have selected the input method: ibus"` | `echo "你选择的输入法是：ibus"` |
| `CHINESIZATION_INPUT_METHOD_CHOICE_ERROR()` | `log_error "Invalid selection. Please choose 1 or 2."` | `log_error "无效选择。请选择1或2。"` |
| `CHINESIZATION_ENVIRONMENT_INIT_INFO()` | `========================================\n          Session Type Selection        \n========================================\n1)X11\n2)Wayland\nPlease select the display server (1 or 2)` | `========================================\n               显示服务器选择           \n========================================\n1)X11\n2)Wayland\n请选择显示服务器（1或2）` |
| `CHINESIZATION_ADD_PROFILE_FCITX_5_INFO()` | `echo "Adding Fcitx 5 configuration file..."` | `echo "正在添加Fcitx 5配置文件..."` |
| `CHINESIZATION_ADD_PROFILE_FCITX_5_SUCCESS()` | `log_success "Fcitx 5 configuration file added successfully."` | `log_success " Fcitx 5配置文件添加成功。"` |
| `CHINESIZATION_ADD_PROFILE_IBUS_INFO()` | `echo "Adding ibus configuration file..."` | `echo "正在添加ibus配置文件..."` |
| `CHINESIZATION_ADD_PROFILE_IBUS_SUCCESS()` | `log_success "ibus configuration file added successfully."` | `log_success " ibus配置文件添加成功。"` |
| `CHINESIZATION_DESKTOP_ENVIRONMENT_INFO()` | `========================================\n       Desktop Environment Selection    \n========================================\n1)KDE\n2)GNOME\nPlease select the desktop environment (1 or 2)` | `========================================\n               桌面环境选择             \n========================================\n1)KDE\n2)GNOME\n请选择桌面环境（1或2）` |
| `CHINESIZATION_DESKTOP_ENVIRONMENT_ERROR()` | `log_error "Invalid selection. Please choose 1 or 2."` | `log_error "无效选择。请选择1或2。"` |
| `CHINESIZATION_ENVIRONMENT_INIT_ERROR()` | `log_error "Invalid selection. Please choose 1 or 2."` | `log_error "无效选项。请选择1或2。"` |
| `CHINESIZATION_INPUT_METHOD_CONFIG_INFO()` | `echo "Do you want to reconfigure the input method environment variables? (Y/n)"` | `echo "是否重新配置输入法环境变量？（Y/n）"` |
| `CHINESIZATION_INPUT_METHOD_CONFIG_ERROR()` | `log_warning "If you need to configure the input method related variables, please re-run this script."` | `log_warning "如果你需要配置输入法相关变量，请重新运行此脚本。"` |
| `CHINESIZATION_INSTALL_UBUNTU_INFO()` | `echo "Installing input method for Ubuntu and its derivatives..."` | `echo "正在为Ubuntu及其衍生版安装输入法..."` |
| `CHINESIZATION_INSTALL_UBUNTU_SUCCESS()` | `log_success "Input method installation successful."` | `log_success "输入法安装成功。"` |
| `CHINESIZATION_INSTALL_FEDORA_INFO()` | `echo "Installing input method for Fedora and its derivatives..."` | `echo "正在为Fedora及其衍生版安装输入法..."` |
| `CHINESIZATION_INSTALL_FEDORA_SUCCESS()` | `log_success "Input method installation successful."` | `log_success "输入法安装成功。"` |
| `CHINESIZATION_INSTALL_ARCH_INFO()` | `echo "Installing input method for Arch and its derivatives..."` | `echo "正在为Arch及其衍生版安装输入法..."` |
| `CHINESIZATION_INSTALL_ARCH_SUCCESS()` | `log_success "Input method installation successful."` | `log_success "输入法安装成功。"` |
| `CHINESIZATION_MODIFY_LOCALE_INFO()` | `echo "Modifying system language to zh_CN.UTF-8..."` | `echo "正在将系统语言修改为zh_CN.UTF-8..."` |
| `CHINESIZATION_MODIFY_LOCALE_ERROR()` | `log_error "Did not find locale generation file.\nExiting..."` | `log_error "找不到语言配置文件。\n正在退出..."` |
| `CHINESIZATION_REBUILD_LOCALE_ERROR()` | `log_error "Did not find locale generation file.\nIf needed, please ensure to manually generate zh_CN.UTF-8.\nExiting..."` | `log_error "找不到语言生成文件。\n如果需要，请确保手动生成zh_CN.UTF-8。\n正在退出..."` |
| `CHINESIZATION_OS_TYPE_ERROR()` | `log_error "Unsupported OS\nExiting..."` | `log_error "不支持的系统。\n正在退出..."` |
| `CHINESIZATION_REBOOT_INFO()` | `echo "System modification is complete. Do you want to reboot now? (Y/n)"` | `echo "是否现在重启系统以应用更改？（Y/n）"` |
| `CHINESIZATION_REBOOT_CANCEL_INFO()` | `log_info "Please remember to reboot the system later to apply changes.\nExiting..."` | `log_info "请记得稍后重启系统以应用更改。\n正在退出..."` |

---

## init_git.sh Git配置工具

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `INIT_GIT_GIT_INSTALL_ERROR()` | `log_error "Unsupported system.\nExiting..."` | `log_error "不支持的系统。\n正在退出..."` |
| `INIT_GIT_GIT_ERROR()` | `log_error "Git not detected. Installing git..."` | `log_error "未检测到git。正在安装git..."` |
| `INIT_GIT_WELCOME_INFO()` | `=============================================\nGit Configuration and Repository Cloning Tool\n=============================================` | `=========================================\n        Git 配置与仓库克隆工具        \n=========================================` |
| `INIT_GIT_INIT_INFO()` | `echo "This script will help you configure Git and clone repositories."` | `echo "此脚本将帮助您配置Git并克隆仓库。"` |
| `INIT_GIT_INIT_USERNAME_INFO()` | `echo "Please enter your GitHub username"` | `echo "请输入您的GitHub用户名"` |
| `INIT_GIT_USERNAME_ERROR()` | `log_error "Username cannot be empty. Please re-enter."` | `log_error "用户名不能为空。请重新输入。"` |
| `INIT_GIT_INIT_EMAIL_INFO()` | `echo "Please enter your GitHub email"` | `echo "请输入您的GitHub邮箱"` |
| `INIT_GIT_EMAIL_ERROR()` | `log_error "Email cannot be empty. Please re-enter."` | `log_error "邮箱不能为空。请重新输入。"` |
| `INIT_GIT_URL_INFO()` | `echo "Please enter the Git repository URL to clone"` | `echo "请输入要克隆的Git仓库URL"` |
| `INIT_GIT_URL_ERROR()` | `log_error "URL cannot be empty. Please re-enter."` | `log_error "URL不能为空。请重新输入。"` |
| `INIT_GIT_PATH_INFO()` | `echo "Please enter the path to store your files"` | `echo "请输入克隆到本地的路径"` |
| `INIT_GIT_PATH_ERROR()` | `log_error "Path cannot be empty. Please re-enter"` | `log_error "路径不能为空，请重新输入。"` |
| `INIT_GIT_CONFIG_INFO()` | `log_info "Configuring Git credentials..."` | `log_info "正在配置Git凭据..."` |
| `INIT_GIT_CONFIG_SUCCESS()` | `log_success "Git username and email have been set globally."` | `log_success "Git用户名和邮箱已全局设置完成。"` |
| `INIT_GIT_CLONE_INFO()` | `log_info "Cloning repository..."` | `log_info "正在克隆仓库..."` |
| `INIT_GIT_CLONE_SUCCESS()` | `log_success "Repository cloned successfully."` | `log_success "仓库克隆成功。"` |
| `INIT_GIT_CLONE_ERROR()` | `log_error "Repository cloning failed. Please check the URL and your permissions."` | `log_error "仓库克隆失败。请检查URL和您的权限。"` |

---

## super_clean_old_kernel.sh 内核清理工具

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `SUPER_CLEAN_OLD_KERNEL_VERSION_DIFF_INFO()` | `========================================\n           Kernel version mismatch               \n========================================` | `========================================\n           内核版本不一致               \n========================================` |
| `SUPER_CLEAN_OLD_KERNEL_VERSION_INFO()` | `log_info "Current running kernel version: $1"` | `log_info "当前运行的内核版本: $1"` |
| `SUPER_CLEAN_OLD_KERNEL_LASTED_VERSION_INFO()` | `log_warning "Latest installed kernel version: $1"` | `log_warning "最新安装的内核版本: $1"` |
| `SUPER_CLEAN_OLD_KERNEL_PROCESS_INITRAMFS_INFO()` | `log_info "Generating initramfs for the latest kernel and updating boot configuration..."` | `log_info "将为最新内核生成initramfs并更新引导配置"` |
| `SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_BOOT_INFO()` | `log_info "Cleaning up old boot files..."` | `log_info "正在清理旧的启动文件..."` |
| `SUPER_CLEAN_OLD_KERNEL_DELETE_INITRAMFS_INFO()` | `log_info "Cleaning up old initramfs files..."` | `log_info "正在清理旧的initramfs文件..."` |
| `SUPER_CLEAN_OLD_KERNEL_DELETE_INITRAMFS_SUCCESS()` | `log_success "Old initramfs files have been cleaned up."` | `log_success "旧的initramfs文件已清理完成"` |
| `SUPER_CLEAN_OLD_KERNEL_REGENERATE_INITRAMFS_INFO()` | `log_info "Generating initramfs..."` | `log_info "正在重新生成initramfs..."` |
| `SUPER_CLEAN_OLD_KERNEL_REGENERATING_INITRAMFS_INFO()` | `log_info "Generating initramfs for the latest kernel $lasted_kernel..."` | `log_info "为最新内核 $lasted_kernel 生成initramfs..."` |
| `SUPER_CLEAN_OLD_KERNEL_REGENERATE_INITRAMFS_SUCCESS()` | `log_success "initramfs generation complete"` | `log_success "initramfs生成完成"` |
| `SUPER_CLEAN_OLD_KERNEL_REGENERATE_INITRAMFS_ERROR()` | `log_error "initramfs generation failed"` | `log_error "initramfs生成失败"` |
| `SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_GRUB_INFO()` | `log_info "Updating GRUB configuration..."` | `log_info "正在更新GRUB配置..."` |
| `SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_GRUB_SUCCESS()` | `log_success "GRUB configuration updated successfully."` | `log_success "GRUB配置更新完成"` |
| `SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_GRUB_ERROR()` | `log_error "GRUB configuration update failed."` | `log_error "GRUB配置更新失败"` |
| `SUPER_CLEAN_OLD_KERNEL_INFO()` | `========================================\n         Super Clean Old Kernel Tool            \n========================================` | `========================================\n         超级清理旧内核工具            \n========================================` |
| `SUPER_CLEAN_OLD_KERNEL_IF_INSTALLED_NVIDIA_WARNING()` | `log_warning "If you are using an NVIDIA graphics card, you need to reinstall the NVIDIA driver after rebooting."` | `log_warning "如果你使用nvidia显卡，则重启后需要重新安装nvidia驱动"` |
| `SUPER_CLEAN_OLD_KERNEL_END_INFO()` | `log_success "All operations have been completed!"\nlog_success "It is recommended to reboot the system to apply the changes."\nlog_success "If the system fails to boot, you can select the backup kernel version from the GRUB menu."` | `log_success "所有操作已完成！"\nlog_success "建议重启系统以应用更改。"\nlog_success "如果系统无法启动，可以通过GRUB菜单选择备份的内核版本启动。"` |

---

## nvidia_driver_installer_part1.sh NVIDIA驱动安装第1部分

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `NVIDIA_DRIVER_INSTALLER_PART_1_INFO()` | `========================================\n       NVIDIA Driver Installer - Part 1     \n========================================` | `========================================\n       NVIDIA驱动安装脚本 - 第1部分    \n========================================` |
| `NVIDIA_DRIVER_INSTALLER_PART_1_STEP_1_INFO()` | `echo " Step 1 - Install Required Packages "` | `echo " 步骤 1-安装必要软件包 "` |
| `NVIDIA_DRIVER_INSTALLER_PART_1_STEP_1_SUCCESS()` | `log_success " Required packages installed successfully "` | `log_success " 必要软件包安装完成 "` |
| `NVIDIA_DRIVER_INSTALLER_PART_1_STEP_2_INFO()` | `echo " Step 2 - Disable Nouveau "` | `echo " 步骤 2-禁用nouveau "` |
| `NVIDIA_DRIVER_INSTALLER_PART_1_STEP_2_SUCCESS()` | `log_success " Nouveau disabled successfully "` | `log_success " nouveau禁用完成 "` |
| `NVIDIA_DRIVER_INSTALLER_PART_1_END_INFO()` | `log_info " All steps in Part 1 are complete. "\nlog_warning " The system will reboot in 10 seconds to apply changes. You can press Ctrl+C to cancel the reboot. "` | `log_info " 第1部分完成！ "\nlog_warning " 重启后请运行nvidia-driver-installer-part-2.sh继续安装NVIDIA驱动"` |
| `NVIDIA_DRIVER_INSTALLER_PART_1_REBOOT_WARNING()` | `log_warning " The system will reboot in 10 seconds to apply changes. You can press Ctrl+C to cancel the reboot. "` | `log_warning " 系统将于10秒后重启,你可以按Ctrl+C取消重启"` |
| `NVIDIA_DRIVER_INSTALLER_PART_1_REBOOTING_INFO()` | `log_info " The system is rebooting..."` | `log_info " 系统正在重启..."` |

---

## nvidia_driver_installer_part2.sh NVIDIA驱动安装第2部分

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `NVIDIA_DRIVER_INSTALLER_PART_2_ENVIRONMENT_ERROR()` | `log_error " Please run this script in a non-graphical environment "\nlog_warning " Please save all work and close all applications "\nlog_warning " Press Enter to enter single-user mode, or press Ctrl+C to cancel "` | `log_error " !!!现在需要在单用户模式下运行此脚本!!! "\nlog_warning " 请保存所有工作并关闭所有应用程序 "\nlog_warning " 按下Enter进入单用户模式，或按Ctrl+C取消 "` |
| `NVIDIA_DRIVER_INSTALLER_PART_2_INFO()` | `========================================\n       NVIDIA Driver Installer - Part 2  \n========================================\n Step 1 - Install Driver \nlog_info " Please enter the full path to the driver "` | `========================================\n       NVIDIA驱动安装脚本 - 第2部分    \n========================================\n 步骤 1-安装驱动 \nlog_info " 请输入驱动程序的完整路径 "` |
| `NVIDIA_DRIVER_INSTALLER_PART_2_PATH_ERROR()` | `log_error " Driver file not found! "\nlog_error " Please check the path and try again. "` | `log_error " 驱动文件未找到 "\nlog_error " 请检查路径是否正确 "` |
| `NVIDIA_DRIVER_INSTALLER_PART_2_PATH_SUCCESS()` | `log_success " Driver file found. "` | `log_success " 驱动文件找到 "` |
| `NVIDIA_DRIVER_INSTALLER_PART_2_DRIVER_READY_INFO()` | `log_info " Driver is ready to install. "` | `log_info " 驱动程序已准备好安装 "` |
| `NVIDIA_DRIVER_INSTALLER_PART_2_DRIVER_INSTALLING_WARNING()` | `log_warning " Driver installation will begin in 30 seconds. "\nlog_warning " Please ensure all work is saved. "\nlog_warning " select "yes" when prompted during installation. "\nlog_warning " Press Enter to continue, or press Ctrl+C to cancel. "` | `log_warning " 驱动安装程序即将在30秒后运行 "\nlog_warning " 请确保已保存所有工作 "\nlog_warning " 安装程序里的选项全选"Yes" "\nlog_warning " 按下Enter继续，或按Ctrl+C取消 "` |

---

## nvidia_driver_installer_part3.sh NVIDIA驱动安装第3部分

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `NVIDIA_DRIVER_INSTALLER_PART_3_STEP_1_INFO()` | `========================================\n       NVIDIA Driver Installer - Part 3  \n========================================\n Step 1 - Start Daemon ` | `========================================\n       NVIDIA驱动安装脚本 - 第3部分    \n========================================\n 步骤 1-启动守护进程 ` |
| `NVIDIA_DRIVER_INSTALLER_PART_3_STEP_1_SUCCESS()` | `log_success " Services enabled successfully "` | `log_success " 守护进程已启用 "` |
| `NVIDIA_DRIVER_INSTALLER_PART_3_STEP_2_INFO()` | `echo " Step 2 - Sign Kernel Modules "` | `echo " 步骤 2-签署内核模块 "` |
| `NVIDIA_DRIVER_INSTALLER_PART_3_STEP_2_SECURE_BOOT_ENABLED_INFO()` | `log_info "Secure boot enabled in your bios"\nlog_info "Signing kernel moudle"\nlog_warning "You may set a password of MOK"` | `log_info " 检测到安全启动已启用 "\nlog_info " 正在签署内核模块 "\nlog_warning " 你可能需要输入MOK密码 "` |
| `NVIDIA_DRIVER_INSTALLER_PART_3_STEP_2_SUCCESS()` | `log_success " Kernel module signing complete "` | `log_success " 内核模块签署完成 "` |
| `NVIDIA_DRIVER_INSTALLER_PART_3_END_INFO()` | `log_success " All steps in Part 3 are complete, the system will reboot in 10 seconds. You can press Ctrl+C to cancel the reboot. "` | `log_success " 安装完成，将在10秒后重启，你可以按Ctrl+C取消重启 "` |

---

## software_installer.sh 软件安装工具

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `SOFTWARE_INSTALLER_READING_SOFTWARE_LIST_INFO()` | `log_info "software list path"` | `log_info "请输入软件列表文件的路径"` |
| `SOFTWSARE_INSTALLER_FILE_READING_ERROR()` | `log_error "Read file wrong :("\nlog_error "File format incurrent"\nlog_error "will re-edit after 10s"` | `log_error "软件列表文件读取失败"\nlog_error "请检查文件格式是否正确"\nlog_error "将在10秒后重新编辑文件"` |
| `SOFTWARE_INSTALLER_FILE_READING_SUCCESS()` | `log_success "Read file successfully"` | `log_success "软件列表文件读取成功"` |
| `SOFTWARE_INSTALELR_FEDORA_INSTALLER_INFO()` | `log_info "Install software"` | `log_info "开始安装软件..."` |
| `SOFTWARE_INSTALLER_FEDORA_DNF_INFO()` | `log_info "Installing $1 ..."` | `log_info "正在安装 $1 ..."` |
| `SOFTWARE_INSTALLER_FEDORA_DNF_SUCCESS()` | `log_success "$1 installed"` | `log_success "$1 安装成功。"` |
| `SOFTWARE_INSTALLER_FEDORA_DNF_ERROR()` | `log_error "$1 fail installed。"` | `log_error "$1 安装失败。"` |
| `SOFTWARE_INSTALLER_FEDORA_DNF_SKIP_WARN()` | `log_warning "$1 installed then ignored"` | `log_warning "$1 已经安装，跳过。"` |
| `SOFTWARE_INSTALLER_DEBIAN_INFO()` | `log_info "Install software"` | `log_info "开始安装软件..."` |
| `SOFTWARE_INSTALLER_DEBIAN_APT_INFO()` | `log_info "Installing $1 ..."` | `log_info "正在安装 $1 ..."` |
| `SOFTWARE_INSTALLER_DEBIAN_APT_SUCCESS()` | `log_success "$1 installed"` | `log_success "$1 安装成功。"` |
| `SOFTWARE_INSTALLER_DEBIAN_APT_ERROR()` | `log_error "$1 fail installed"` | `log_error "$1 安装失败。"` |
| `SOFTWARE_INSTALLER_DEBIAN_APT_SKIP_WARN()` | `log_warning "$1 installed then ignored"` | `log_warning "$1 已经安装，跳过。"` |
| `SOFTWARE_INSTALLER_ARCH_INSTALLER_INFO()` | `log_info "Install software"` | `log_info "开始安装软件..."` |
| `SOFTWARE_INSTALLER_ARCH_PACMAN_INFO()` | `log_info "Installing $1 ..."` | `log_info "正在安装 $1 ..."` |
| `SOFTWARE_INSTALLER_ARCH_PACMAN_SUCCESS()` | `log_success "$1 installed"` | `log_success "$1 安装成功。"` |
| `SOFTWARE_INSTALLER_ARCH_PACMAN_ERROR()` | `log_error "$1 fail installed"` | `log_error "$1 安装失败。"` |
| `SOFTWARE_INSTALLER_ARCH_PACMAN_SKIP_WARN()` | `log_warning "$1 installed then ignored"` | `log_warning "$1 已经安装，跳过。"` |
| `SOFTWARE_INSTALLER_SNAP_NOT_INSTALLED_INFO()` | `log_warning "Snap not find and installing Snap..."` | `log_warning "Snap 未安装，正在安装 Snap..."` |
| `SOFTWARE_INSTALLER_SNAP_INSTALLED_INFO()` | `log_info "Snap installed"` | `log_info "已经安装 Snap，跳过。"` |
| `SOFTWARE_INSTALLER_SNAP_INSTALL_SUCCESS()` | `log_success "Snap installed successfully"` | `log_success "Snap 安装成功。"` |
| `SOFTWARE_INSTALLER_SNAP_INSTALLER_INFO()` | `log_info "Installing $1 ..."` | `log_info "正在安装 $1 ..."` |
| `SOFTWARE_INSTALLER_SNAP_INSTALL_SUCCESS()` (duplicate) | `log_success "$1 installed"` | `log_success "$1 通过 Snap 安装成功。"` |
| `SOFTWARE_INSTALLER_SNAP_INSTALL_ERROR()` | `log_error "$1 fail installed"` | `log_error "$1 通过 Snap 安装失败。"` |
| `SOFTWARE_INSTALLER_SNAP_INSTALL_SKIP_WARN()` | `log_warning "$1 installed then ignored"` | `log_warning "$1 已经通过 Snap 安装，跳过。"` |
| `SOFTWARE_INSTALLER_FLATPAK_NOT_INSTALLED_INFO()` | `log_warning "Flatpak not find and installing Flatpak..."` | `log_warning "Flatpak 未安装，正在安装 Flatpak..."` |
| `SOFTWARE_INSTALLER_FLATAPAK_INSTALL_SKIP_WARN()` | `log_info "Flatpak installed"` | `log_info "已经安装 Flatpak，跳过。"` |
| `SOFTWARE_INSTALLER_FLATPAK_INSTALL_SUCCESS()` | `log_success "$1 installed"` | `log_success "$1 通过 Flatpak 安装成功。"` |
| `SOFTWARE_INSTALLER_FLATPAK_INSTALL_ERROR()` | `log_error "$1 fail installed"` | `log_error "$1 通过 Flatpak 安装失败。"` |
| `SOFTWARE_INSTALLER_FLATPAK_INSTALLER_SKIP_WARN()` | `log_warning "$1 installed then ignored"` | `log_warning "$1 已经通过 Flatpak 安装，跳过。"` |

---

## apk_installer.sh APK安装工具

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `APK_INSTALLER_WAYDROID_NOT_INSTALLED_ERROR()` | `log_error "Waydroid not find and please install Waydroid"` | `log_error "Waydroid未安装或未初始化，请先安装并初始化Waydroid"` |
| `APK_INSTALLER_WAYDROID_INSTALLED_INFO()` | `log_success "Waydroid installed"` | `log_success "检测到Waydroid已安装"` |
| `APK_INSTALLER_FILE_PATH_INFO()` | `echo "APK(.apk) file path"` | `echo "请输入要安装的APK文件路径"` |
| `APK_INSTALLER_FILE_PATH_ERROR()` | `log_error "file not find:(")` | `log_error "指定的APK文件不存在，请检查路径后重试"` |
| `APK_INSTALLER_APP_INSTALL_SUCCESS()` | `log_success "APK installed"` | `log_success "APK安装成功"` |
| `APK_INSTALLER_APP_INSTALL_ERROR()` | `log_error "APK fail installed"` | `log_error "APK安装失败，请检查文件是否有效"` |

---

## waydroid_installer_part1.sh Waydroid安装第1部分

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `WAYDROID_INSTALLER_PART_1_DEBIAN_INFO()` | `========================================\n       Install Waydroid - part 1    \n========================================\nChecked that is Debian universe,installing Waydroid...` | `========================================\n       Waydroid安装脚本 - 第1部分    \n========================================\n检测到Debian/Ubuntu系统，开始安装Waydroid...` |
| `WAYDROID_INSTALLER_PART_1_FEDORA_INFO()` | `========================================\n      Install Waydroid - part 1   \n========================================\nChecked that is Red Hat universe,installing Waydroid...` | `========================================\n       Waydroid安装脚本 - 第1部分    \n========================================\n检测到Fedora/CentOS/Red Hat系统，开始安装Waydroid...` |
| `WAYDROID_INSTALLER_PART_1_ARCH_INFO()` | `========================================\n       Install Waydroid - part 1       \n========================================\nChecked that Arch Linux universe，installing Waydroid...` | `========================================\n       Waydroid安装脚本 - 第1部分       \n========================================\n检测到Arch Linux系统，正在安装Waydroid...` |
| `WAYDROID_INSTALLER_PART_1_INSTALL_1_SUCCESS()` | `log_success "Waydroid dependences installed"` | `log_success "Waydroid 依赖安装成功"` |
| `WAYDROID_INSTALLER_PART_1_INSTALL_1_ERROR()` | `log_error "Waydroid dependences fail installed"` | `log_error "Waydroid 依赖安装失败"` |
| `WAYDROID_INSTALLER_PART_1_ADD_REPO_SUCCESS()` | `log_success "Waydroid repository added"` | `log_success "Waydroid 仓库添加成功"` |
| `WAYDROID_INSTALLER_PART_1_ADD_REPO_ERROR()` | `log_error "Waydroid repository fail added"` | `log_error "Waydroid 仓库添加失败"` |
| `WAYDROID_INSTALLER_PART_1_INSTALL_2_SUCCESS()` | `log_success "Waydroid installer installed"` | `log_success "Waydroid 安装器安装成功"` |
| `WAYDROID_INSTALLER_PART_1_INSTALL_2_ERROR()` | `log_error "Waydroid installer fail installed"` | `log_error "Waydroid 安装器安装失败"` |
| `WAYDROID_INSTALLELR_PART_1_UNSUPPORTED_OS_INFO()` | `log_error "Unsupported OS"` | `log_error "不支持的操作系统！"` |

---

## waydroid_installer_part2.sh Waydroid安装第2部分

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `WAYDROID_INSTALLER_PART_2_CONFIG_WAYDROID_INFO()` | `========================================\n       Install Waydroid - part 2       \n========================================\nlog_info "Configing waydroid..."` | `========================================\n       Waydroid安装脚本 - 第2部分       \n========================================\nlog_info "正在配置waydroid..."` |
| `WAYDROID_INSTALLER_PART_2_FILES_STORE_INFO()` | `log_info "Where you want to store patcher"` | `log_info "需要你提供ARM支持补丁安装脚本的安装路径"` |
| `WAYDROID_INSTALLLER_PART_2_RUN_SCRIPT_INFO()` | `log_info "Running patcher ..."` | `log_info "正在运行补丁安装脚本..."` |
| `WAYDROID_INSTALLLER_PART_2_RUN_SCRIPT_SUCCESS()` | `log_success "Installed successfully"` | `log_success "安装成功"` |
| `WAYDROID_INSTALLLER_PART_2_RUN_SCRIPT_ERROR()` | `log_error "fail installed"` | `log_error "安装失败"` |
| `WAYDROID_INSTALLER_PART_2_END_INFO()` | `log_info "Waydroid installed"` | `log_info "Waydroid安装结束"` |

---

## system_update.sh 系统更新

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) |
|--------|---------------|---------------|
| `UBUNTU_UPDATE_SH_OS_TYPE_INFO()` | `log_info "Detected Ubuntu system, starting update..."` | `log_info "检测到系统为Ubuntu，开始更新..."` |
| `UBUNTU_UPDATE_SH_UNSUPPORTED_OS_TYPE_ERROR()` | `log_error "Unsupported operating system type! This script only supports Ubuntu."\nlog_error_custom "Exiting in 5 seconds..."` | `log_error "不支持的操作系统类型！此脚本仅支持Ubuntu."\nlog_error_custom "将在5秒后退出..."` |

---

## 说明

- **颜色变量**：在所有语言包中保持相同值（ANSI转义码）
- **日志函数**：前缀标签根据语言变化（如 `[INFO]` → `[信息]`）
- **函数变量**：格式为 `FUNCTION_NAME()`，其值为函数体内的 echo/log 输出内容
- **`-`** 表示该变量仅存在于一种语言包中
- 相同功能但不同拼写的变量（如 `WAYDROID_INSTALLLER_` 与 `WAYDROID_INSTALLER_`）保留原样

## 新增语言变量 (2025-09-07)

以下变量在本次扫描中发现但之前未在语言文件中定义，现已补充：

| 变量名 | 英文值 (en_us) | 中文值 (zh_cn) | 来源脚本 |
|--------|---------------|---------------|---------|
| `SUPER_CLEAN_OLD_KERNEL_VERSION_SAME_INFO()` | `log_success "Kernel version is consistent: $1"` | `log_success "内核版本一致：$1"` | `super_clean_old_kernel.sh` |
| `SUPER_CLEAN_OLD_KERNEL_UPDATE_GRUB_INFO()` | `log_info "Updating GRUB configuration due to kernel changes..."` | `log_info "正在更新GRUB配置..."` | `super_clean_old_kernel.sh` |
| `SOFTWARE_INSTALLER_SOFTWARE_LIST_PATH_SUCCESS()` | `log_success "Software list file found and loaded successfully"` | `log_success "软件列表文件找到并加载成功"` | `software_installer.sh` |
| `SOFTWARE_INSTALLER_FEDORA_INSTALLER_INFO()` | `log_info "Installing software for Fedora..."` | `log_info "正在为Fedora安装软件..."` | `software_installer.sh` |
| `SOFTWARE_INSTALLER_FLATPAK_INSTALL_INFO()` | `log_info "Installing $1 via Flatpak..."` | `log_info "正在通过 Flatpak 安装 $1..."` | `software_installer.sh` |
| `NVIDIA_DRIVER_INSTALLER_PART_3_STEP_2_SECURE_BOOT_ENABLED_INFO()` | `log_info "Secure boot enabled in your BIOS"
log_info "Signing kernel modules"
log_warning "You may need to set a MOK password"` | `log_info "检测到安全启动已启用"
log_info "正在签署内核模块"
log_warning "你可能需要输入MOK密码"` | `nvidia_driver_installer_part3.sh` |
| `WAYDROID_INSTALLELR_PART_1_ARCH_INFO()` | `echo "========================================"
       Install Waydroid - part 1       
========================================
Checked that Arch Linux universe，installing Waydroid...` | `echo "========================================"
       Waydroid安装脚本 - 第1部分       
========================================
检测到Arch Linux系统，正在安装Waydroid...` | `waydroid_installer_part1.sh` |

---

