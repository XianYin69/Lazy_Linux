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