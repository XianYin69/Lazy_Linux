#!/bin/bash

# =================================================================================================
# Script Name:  nvidia-driver-installer-part-2.sh
# Description:  NVIDIA Driver Installation Script - Part 2
#              Performs system configuration and driver preparation
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

# Check root privileges
if [[ $EUID -ne 0 ]]; then
    log_error "This script must be run as root"
    log_error "Please use: sudo $0"
    exit 1
fi

# --- Main Function ---
main() {
    log_info "Starting NVIDIA driver preparation - Part 2"

    # Install required dependencies
    log_info "Installing required dependencies..."
    dnf install -y kernel-devel kernel-headers gcc make dkms acpid libglvnd-glx \
        libglvnd-opengl libglvnd-devel pkgconfig

    # Ensure working directory exists
    WORK_DIR="/opt/nvidia_installer"
    mkdir -p "$WORK_DIR"
    cd "$WORK_DIR"

    # Download latest driver
    log_info "Detecting latest NVIDIA driver version..."
    DRIVER_VERSION=$(curl -s https://download.nvidia.com/XFree86/Linux-x86_64/latest.txt | cut -d' ' -f1)
    DRIVER_FILE="NVIDIA-Linux-x86_64-${DRIVER_VERSION}.run"
    
    if [ ! -f "$DRIVER_FILE" ]; then
        log_info "Downloading NVIDIA driver version ${DRIVER_VERSION}..."
        wget "https://download.nvidia.com/XFree86/Linux-x86_64/${DRIVER_VERSION}/${DRIVER_FILE}"
    else
        log_info "Driver file already exists, skipping download."
    fi

    # Make driver executable
    chmod +x "$DRIVER_FILE"

    log_success "Part 2 of NVIDIA driver installation completed successfully."
    log_info "Proceed to Part 3 for the actual driver installation."
}

# Execute main function
main
