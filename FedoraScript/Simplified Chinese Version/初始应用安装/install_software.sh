#!/bin/bash
#
# 一个多功能软件安装脚本，可检测操作系统
# 并使用原生包管理器或 Snap 安装一系列软件。

set -e # 如果命令以非零状态退出，则立即退出。

# --- 配置 ---
# 需要安装的所有软件列表。
# 此处使用通用名称，稍后将映射到特定的软件包名称。
SOFTWARE_LIST=(
    "wine"
    "winetricks"
    "qemu"
    "krita"
    "steam"
    "gimp"
    "darktable"
    "kdenlive"
    "libreoffice"
    "gnome-boxes"
    "visual-studio-code"
    "android-studio"
    "vlc"
    "firefox"
    "kde-applications"
    "blender"
    "aline"
    "git"
)

# 对于这些软件，Snap 是首选或唯一的安装方式。
SNAP_PREFERRED_LIST=(
    #"wechat"
    #"dingtalk"
    "visual-studio-code"
    "android-studio"
    "cider"
)

# --- 日志记录工具 ---
log_info() {
    echo -e "\033[34m[信息]\033[0m $1"
}

log_success() {
    echo -e "\033[32m[成功]\033[0m $1"
}

log_error() {
    echo -e "\033[31m[错误]\033[0m $1"
}

log_warn() {
    echo -e "\033[33m[警告]\033[0m $1"
}

# --- 系统检测 ---
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

# --- 安装函数 ---

install_with_apt() {
    local pkg_name="$1"
    log_info "正在尝试使用 apt 安装 '$pkg_name'..."
    if sudo apt-get install --reinstall -y "$pkg_name"; then
        log_success "使用 apt 成功安装/重新安装 '$pkg_name'。"
        return 0
    else
        log_error "使用 apt 安装 '$pkg_name' 失败。"
        return 1
    fi
}

install_with_dnf() {
    local pkg_name="$1"
    log_info "正在尝试使用 dnf 安装 '$pkg_name'..."
    if sudo dnf install -y "$pkg_name" --skip-unavaliable; then
        log_success "使用 dnf 成功安装/重新安装 '$pkg_name'。"
        return 0
    else
        log_error "使用 dnf 安装 '$pkg_name' 失败。"
        return 1
    fi
}

install_with_pacman() {
    local pkg_name="$1"
    log_info "正在尝试使用 pacman 安装 '$pkg_name'..."
    # Pacman 的 -S 标志处理安装和重新安装
    if sudo pacman -S --noconfirm "$pkg_name"; then
        log_success "使用 pacman 成功安装/重新安装 '$pkg_name'。"
        return 0
    else
        log_error "使用 pacman 安装 '$pkg_name' 失败。"
        return 1
    fi
}

install_with_snap() {
    local pkg_name="$1"
    log_info "正在尝试使用 snap 安装 '$pkg_name'..."
    if sudo snap install "$pkg_name"; then
        log_success "使用 snap 成功安装 '$pkg_name'。"
        return 0
    else
        log_error "使用 snap 安装 '$pkg_name' 失败。"
        return 1
    fi
}

# --- 主要逻辑 ---

check_snapd() {
    log_info "正在检查 snapd 服务..."
    if ! command -v snap &> /dev/null; then
        log_warn "未找到 snap 命令。无法安装 Snap 软件包。"
        log_warn "请为您的发行版安装 snapd。"
        return 1
    fi
    if ! systemctl is-active --quiet snapd.service; then
        log_warn "snapd 服务未激活。正在尝试启动它..."
        sudo systemctl start snapd.service
        if ! systemctl is-active --quiet snapd.service; then
            log_error "启动 snapd 服务失败。无法安装 Snap 软件包。"
            return 1
        fi
    fi
    log_success "snapd 可用且正在运行。"
    return 0
}

# --- 主执行函数 ---
main() {
    log_info "启动多功能软件安装脚本。"
    
    PKG_MANAGER=$(detect_package_manager)
    if [[ "$PKG_MANAGER" == "unknown" ]]; then
        log_error "未找到支持的原生包管理器 (dnf, apt, pacman)。"
        log_info "将仅进行 Snap 安装。"
    else
        log_success "检测到包管理器: $PKG_MANAGER"
    fi

    check_snapd # 检查并警告 snapd 状态

    for software in "${SOFTWARE_LIST[@]}"; do
        echo "------------------------------------------------------"
        log_info "正在处理软件包: $software"

        is_snap_preferred=false
        for pref in "${SNAP_PREFERRED_LIST[@]}"; do
            [[ "$pref" == "$software" ]] && is_snap_preferred=true && break
        done

        # --- 将通用名称映射到特定的软件包名称 ---
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
                    "apt") native_pkg_name="kde-standard" ;; # kde-full 非常大
                    "dnf") native_pkg_name="@kde-apps" ;; # 这是一个组
                    "pacman") native_pkg_name="kde-applications" ;; # 这是一个组
                esac
                snap_pkg_name="" # 整个套件没有直接的 snap 等效项
                ;;
        esac

        # --- 安装逻辑 ---
        if $is_snap_preferred; then
            log_info "'$software' 是 Snap 首选软件包。"
            if [[ -n "$snap_pkg_name" ]] && install_with_snap "$snap_pkg_name"; then
                continue # 安装成功，继续下一个软件
            else
                log_warn "Snap 安装 '$snap_pkg_name' 失败。正在尝试回退到原生包管理器。"
                if [[ "$PKG_MANAGER" != "unknown" ]]; then
                    "install_with_$PKG_MANAGER" "$native_pkg_name"
                else
                    log_error "没有可用于 '$native_pkg_name' 的原生包管理器可回退。"
                fi
            fi
        else
            log_info "正在尝试为 '$software' 进行原生安装。"
            if [[ "$PKG_MANAGER" != "unknown" ]]; then
                if "install_with_$PKG_MANAGER" "$native_pkg_name"; then
                    continue # 安装成功
                else
                    log_warn "原生安装 '$native_pkg_name' 失败。正在尝试回退到 Snap。"
                    if [[ -n "$snap_pkg_name" ]]; then
                        install_with_snap "$snap_pkg_name"
                    else
                        log_error "没有为 '$software' 定义相应的 Snap 软件包。"
                    fi
                fi
            else
                log_warn "未检测到原生包管理器。正在尝试使用 Snap 安装 '$software'。"
                 if [[ -n "$snap_pkg_name" ]]; then
                    install_with_snap "$snap_pkg_name"
                else
                    log_error "没有为 '$software' 定义相应的 Snap 软件包，且没有可用的原生管理器。"
                fi
            fi
        fi
    done

    echo "------------------------------------------------------"
    log_success "软件安装脚本已完成。"
}

# 执行主函数
main
