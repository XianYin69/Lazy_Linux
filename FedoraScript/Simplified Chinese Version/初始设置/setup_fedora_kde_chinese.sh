#!/bin/bash

# =================================================================================================
# 脚本名称：   setup_fedora_kde_chinese.sh
# 描述：       Fedora KDE Plasma 中文环境自动化配置脚本
#              完成以下配置任务：
#              1. 设置系统 locale 为简体中文 (zh_CN.UTF-8)
#              2. 安装 Fcitx5 输入法框架、中文引擎及优化字体
#              3. 配置全局输入法环境变量
#              4. 为 Flatpak 应用添加输入法支持
# 作者：       XianYin with AI toolkit
# 日期：       2025-08-19
# =================================================================================================

set -e  # 遇到错误立即退出

# --- 颜色常量定义 ---
readonly COLOR_INFO="\033[34m"      # 蓝色
readonly COLOR_SUCCESS="\033[32m"    # 绿色
readonly COLOR_ERROR="\033[31m"      # 红色
readonly COLOR_WARN="\033[33m"       # 黄色
readonly COLOR_RESET="\033[0m"       # 重置颜色

# --- 日志工具函数 ---
log_info() {
    echo -e "${COLOR_INFO}[信息]${COLOR_RESET} $1"
}

log_success() {
    echo -e "${COLOR_SUCCESS}[成功]${COLOR_RESET} $1"
}

log_error() {
    echo -e "${COLOR_ERROR}[错误]${COLOR_RESET} $1"
}

log_warn() {
    echo -e "${COLOR_WARN}[警告]${COLOR_RESET} $1"
}

# --- 常量定义 ---
readonly LOCALE_SETTING="zh_CN.UTF-8"
readonly REQUIRED_PACKAGES_FCITX5=(
    "fcitx5"
    "fcitx5-chinese-addons"
    "fcitx5-configtool"
    "fcitx5-qt"
    "fcitx5-gtk"
    "sarasa-fonts"
    "google-noto-cjk-fonts"
)
readonly REQUIRED_PACKAGES_IBUS=(
    "ibus"
    "ibus-pinyin"
    "ibus-rime"
    "rime-luna-pinyin"          
    "rime-terra-pinyin" 
    "rime-double-pinyin"         
    "rime-pinyin-simp"           
    "rime-cantonese"         
    "rime-cangjie"           
    "rime-quick"                
    "rime-stroke"           
    "rime-wubi"                
    "rime-wugniu"               
    "rime-bopomofoo"       
    "rime-emoji"             
    "rime-flypy"           
    "rime-ice-git"           
    "ibus-libpinyin"
    "ibus-gtk"
    "ibus-gtk3"
    "ibus-qt"
    "sarasa-fonts"
    "google-noto-cjk-fonts"
)

# --- 检查root权限 ---
if [[ $(id -u) -ne 0 ]]; then
    log_error "本脚本需要以 root 权限运行"
    log_error "请使用 sudo 运行: sudo $0"
    exit 1
fi

# --- 输入法选择函数 ---
select_input_method() {
    echo "请选择要安装的输入法框架："
    echo "1) Fcitx5 (默认，推荐)"
    echo "2) IBUS"
    read -p "请输入选项 [1-2]: " choice

    case "$choice" in
        2)
            INPUT_METHOD="IBUS"
            REQUIRED_PACKAGES=("${REQUIRED_PACKAGES_IBUS[@]}")
            ;;
        *|1)
            INPUT_METHOD="Fcitx5"
            REQUIRED_PACKAGES=("${REQUIRED_PACKAGES_FCITX5[@]}")
            ;;
    esac

    log_info "已选择 $INPUT_METHOD 输入法框架"
}

