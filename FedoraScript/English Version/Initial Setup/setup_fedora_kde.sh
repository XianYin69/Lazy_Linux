#!/bin/bash

# =================================================================================================
# Script Name:  setup_fedora_kde.sh
# Description:  Fedora KDE Plasma Environment Configuration Script
#              Completes the following configuration tasks:
#              1. Sets system locale (customizable)
#              2. Installs Fcitx5 input method framework and optimized fonts
#              3. Configures global input method environment variables
#              4. Adds input method support for Flatpak applications
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

# --- Constants Definition ---
readonly LOCALE_SETTING="zh_CN.UTF-8"  # Change this for different locales
readonly REQUIRED_PACKAGES=(
    "fcitx5"
    "fcitx5-chinese-addons"
    "fcitx5-configtool"
    "fcitx5-qt"
    "fcitx5-gtk"
    "sarasa-fonts"
    "google-noto-cjk-fonts"
)

# --- Check root privileges ---
if [[ $(id -u) -ne 0 ]]; then
    log_error "This script requires root privileges"
    log_error "Please run with sudo: sudo $0"
    exit 1
fi

# --- Main Program Functions ---
main() {
    log_info "==================================================="
    log_info "    Fedora KDE Plasma Environment Configuration Tool"
    log_info "==================================================="
    echo

    # Step 1: Set system locale
    log_info "Step 1/5: Setting system locale to ${LOCALE_SETTING}"
    if localectl set-locale LANG="${LOCALE_SETTING}"; then
        log_success "System locale has been set to ${LOCALE_SETTING}"
    else
        log_error "Failed to set system locale!"
        exit 1
    fi
    echo

    # Step 2: Install required packages
    log_info "Step 2/5: Installing Fcitx5 and related components"
    log_info "The following packages will be installed:"
    for package in "${REQUIRED_PACKAGES[@]}"; do
        log_info "- $package"
    done
    # Install packages
    if dnf install -y "${REQUIRED_PACKAGES[@]}" \
        kde-l10n-Chinese \
        glibc-langpack-zh \
        langpacks-zh_CN \
        --skip-unavailable; then
        log_success "All packages have been successfully installed"
    else
        log_error "Error occurred during package installation"
        exit 1
    fi
    echo

    # Step 3: Configure input method environment
    readonly ENV_FILE="/etc/environment"
    readonly IM_CONFIG=(
        "export GTK_IM_MODULE=fcitx"
        "export QT_IM_MODULE=fcitx"
        "XMODIFIERS=@im=fcitx"
        "export SDL_IM_MODULE=fcitx"
    )

    log_info "Step 3/5: Configuring global input method environment variables"
    log_info "Configuration file: ${ENV_FILE}"

    # Check environment configuration
    for config in "${IM_CONFIG[@]}"; do
        if ! grep -q "^${config}" "$ENV_FILE"; then
            echo "$config" >> "$ENV_FILE"
            log_success "Added: $config"
        else
            log_info "Skipped: $config (already exists)"
        fi
    done

    # Step 4: Configure Flatpak support
    log_info "Step 4/5: Setting up Fcitx5 for Flatpak applications..."
    
    if command -v flatpak &> /dev/null; then
        if sudo flatpak install -y org.fcitx.Fcitx5; then
            log_success "Flatpak Fcitx5 plugin installed successfully."
        else
            log_warn "Failed to install Flatpak Fcitx5 plugin. If you don't use Flatpak apps, you can ignore this."
        fi
    else
        log_info "Skipped: Flatpak is not installed on the system."
    fi
    echo

    # Final step: Display completion message
    log_info "Step 5/5: Automatic configuration completed!"
    echo
    echo "========================== Important: Manual Steps Required =========================="
    echo
    echo -e "\033[1;31m1. Restart Your Computer\033[0m"
    echo "   This is crucial for all settings (especially language and environment variables) to take effect!"
    echo "   Please restart your system immediately."
    echo
    echo "2. Configure Input Method"
    echo "   After restart, find the keyboard icon in the system tray, right-click and select 'Configure'."
    echo "   a) Uncheck 'Only Show Current Language' in the bottom left."
    echo "   b) Add your preferred input methods."
    echo "   c) Configure keyboard shortcuts if needed."
    echo
    echo "3. Test Input Method"
    echo "   Open any text editor and test if the input method works properly."
    echo "   If you encounter any issues, check the system tray for the Fcitx5 icon status."
    echo
    echo "========================== Configuration Complete =========================="
}

# Execute main function
main
