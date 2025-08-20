#!/bin/bash

# =================================================================================================
# Script Name:  nvidia-driver-installer-part-4.sh
# Description:  NVIDIA Driver Installation Script - Part 4
#              Performs final configuration and verification
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
readonly YELLOW="\033[1;33m"         # Yellow (bold)
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

echo -e "\n${YELLOW}-Final configuration and verification process-${NC}"

# --- Main Function ---
main() {
    log_info "Starting final configuration..."

    # Generate Xorg configuration
    log_info "Generating Xorg configuration..."
    nvidia-xconfig --no-logo

    # Enable services
    log_info "Enabling NVIDIA services..."
    systemctl enable nvidia-persistenced.service

    # Verify installation
    log_info "Verifying NVIDIA driver installation..."
    
    if command -v nvidia-smi &> /dev/null; then
        DRIVER_VERSION=$(nvidia-smi --query-gpu=driver_version --format=csv,noheader)
        log_success "NVIDIA driver version $DRIVER_VERSION is installed and working."
    else
        log_error "NVIDIA driver verification failed."
        log_error "Please check the installation logs for errors."
        exit 1
    fi

    # Cleanup
    log_info "Cleaning up installation files..."
    rm -rf /opt/nvidia_installer

    log_success "NVIDIA driver installation and configuration completed successfully!"
    echo
    log_info "==================================================================="
    log_info "Installation completed. Please restart your system."
    log_info "After restart, you can verify the installation by running:"
    log_info "  nvidia-smi"
    log_info "  nvidia-settings"
    log_info "==================================================================="
}

# Execute main function
main
