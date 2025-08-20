#!/bin/bash
#
# A versatile software installation script that detects the operating system
# and installs a series of software using native package manager or Snap.

set -e # Exit immediately if a command exits with a non-zero status.

# --- Configuration ---
# Load software list from configuration file
CONFIG_FILE="$(dirname "$0")/software_list.txt"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file not found: $CONFIG_FILE"
    exit 1
fi

# Load software list
source "$CONFIG_FILE"

# --- Color Constants Definition ---
readonly COLOR_INFO="\033[34m"      # Blue
readonly COLOR_SUCCESS="\033[32m"    # Green
readonly COLOR_ERROR="\033[31m"      # Red
readonly COLOR_WARN="\033[33m"       # Yellow
readonly COLOR_RESET="\033[0m"       # Reset Color

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

# --- System Detection ---
detect_package_manager() {
    if command -v dnf &> /dev/null; then
        echo "dnf"
    elif command -v apt-get &> /dev/null; then
        echo "apt"
    elif command -v pacman &> /dev/null; then
        echo "pacman"
    else
        echo "unknown"
    fi
}

# --- Installation Functions ---

install_with_apt() {
    local pkg_name="$1"
    log_info "Attempting to install '$pkg_name' using apt..."
    if sudo apt-get install --reinstall -y "$pkg_name"; then
        log_success "Successfully installed/reinstalled '$pkg_name' using apt."
        return 0
    else
        log_error "Failed to install '$pkg_name' using apt."
        return 1
    fi
}

install_with_dnf() {
    local pkg_name="$1"
    log_info "Attempting to install '$pkg_name' using dnf..."
    if sudo dnf install -y "$pkg_name" --skip-unavaliable; then
        log_success "Successfully installed/reinstalled '$pkg_name' using dnf."
        return 0
    else
        log_error "Failed to install '$pkg_name' using dnf."
        return 1
    fi
}

install_with_pacman() {
    local pkg_name="$1"
    log_info "Attempting to install '$pkg_name' using pacman..."
    # The -S flag in Pacman handles both installation and reinstallation
    if sudo pacman -S --noconfirm "$pkg_name"; then
        log_success "Successfully installed/reinstalled '$pkg_name' using pacman."
        return 0
    else
        log_error "Failed to install '$pkg_name' using pacman."
        return 1
    fi
}

install_with_snap() {
    local pkg_name="$1"
    log_info "Attempting to install '$pkg_name' using snap..."
    if sudo snap install "$pkg_name"; then
        log_success "Successfully installed '$pkg_name' using snap."
        return 0
    else
        log_error "Failed to install '$pkg_name' using snap."
        return 1
    fi
}

# --- Main Logic ---

check_snapd() {
    log_info "Checking snapd service..."
    if ! command -v snap &> /dev/null; then
        log_warn "snap command not found. Cannot install Snap packages."
        log_warn "Please install snapd for your distribution."
        return 1
    fi
    if ! systemctl is-active --quiet snapd.service; then
        log_warn "snapd service is not active. Attempting to start it..."
        sudo systemctl start snapd.service
        if ! systemctl is-active --quiet snapd.service; then
            log_error "Failed to start snapd service. Cannot install Snap packages."
            return 1
        fi
    fi
    log_success "snapd is available and running."
    return 0
}

# --- Main Execution Function ---
main() {
    log_info "Starting versatile software installation script."
    
    PKG_MANAGER=$(detect_package_manager)
    if [[ "$PKG_MANAGER" == "unknown" ]]; then
        log_error "No supported native package manager found (dnf, apt, pacman)."
        log_info "Will proceed with Snap installation only."
    else
        log_success "Detected package manager: $PKG_MANAGER"
    fi

    check_snapd # Check and warn about snapd status

    for software in "${SOFTWARE_LIST[@]}"; do
        echo "------------------------------------------------------"
        log_info "Processing package: $software"

        is_snap_preferred=false
        for pref in "${SNAP_PREFERRED_LIST[@]}"; do
            [[ "$pref" == "$software" ]] && is_snap_preferred=true && break
        done

        # --- Map generic names to specific package names ---
        native_pkg_name="$software"
        snap_pkg_name="$software"

        case "$software" in
            "gnome-boxes")
                snap_pkg_name="boxes"
                ;;
            "visual-studio-code")
                snap_pkg_name="code"
                [[ "$PKG_MANAGER" == "pacman" ]] && native_pkg_name="code"
                ;;
            "kde-applications")
                case "$PKG_MANAGER" in
                    "apt") native_pkg_name="kde-standard" ;; # kde-full is very large
                    "dnf") native_pkg_name="@kde-apps" ;; # This is a group
                    "pacman") native_pkg_name="kde-applications" ;; # This is a group
                esac
                snap_pkg_name="" # No direct snap equivalent for the entire suite
                ;;
        esac

        # --- Installation Logic ---
        if $is_snap_preferred; then
            log_info "'$software' is a Snap-preferred package."
            if [[ -n "$snap_pkg_name" ]] && install_with_snap "$snap_pkg_name"; then
                continue # Installation successful, continue to next software
            else
                log_warn "Snap installation of '$snap_pkg_name' failed. Falling back to native package manager."
                if [[ "$PKG_MANAGER" != "unknown" ]]; then
                    "install_with_$PKG_MANAGER" "$native_pkg_name"
                else
                    log_error "No native package manager available to fall back for '$native_pkg_name'."
                fi
            fi
        else
            log_info "Attempting native installation for '$software'."
            if [[ "$PKG_MANAGER" != "unknown" ]]; then
                if "install_with_$PKG_MANAGER" "$native_pkg_name"; then
                    continue # Installation successful
                else
                    log_warn "Native installation of '$native_pkg_name' failed. Falling back to Snap."
                    if [[ -n "$snap_pkg_name" ]]; then
                        install_with_snap "$snap_pkg_name"
                    else
                        log_error "No Snap package defined for '$software'."
                    fi
                fi
            else
                log_warn "No native package manager detected. Attempting Snap installation for '$software'."
                 if [[ -n "$snap_pkg_name" ]]; then
                    install_with_snap "$snap_pkg_name"
                else
                    log_error "No Snap package defined for '$software' and no native manager available."
                fi
            fi
        fi
    done

    echo "------------------------------------------------------"
    log_success "Software installation script completed."
}

# Execute main function
main
