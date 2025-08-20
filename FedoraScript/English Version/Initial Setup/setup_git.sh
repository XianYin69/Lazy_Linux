#!/bin/bash

# =================================================================================================
# Script Name:  setup_git.sh
# Description:  Git Configuration and Repository Setup Tool
#              - Configures global Git credentials
#              - Optionally clones a specified repository
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

# --- Main Function ---
main() {
    # Get Git user information
    read -p "Enter your Git username: " GIT_USERNAME
    read -p "Enter your Git email: " GIT_EMAIL
    
    # Optional repository URL
    read -p "Enter repository URL to clone (press Enter to skip): " REPO_URL

    log_info "Configuring Git credentials..."
    git config --global user.name "$GIT_USERNAME"
    git config --global user.email "$GIT_EMAIL"
    log_success "Git username and email have been set globally."

    # Clone repository if URL provided
    if [ -n "$REPO_URL" ]; then
        log_info "Cloning repository from $REPO_URL..."
        if git clone "$REPO_URL"; then
            log_success "Repository cloned successfully."
        else
            log_error "Failed to clone repository. Please check the URL and your permissions."
            exit 1
        fi
    fi

    echo "========================================="
    log_success "All tasks completed successfully!"
}

# Execute main function
main
