#!/bin/bash

# =================================================================================================
# Script Name:  Begin.sh
# Description:  NVIDIA Driver Installation Start Script
# Reference:    https://www.if-not-true-then-false.com
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
    local SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
    local INSTALLER_SCRIPTS=(
        "nvidia-driver-installer-part-1.sh"
        "nvidia-driver-installer-part-2.sh"
        "nvidia-driver-installer-part-3.sh"
        "nvidia-driver-installer-part-4.sh"
    )

    log_info "Starting NVIDIA driver installation process..."
    
    # Check root privileges
    if [[ $EUID -ne 0 ]]; then
        log_error "This script must be run as root"
        log_error "Please use: sudo $0"
        exit 1
    fi

    # Execute installation scripts in sequence
    for script in "${INSTALLER_SCRIPTS[@]}"; do
        local script_path="$SCRIPT_DIR/$script"
        
        if [ -f "$script_path" ]; then
            log_info "Executing $script..."
            if bash "$script_path"; then
                log_success "$script completed successfully"
            else
                log_error "$script failed"
                exit 1
            fi
        else
            log_error "Required script not found: $script"
            exit 1
        fi
    done

    log_success "NVIDIA driver installation process completed"
    log_info "Please reboot your system to apply the changes"
}

# Execute main function
main
