#!/bin/bash

# =================================================================================================
# Script Name:  nvidia-driver-installer-part-3.sh
# Description:  NVIDIA Driver Installation Script - Part 3
#              Performs driver installation and initial configuration
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

echo -e "${YELLOW}-Installation will be performed in terminal mode with English interface-${NC}"

# --- Main Function ---
main() {
    # Check if X server is running
    if pgrep -x "Xorg" > /dev/null || pgrep -x "Xwayland" > /dev/null; then
        log_error "X server or Wayland is still running."
        log_error "Please switch to a terminal (Ctrl+Alt+F3) and run this script again."
        exit 1
    fi

    # Installation directory
    WORK_DIR="/opt/nvidia_installer"
    if [ ! -d "$WORK_DIR" ]; then
        log_error "Installation directory not found: $WORK_DIR"
        log_error "Please run Part 2 first."
        exit 1
    fi

    cd "$WORK_DIR"
    DRIVER_FILE=$(ls NVIDIA-Linux-x86_64-*.run 2>/dev/null | head -n 1)

    if [ -z "$DRIVER_FILE" ]; then
        log_error "No NVIDIA driver file found in $WORK_DIR"
        log_error "Please run Part 2 first to download the driver."
        exit 1
    fi

    log_info "Installing NVIDIA driver..."
    log_info "Driver file: $DRIVER_FILE"

    # Run the installer
    sh "$DRIVER_FILE" --accept-license \
                      --no-questions \
                      --ui=none \
                      --disable-nouveau \
                      --no-cc-version-check \
                      --silent

    if [ $? -eq 0 ]; then
        log_success "NVIDIA driver installation completed successfully."
        log_info "Proceed to Part 4 for final configuration."
    else
        log_error "NVIDIA driver installation failed."
        log_error "Please check the error messages above."
        exit 1
    fi
}

# Execute main function
main
