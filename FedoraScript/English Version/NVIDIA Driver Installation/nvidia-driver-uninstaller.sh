#!/bin/bash

# =================================================================================================
# Script Name:  nvidia-driver-uninstaller.sh
# Description:  NVIDIA Driver Uninstallation Script
#              Completely removes NVIDIA driver and related components
# Author:       XianYin with AI toolkit
# Date:         2025-08-19
# =================================================================================================

set -e  # Exit immediately if a command exits with a non-zero status

# --- Color Constants Definition ---
readonly COLOR_INFO="\033[34m"      # Blue
readonly COLOR_SUCCESS="\033[32m"    # Green
readonly COLOR_ERROR="\033[31m"      # Red
readonly COLOR_WARN="\033[33m"       # Yellow
readonly COLOR_RESET="\033[0m"       # Reset color
readonly RED="\033[0;31m"            # Red (normal)
readonly NC="\033[0m"                # No Color

# --- Logging Utility Functions ---
log_info() {
    echo -e "${COLOR_INFO}[INFO]${COLOR_RESET} $1"
}

log_success() {
    echo -e "${COLOR_SUCCESS}[SUCCESS]${COLOR_RESET} $1"
}

log_error() {
    echo -e "${COLOR_ERROR}[ERROR]${COLOR_RESET} $1"
}

log_warn() {
    echo -e "${COLOR_WARN}[WARNING]${COLOR_RESET} $1"
}

# Ensure root privileges
if [[ $EUID -ne 0 ]]; then
    echo -e "${RED}This script must be run as root. Please use 'sudo bash $0'${NC}"
    exit 1
fi

# --- Main Function ---
main() {
    log_info "Starting NVIDIA driver uninstallation process..."

    # 1. Stop NVIDIA services
    log_info "Stopping NVIDIA services..."
    systemctl stop nvidia-persistenced 2>/dev/null || true

    # 2. Remove NVIDIA packages
    log_info "Removing NVIDIA packages..."
    dnf remove -y "nvidia-*" "cuda*" "akmod-nvidia" "dkms-nvidia" || true

    # 3. Remove NVIDIA files
    log_info "Removing NVIDIA configuration files..."
    rm -rf /etc/X11/xorg.conf
    rm -rf /etc/X11/xorg.conf.d/99-nvidia.conf
    rm -rf /etc/modprobe.d/nvidia.conf
    rm -rf /etc/modprobe.d/blacklist-nvidia-nouveau.conf
    rm -rf /usr/share/nvidia/
    rm -rf /usr/share/cuda/

    # 4. Remove kernel modules
    log_info "Removing NVIDIA kernel modules..."
    rm -rf /lib/modules/$(uname -r)/extra/nvidia
    rm -rf /lib/modules/$(uname -r)/weak-updates/nvidia

    # 5. Remove blacklist for nouveau
    log_info "Removing nouveau blacklist..."
    rm -f /etc/modprobe.d/blacklist-nouveau.conf

    # 6. Regenerate initramfs
    log_info "Regenerating initramfs..."
    dracut -f

    log_success "NVIDIA driver uninstallation completed."
    log_info "==================================================================="
    log_info "Please restart your system to complete the uninstallation process."
    log_info "After restart, the system will use the default video driver."
    log_info "==================================================================="
}

# Execute main function
main
