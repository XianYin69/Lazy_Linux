#!/bin/bash
# =================================================================================================
# Script name：en_US-info.sh   
# Description：English_language_package
# Author：XianYin69      
# Referance from：None  
# Date：Sep-11-2025       
# =================================================================================================

#define color
readonly INFO="\e[34m"
readonly SUCCESS="\e[32m"
readonly ERROR="\e[31m"
readonly WARNING="\e[33m"
readonly RESET="\e[0m"

#log function
log_info() {
    echo -e "${INFO}[INFO]${RESET} $1"
}
log_success() {
    echo -e "${SUCCESS}[SUCCESS]${RESET} $1"
}
log_error() {
    echo -e "${ERROR}[ERROR]${RESET} $1"
}
log_warning() {
    echo -e "${WARNING}[WARNING]${RESET} $1"
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

#lazy_linux.sh tips
LAZY_LINUX_SH_INITIALIZE_TOOLKIT_INFO() {
    echo "========================================"
    echo "          Initialize Toolkit            "
    echo "========================================"
    echo "1.Chinese Localization and Chinese Input Method Configuration Tool"
    echo "2.git Repository Cloning and Developer Configuration Tool"
    echo "Please enter the option you want to use"
}

LAZY_LINUX_SH_INITIALIZE_TOOLKIT_CHOICE_ERROR() {
    log_error "No such option!"
}

LAZY_LINUX_SH_LINUX_CONFIGURER_INFO() {
    echo "========================================"
    echo "          System Modification Tool      "
    echo "========================================"
    echo "1.Clean up Old Kernels and Images"
    echo "2.NVIDIA Driver Installation"
    echo "Please enter the option you want to use"
}

LAZY_LINUX_SH_LINUX_CONFIGURER_CHOICE_ERROR() {
    log_error "No such option!"    
}

LAZY_LINUX_SH_BACKUP_AND_RESTORE_CHOICE_INFO() {
    echo "========================================"
    echo "           Backup and Restore Tool      "
    echo "========================================"
    echo "1.Backup Files"
    echo "2.Restore Files"
    echo "Please enter the option you want to use"
}

LAZY_LINUX_SH_BACKUP_AND_RESTORE_CHOICE_ERROR() {
    log_error "No such option!"    
}

LAZY_LINUX_SH_SOFTWARE_INSTALLER_INFO() {
    echo "========================================"
    echo "            Software Installer          "
    echo "========================================"
    echo "1.Install software"
    echo "2.Remove software"
    echo "Please enter the option you want to use"
}

LAZY_LINUX_SH_SOFTWARE_INSTALLER_CHOICE_ERROR() {
    log_error "No such option!"    
}

LAZY_LINUX_SH_WAYDROID_INFO() {
    echo "========================================"
    echo "            WayDroid Tools              "
    echo "========================================"
    echo "1.WayDroid install and configure"
    echo "2.APK package installer"
    echo "Please enter the option you want to use"
}

LAZY_LINUX_SH_WAYDROID_ERROR() {
    echo "No such option!"
}

LAZY_LINUX_SH_SCRIPTS_SELECT_INFO() {
    echo "========================================"
    echo "              Scripts Select            "
    echo "========================================"
    echo "1.Initialize Tool"
    echo "2.Software Installer"
    echo "3.System Configuration"
    echo "4.WayDroid Tools"
    echo "5.Backup and Restore"
    echo "Please enter the option you want to use"
}

LAZY_LINUX_SH_SCRIPTS_SELECT_ERROR() {
    echo "No such option!"
}

SYSTEM_OS_TYPE_INFO() {
    log_info_custom "Your system：$1"
}

SYSTEM_KERNEL_VERSION_INFO() {
    log_info_custom "Your kernel version：$1"
}

SYSTEM_SESSION_TYPE_INFO() {
    log_info_custom "Your sessoin：$1"
}
#end

#backup.sh tips
BACKUP_INFO() {
    echo "========================================"
    echo "               Backup Tool              "
    echo "========================================"
}

BACKUP_PATH_INFO() {
    echo "Please provide the path of the file or directory to back up"
}

BACKUP_STORE_PATH_INFO() {
    echo "Please provide the path to store the backup file"
}

BACKUP_SUCCESS_INFO() {
    log_success "Backup successful!"
}

BACKUP_FAIL_INFO() {
    log_error "Backup failed!"
}

#restore.sh tips
RESTORE_INFO() {
    echo "========================================"
    echo "               Restore Tool            "
    echo "========================================"
}

RESTORE_PATH_INFO() {
    echo "Please provide the path of the file or directory to restore"
}

RESTORE_SUCCESS_INFO() {
    log_success "Restore successful!"
}

RESTORE_FAIL_INFO() {
    log_error "Restore failed!"
}

#end

#first_run.sh tips
FIRST_RUN_SH_ROOT_ERROR() {
    log_error "Please run this script as root!"
}
#end


#chinesization.sh tips
##Input Method Selection
CHINESIZATION_INPUT_METHOD_INFO() {
    echo "========================================"
    echo "         Input Method Selection         "
    echo "========================================"
    echo "1)Fcitx 5"
    echo "2)ibus"
    echo "Please select the input method (1 or 2)"
}

CHINESIZATION_INPUT_METHOD_FCITX_5_SELECT_INFO() {
    echo "You have selected the input method: Fcitx 5"
}

CHINESIZATION_INPUT_METHOD_IBUS_SELECT_INFO() {
    echo "You have selected the input method: ibus"
}

CHINESIZATION_INPUT_METHOD_CHOICE_ERROR() {
    log_error "Invalid selection. Please choose 1 or 2."
}

##session type selection tips
CHINESIZATION_ENVIRONMENT_INIT_INFO() {
    echo "========================================"
    echo "          Session Type Selection        "
    echo "========================================"
    echo "1)X11"
    echo "2)Wayland"
    echo "Please select the display server (1 or 2)"
}

CHINESIZATION_ADD_PROFILE_FCITX_5_INFO() {
    echo "Adding Fcitx 5 configuration file..."
}

CHINESIZATION_ADD_PROFILE_FCITX_5_SUCCESS() {
    log_success "Fcitx 5 configuration file added successfully."
}

CHINESIZATION_ADD_PROFILE_IBUS_INFO() {
    echo "Adding ibus configuration file..."
}

CHINESIZATION_ADD_PROFILE_IBUS_SUCCESS() {
    log_success "ibus configuration file added successfully."
}

#desktop environment selection tips
CHINESIZATION_DESKTOP_ENVIRONMENT_INFO() {
    echo "========================================"
    echo "       Desktop Environment Selection    "
    echo "========================================"
    echo "1)KDE"
    echo "2)GNOME"
    echo "Please select the desktop environment (1 or 2)"
}

CHINESIZATION_DESKTOP_ENVIRONMENT_ERROR() {
    log_error "Invalid selection. Please choose 1 or 2."
}

CHINESIZATION_ENVIRONMENT_INIT_ERROR() {
    log_error "Invalid selection. Please choose 1 or 2."
}

##configure input method environment variables tips
CHINESIZATION_INPUT_METHOD_CONFIG_INFO() {
    echo "Do you want to reconfigure the input method environment variables? (Y/n)"
}

CHINESIZATION_INPUT_METHOD_CONFIG_ERROR() {
    log_warn "If you need to configure the input method related variables, please re-run this script."
}

##input method installation tips
###ubuntu and its derivatives
CHINESIZATION_INSTALL_UBUNTU_INFO() {
    echo "Installing input method for Ubuntu and its derivatives..."
}

CHINESIZATION_INSTALL_UBUNTU_SUCCESS() {
    log_success "Input method installation successful."
}

###Fedora and its derivatives
CHINESIZATION_INSTALL_FEDORA_INFO() {
    echo "Installing input method for Fedora and its derivatives..."
}

CHINESIZATION_INSTALL_FEDORA_SUCCESS() {
    log_success "Input method installation successful."
}

###arch and its derivatives
CHINESIZATION_INSTALL_ARCH_INFO() {
    echo "Installing input method for Arch and its derivatives..."
}

CHINESIZATION_INSTALL_ARCH_SUCCESS() {
    log_success "Input method installation successful."
}

##modify locale
CHINESIZATION_MODIFY_LOCALE_INFO() {
    echo "Modifying system language to zh_CN.UTF-8..."
}

CHINESIZATION_MODIFY_LOCALE_ERROR() {
    log_error "Did not find locale generation file."
    log_error "Exiting..."
}

CHINESIZATION_REBUILD_LOCALE_ERROR() {
    log_error "Did not find locale generation file."
    log_error "If needed, please ensure to manually generate zh_CN.UTF-8."
    log_error "Exiting..."
}

CHINESIZATION_MODIFY_LOCALE_ERROR() {
    log_success "System language has been modified to zh_CN.UTF-8."
}

##main function
###System Type Error
CHINESIZATION_OS_TYPE_ERROR() {
    log_error "Unsupported OS"
    log_error "Exiting..."
}

###Reboot System
CHINESIZATION_REBOOT_INFO() {
    echo "System modification is complete. Do you want to reboot now? (Y/n)"
}

CHINESIZATION_REBOOT_CANCEL_INFO() {
    log_info "Please remember to reboot the system later to apply changes."
    log_info "Exiting..."
}

#end

#init_git.sh tips
##git install
INIT_GIT_GIT_INSTALL_ERROR() {
    log_error "Unsupported system."
    log_error "Exiting..."
}

INIT_GIT_GIT_ERROR() {
    log_error "Git not detected. Installing git..."
}

##git welcome info
INIT_GIT_WELCOME_INFO() {
    echo "============================================="
    echo "Git Configuration and Repository Cloning Tool"
    echo "============================================="
    echo
}

##user information input
INIT_GIT_INIT_INFO() {
    echo "This script will help you configure Git and clone repositories."
}

INIT_GIT_INIT_USERNAME_INFO() {
    echo "Please enter your GitHub username"
}

INIT_GIT_USERNAME_ERROR() {
    log_error "Username cannot be empty. Please re-enter."
}

INIT_GIT_INIT_EMAIL_INFO() {
    echo "Please enter your GitHub email"
}

INIT_GIT_EMAIL_ERROR() {
    log_error "Email cannot be empty. Please re-enter."
}

INIT_GIT_URL_INFO() {
    echo "Please enter the Git repository URL to clone"
}

INIT_GIT_URL_ERROR() {
    log_error "URL cannot be empty. Please re-enter."
}

##git configuration
INIT_GIT_CONFIG_INFO() {
    log_info "Configuring Git credentials..."
}

INIT_GIT_CONFIG_SUCCESS() {
    log_success "Git username and email have been set globally."
}

##clone repository
INIT_GIT_CLONE_INFO() {
    log_info "Cloning repository..."
}

INIT_GIT_CLONE_SUCCESS() {
    log_success "Repository cloned successfully."
}

INIT_GIT_CLONE_ERROR() {
    log_error "Repository cloning failed. Please check the URL and your permissions."
}

#end

#super_clean_old_kernel.sh tips
##kernel version check
SUPER_CLEAN_OLD_KERNEL_VERSION_DIFF_INFO() {
    echo "========================================"
    log_error_custom "           Kernel version mismatch               "
    echo "========================================"
}

SUPER_CLEAN_OLD_KERNEL_VERSION_INFO() {
    log_info "Current running kernel version: $1"
}

SUPER_CLEAN_OLD_KERNEL_LASTED_VERSION_INFO() {
    log_warn "Latest installed kernel version: $1"
}

SUPER_CLEAN_OLD_KERNEL_PROCESS_INITRAMFS_INFO() {
    log_info "Generating initramfs for the latest kernel and updating boot configuration..."
}

SUPER_CLEAN_OLD_KERNEL_LASTED_VERSION_INFO() {
    echo "========================================"
    log_success_custom "Kernel version is consistent: $1"
    echo "========================================"
}

##Delete old boot files
SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_BOOT_INFO() {
    log_info "Cleaning up old boot files..."
}

##Delete old initramfs files
SUPER_CLEAN_OLD_KERNEL_DELETE_INITRAMFS_INFO() {
    log_info "Cleaning up old initramfs files..."
}

SUPER_CLEAN_OLD_KERNEL_DELETE_INITRAMFS_SUCCESS() {
    log_success "Old initramfs files have been cleaned up."
}

##Regenerate initramfs
SUPER_CLEAN_OLD_KERNEL_REGENERATE_INITRAMFS_INFO() {
    log_info "Generating initramfs..."
}

SUPER_CLEAN_OLD_KERNEL_REGENERATING_INITRAMFS_INFO() {
    log_info "Generating initramfs for the latest kernel $lasted_kernel..."
}

SUPER_CLEAN_OLD_KERNEL_REGENERATE_INITRAMFS_SUCCESS() {
    log_success "initramfs generation complete"
}

SUPER_CLEAN_OLD_KERNEL_REGENERATE_INITRAMFS_ERROR() {
    log_error "initramfs generation failed"
}

##Update GRUB
SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_GRUB_INFO() {
    log_info "Updating GRUB configuration..."
}

SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_GRUB_SUCCESS() {
    log_success "GRUB configuration updated successfully."
}

SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_GRUB_ERROR() {
    log_error "GRUB configuration update failed."
}

##main function
SUPER_CLEAN_OLD_KERNEL_INFO() {
    echo "========================================"
    echo "         Super Clean Old Kernel Tool            "
    echo "========================================"
}

SUPER_CLEAN_OLD_KERNEL_IF_INSTALLED_NVIDIA_WARNING() {
    log_warn "If you are using an NVIDIA graphics card, you need to reinstall the NVIDIA driver after rebooting."
}

SUPER_CLEAN_OLD_KERNEL_DELETE_OLD_GRUB_INFO() {
    log_info "Updating boot configuration due to the presence of a new kernel..."
}

SUPER_CLEAN_OLD_KERNEL_END_INFO() {
    log_success "All operations have been completed!"
    log_success "It is recommended to reboot the system to apply the changes."
    log_success "If the system fails to boot, you can select the backup kernel version from the GRUB menu."
}

#end

#nvidia_driver_installer_part1.sh tips
NVIDIA_DRIVER_INSTALLER_PART_1_INFO() {
    echo "========================================"
    echo "       NVIDIA Driver Installer - Part 1     "
    echo "========================================"
}

NVIDIA_DRIVER_INSTALLER_PART_1_STEP_1_INFO() {
    echo " Step 1 - Install Required Packages "
}

NVIDIA_DRIVER_INSTALLER_PART_1_STEP_1_SUCCESS() {
    log_success " Required packages installed successfully "
}

NVIDIA_DRIVER_INSTALLER_PART_1_STEP_2_INFO() {
    echo " Step 2 - Disable Nouveau "
}

NVIDIA_DRIVER_INSTALLER_PART_1_STEP_2_SUCCESS() {
    log_success " Nouveau disabled successfully "
}

NVIDIA_DRIVER_INSTALLER_PART_1_END_INFO() {
    log_info " All steps in Part 1 are complete. "
    log_warn " The system will reboot in 10 seconds to apply changes. You can press Ctrl+C to cancel the reboot. "
}

NVIDIA_DRIVER_INSTALLER_PART_1_REBOOT_WARNING() {
    log_warn " The system will reboot in 10 seconds to apply changes. You can press Ctrl+C to cancel the reboot. "
}

NVIDIA_DRIVER_INSTALLER_PART_1_REBOOTING_INFO() {
    log_info " The system is rebooting..."
}
#end

#nvidia_driver_installer_part2.sh tips
NVIDIA_DRIVER_INSTALLER_PART_2_ENVIRONMENT_ERROR() {
    log_error " Please run this script in a non-graphical environment "
    log_warn " Please save all work and close all applications "
    log_warn " Press Enter to enter single-user mode, or press Ctrl+C to cancel "
}

NVIDIA_DRIVER_INSTALLER_PART_2_INFO() {
    echo "========================================"
    echo "       NVIDIA Driver Installer - Part 2  "
    echo "========================================"
    echo " Step 1 - Install Driver "
    log_info " Please enter the full path to the driver "
}

NVIDIA_DRIVER_INSTALLER_PART_2_PATH_ERROR() {
    log_error " Driver file not found! "
    log_error " Please check the path and try again. "
}

NVIDIA_DRIVER_INSTALLER_PART_2_PATH_SUCCESS() {
    log_success " Driver file found. "
}

NVIDIA_DRIVER_INSTALLER_PART_2_DRIVER_READY_INFO() {
    log_info " Driver is ready to install. "
}

NVIDIA_DRIVER_INSTALLER_PART_2_DRIVER_INSTALLING_WARNING() {
    log_warn " Driver installation will begin in 30 seconds. "
    log_warn " Please ensure all work is saved. "
    log_warn " select "yes" when prompted during installation. "
    log_warn " Press Enter to continue, or press Ctrl+C to cancel. "
}

NVIDIA_DRIVER_INSTALLER_PART_3_STEP_1_INFO() {
    echo "========================================"
    echo "       NVIDIA Driver Installer - Part 3  "
    echo "========================================"
    echo " Step 1 - Start Daemon "
}

NVIDIA_DRIVER_INSTALLER_PART_3_STEP_1_SUCCESS() {
    log_success " Services enabled successfully "
}

NVIDIA_DRIVER_INSTALLER_PART_3_STEP_2_INFO() {
    echo " Step 2 - Sign Kernel Modules "
}

NVIDIA_DRIVER_INSTALLER_PART_3_STEP_2_SUCCESS() {
    log_success " Kernel modules signed successfully "
}

NVIDIA_DRIVER_INSTALLER_PART_3_END_INFO() {
    log_success " All steps in Part 3 are complete, the system will reboot in 10 seconds. You can press Ctrl+C to cancel the reboot. "
}
#end