# 检测操作系统类型和包管理器
detect_os() {
    if [ -f "/etc/os-release" ]; then
        . /etc/os-release
        case "$ID" in
            "fedora")
                OS_TYPE="fedora"
                PACKAGE_MANAGER="dnf"
                ;;
            "ubuntu"|"debian")
                OS_TYPE="debian"
                PACKAGE_MANAGER="apt"
                ;;
            "arch"|"manjaro")
                OS_TYPE="arch"
                PACKAGE_MANAGER="pacman"
                ;;
            *)
                log_error "不支持的Linux发行版：$ID"
                exit 1
                ;;
        esac
        echo "$OS_TYPE"
    else
        log_error "无法检测操作系统类型"
        exit 1
    fi
}

# 安装软件包的通用函数
install_packages() {
    local packages=("$@")
    case "$PACKAGE_MANAGER" in
        "dnf")
            sudo dnf install -y "${packages[@]}" --skip-unavailable
            ;;
        "apt")
            sudo apt install -y "${packages[@]}"
            ;;
        "pacman")
            sudo pacman -S --noconfirm "${packages[@]}"
            ;;
        *)
            log_error "未知的包管理器：$PACKAGE_MANAGER"
            return 1
            ;;
    esac
    return $?
}

# --- 主程序函数 ---
main() {
    log_info "==================================================="
    log_info "    Linux 中文环境配置工具"
    log_info "==================================================="
    echo

    # 检测系统类型
    OS_TYPE=$(detect_os)
    log_info "检测到系统类型: $OS_TYPE"

    # 选择输入法
    select_input_method

    # 步骤1: 设置系统区域
    log_info "步骤 1/5: 设置系统区域为 ${LOCALE_SETTING}"
    if localectl set-locale LANG="${LOCALE_SETTING}"; then
        log_success "系统区域已设置为 ${LOCALE_SETTING}"
    else
        log_error "设置系统区域失败！"
        exit 1
    fi
    echo

    # 步骤2: 安装必要软件包
    log_info "步骤 2/5: 安装 ${INPUT_METHOD} 输入法及相关组件"
    log_info "将安装以下软件包："
    for package in "${REQUIRED_PACKAGES[@]}"; do
        log_info "- $package"
    done

    # 根据不同的系统安装语言包
    case "$OS_TYPE" in
        "fedora")
            EXTRA_PACKAGES=(
                "kde-l10n-Chinese"
                "glibc-langpack-zh"
                "langpacks-zh_CN"
            )
            ;;
        "ubuntu"|"debian")
            EXTRA_PACKAGES=(
                "language-pack-zh-hans"
                "language-pack-kde-zh-hans"
                "fonts-noto-cjk"
            )
            ;;
        "arch"|"manjaro")
            EXTRA_PACKAGES=(
                "adobe-source-han-sans-cn-fonts"
                "adobe-source-han-serif-cn-fonts"
                "wqy-microhei"
                "wqy-zenhei"
            )
            ;;
    esac

    # 安装所有软件包
    if install_packages "${REQUIRED_PACKAGES[@]}" "${EXTRA_PACKAGES[@]}"; then
        log_success "所有软件包均已成功安装"
    else
        log_error "软件包安装过程中出现错误"
        exit 1
    fi
    echo

    # 步骤3: 配置输入法环境
    readonly ENV_FILE="/etc/environment"
    
    # 根据选择的输入法设置环境变量
    if [ "$INPUT_METHOD" = "fcitx" ]; then
        readonly IM_CONFIG=(
            "export GTK_IM_MODULE=fcitx"
            "export QT_IM_MODULE=fcitx"
            "export XMODIFIERS=@im=fcitx"
            "export SDL_IM_MODULE=fcitx"
            "export GLFW_IM_MODULE=ibus"  # 为 GLFW 应用添加支持
            # Electron 应用支持
            "export XIM_PROGRAM=fcitx"
            "export XIM=fcitx"
            "export GTK_IM_MODULE_FILE=/usr/lib/gtk-3.0/3.0.0/immodules-fcitx.cache"
        )
    else
        readonly IM_CONFIG=(
            "export GTK_IM_MODULE=ibus"
            "export QT_IM_MODULE=ibus"
            "export XMODIFIERS=@im=ibus"
            "export SDL_IM_MODULE=ibus"
            "export GLFW_IM_MODULE=ibus"
            # Electron 应用支持
            "export XIM_PROGRAM=ibus-daemon"
            "export XIM=ibus"
            "export GTK_IM_MODULE_FILE=/usr/lib/gtk-3.0/3.0.0/immodules-ibus.cache"
        )
    fi

    log_info "步骤 3/5: 配置全局输入法环境变量"
    log_info "配置文件：${ENV_FILE}"

    # 创建环境文件备份
    if [ -f "${ENV_FILE}" ]; then
        cp "${ENV_FILE}" "${ENV_FILE}.bak.$(date +%s)" || log_warn "无法创建环境文件备份"
    fi

    # 为保证幂等性，先检查变量是否已存在
