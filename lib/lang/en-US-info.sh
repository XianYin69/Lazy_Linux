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

