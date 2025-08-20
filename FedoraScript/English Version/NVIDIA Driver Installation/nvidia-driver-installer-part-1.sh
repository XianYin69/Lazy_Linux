#!/bin/bash

# =================================================================================================
# Script Name:  nvidia-driver-installer-part-1.sh
# Description:  NVIDIA Driver Installation Script - Part 1
#              Checks system requirements and prepares the environment
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

# --- Main Program ---
main() {
    # Check if running in terminal
    if [ -t 0 ]; then
        log_info "Running in terminal mode. Proceeding with installation..."
    else
        log_error "This script must be run in a terminal."
        exit 1
    fi

    # Check system requirements
    log_info "Checking system requirements..."
    
    # Check for NVIDIA GPU
    if ! lspci | grep -i nvidia > /dev/null; then
        log_error "No NVIDIA GPU detected in this system."
        exit 1
    else
        log_success "NVIDIA GPU detected."
    fi

    # Check for secure boot status
    if mokutil --sb-state | grep -q "enabled"; then
        log_warn "Secure Boot is enabled. This may cause issues with NVIDIA driver installation."
        log_warn "Consider disabling Secure Boot in BIOS settings."
        read -p "Do you want to continue anyway? (y/N): " choice
        if [[ ! "$choice" =~ ^[Yy]$ ]]; then
            log_info "Installation aborted by user."
            exit 0
        fi
    else
        log_success "Secure Boot is disabled. Proceeding with installation."
    fi

    # Backup existing configuration
    log_info "Backing up existing configuration..."
    if [ -f "/etc/X11/xorg.conf" ]; then
        cp /etc/X11/xorg.conf /etc/X11/xorg.conf.backup
        log_success "Backed up existing xorg.conf"
    fi

    # Remove conflicting packages
    log_info "Checking for conflicting packages..."
    local CONFLICT_PACKAGES=("nouveau" "xorg-x11-drv-nouveau")
    
    for pkg in "${CONFLICT_PACKAGES[@]}"; do
        if rpm -q "$pkg" &> /dev/null; then
            log_info "Removing conflicting package: $pkg"
            dnf remove -y "$pkg"
        fi
    done

    # Create blacklist for nouveau
    log_info "Creating nouveau blacklist..."
    cat > "/etc/modprobe.d/blacklist-nouveau.conf" << EOF
blacklist nouveau
options nouveau modeset=0
EOF
    
    # Update initramfs
    log_info "Updating initramfs..."
    dracut -f

    log_success "Part 1 of NVIDIA driver installation completed successfully."
    log_info "Please reboot your system before proceeding to Part 2."
    log_info "After reboot, run nvidia-driver-installer-part-2.sh"
}

# Execute main function
main