# 添加或更新环境变量
    local changes_made=0
    for config in "${IM_CONFIG[@]}"; do
        local var_name="${config%%=*}"
        if ! grep -q "^${var_name}=" "$ENV_FILE"; then
            echo "$config" >> "$ENV_FILE"
            log_info "[写入] $config"
            changes_made=1
        else
            log_info "[跳过] $var_name 已存在"
            # 检查值是否需要更新
            if ! grep -q "^$config\$" "$ENV_FILE"; then
                sed -i "s|^${var_name}=.*|$config|" "$ENV_FILE"
                log_info "[更新] $config"
                changes_made=1
            fi
        fi
    done

    if [ $changes_made -eq 1 ]; then
        log_success "环境变量配置已更新"
    else
        log_info "环境变量配置无需更改"
    fi

if ! grep -q "export XMODIFIERS=@im=fcitx" "$ENV_FILE"; then
    echo 'export XMODIFIERS=@im=fcitx' >> "$ENV_FILE"
    echo "    [写入] XMODIFIERS=@im=fcitx"
else
    echo "    [跳过] XMODIFIERS 已存在。"
fi
echo "    [成功] 环境变量配置完成。"
echo ""


# --- 步骤 4: 为 Flatpak 应用安装输入法支持 ---
echo "--> 步骤 4/5: 正在为 Flatpak 应用安装 Fcitx5 插件..."
# 检查 flatpak 是否存在
if command -v flatpak &> /dev/null; then
    flatpak install -y flathub org.freedesktop.Platform.Addons.Fcitx5
    if [ $? -eq 0 ]; then
        echo "    [成功] Flatpak Fcitx5 插件已安装。"
    else
        echo "    [警告] Flatpak Fcitx5 插件安装失败。如果您不使用 Flatpak 应用，可忽略此条。"
    fi
else
    echo "    [跳过] 系统未安装 Flatpak，无需配置。"
fi
echo ""


# --- 步骤 5: 完成与后续手动操作说明 ---
echo "--> 步骤 5/5: 自动化脚本执行完毕！"
echo ""
echo "========================== 重要：请手动完成以下步骤 =========================="
echo ""
echo -e "\033[1;31m1. 重启计算机\033[0m"
echo "   这是让所有设置（尤其是语言和环境变量）完全生效的最关键一步！"
echo "   请立即重启您的系统。"
echo ""
echo "2. 配置输入法"
echo "   重启后，在系统右下角托盘区找到键盘图标，右键点击它 -> 选择“配置”。"
echo "   a) 取消勾选左下角的“仅显示当前语言的输入法”。"
echo "   b) 在左侧列表中搜索“Pinyin”并选中，点击向右箭头将其添加到右侧的“当前输入法”列表中。"
echo "   c) 您可以按需添加其他输入法（如 Wubi 等）。"
echo "   d) 确保右侧列表中至少有一个“键盘”和一个中文输入法。"
echo ""
echo "3. 验证"
echo "   打开任意文本编辑器，按 Ctrl + Space 键，即可开始输入中文。"
echo ""
echo "=============================================================================="
echo ""
echo "祝您使用愉快！"

exit 0
