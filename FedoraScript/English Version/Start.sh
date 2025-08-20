#!/bin/bash

# =================================================================================================
# Script Name:  Start.sh
# Description:  Shell Script Permission Initialization Tool
#               - Automatically grants executable permission to all .sh files in current directory
#               - Recursively processes all subdirectories
# Author:       XianYin with AI toolkit
# Date:         2025-08-20
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

# --- Main Function ---
main() {
    # Current script directory
    local SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
    
    log_info "Starting shell script permission initialization..."
    log_info "Working directory: $SCRIPT_DIR"

    # Process all .sh files recursively
    find "$SCRIPT_DIR" -type f -name "*.sh" -print0 | while IFS= read -r -d '' file; do
        if [ -w "$file" ]; then
            chmod +x "$file"
            log_success "Granted executable permission: $(basename "$file")"
        else
            log_error "Cannot modify permissions for: $(basename "$file") (write permission denied)"
        fi
    done

    log_success "Permission initialization completed."
}

# Execute main function
main
