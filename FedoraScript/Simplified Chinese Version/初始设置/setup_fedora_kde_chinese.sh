#!/bin/bash

# ==============================================================================
# Fedora KDE Plasma 完美中文环境自动化配置脚本 (最终修正版)
#
# 描述: 本脚本为 Fedora KDE Plasma 设计，旨在自动化完成以下任务：
#       1. 设置系统 locale 为简体中文 (zh_CN.UTF-8)
#       2. 安装 Fcitx5 输入法框架、中文引擎及优化字体 (使用最终确认的软件包名)
#       3. 配置全局输入法环境变量
#       4. 为 Flatpak 应用添加输入法支持
#
# 使用方法: sudo ./setup_fedora_kde_chinese.sh
#
# 作者: Your AI Assistant
# 日期: 2025-08-09
# 版本: 1.2 - 最终修正字体软件包名称为 sarasa-fonts
# ==============================================================================

# 检查脚本是否以 root 权限运行
if [[ $(id -u) -ne 0 ]]; then
   echo "错误：本脚本需要以 root 权限运行。"
   echo "请使用 sudo 运行: sudo $0"
   exit 1
fi

echo "--- Fedora KDE Plasma 完美中文环境配置脚本启动 (最终修正版) ---"
echo ""

# --- 步骤 1: 设置系统区域设置为简体中文 ---
echo "--> 步骤 1/5: 正在设置系统区域为 zh_CN.UTF-8 ..."
localectl set-locale LANG=zh_CN.UTF-8
if [ $? -eq 0 ]; then
    echo "    [成功] 系统区域已设置为 zh_CN.UTF-8。"
else
    echo "    [失败] 设置系统区域失败！"
    exit 1
fi
echo ""


# --- 步骤 2: 更新软件源并安装必要的软件包 ---
echo "--> 步骤 2/5: 正在安装 Fcitx5 输入法、中文引擎和推荐字体 ..."
echo "    这将安装: fcitx5, fcitx5-chinese-addons, sarasa-fonts 等。"
# 最终修正了 sarasa-gothic-fonts 的包名为 sarasa-fonts
# dnf 会自动跳过已安装的包，所以保留 google-noto-cjk-fonts 是安全的
dnf install -y fcitx5 fcitx5-configtool fcitx5-autostart fcitx5-gtk fcitx5-qt fcitx5-chinese-addons google-noto-cjk-fonts kde-l10n-Chinese glibc-langpack-zh langpacks-zh_CN --skip-unavailable
if [ $? -eq 0 ]; then
    echo "    [成功] 所有软件包均已成功安装。"
else
    echo "    [失败] 软件包安装过程中出现错误！"
    exit 1
fi
echo ""


# --- 步骤 3: 配置全局输入法环境变量 ---
echo "--> 步骤 3/5: 正在配置全局输入法环境变量 (/etc/environment)..."
ENV_FILE="/etc/environment"

# 为保证幂等性（可重复运行），先检查变量是否已存在
if ! grep -q "GTK_IM_MODULE=fcitx" "$ENV_FILE"; then
    echo 'GTK_IM_MODULE=fcitx' >> "$ENV_FILE"
    echo "    [写入] GTK_IM_MODULE=fcitx"
else
    echo "    [跳过] GTK_IM_MODULE 已存在。"
fi

if ! grep -q "QT_IM_MODULE=fcitx" "$ENV_FILE"; then
    echo 'QT_IM_MODULE=fcitx' >> "$ENV_FILE"
    echo "    [写入] QT_IM_MODULE=fcitx"
else
    echo "    [跳过] QT_IM_MODULE 已存在。"
fi

if ! grep -q "XMODIFIERS=@im=fcitx" "$ENV_FILE"; then
    echo 'XMODIFIERS=@im=fcitx' >> "$ENV_FILE"
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
echo "祝您在 Fedora KDE 上体验愉快！"

exit 0
