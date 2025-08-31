#!/bin/bash

# =================================================================================================
# 脚本名称：   setup_git.sh
# 描述：       Git配置与仓库克隆工具
#              - 自动配置Git全局设置
#              - 设置GitHub用户信息
#              - 克隆指定的代码仓库
# 作者：       XianYin_69
# 参考来源：   none
# 日期：       2025-08-19
# =================================================================================================

set -e  # 遇到错误立即退出

# --- 日志工具函数 ---
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

# 检查git是否安装
if ! command -v git &> /dev/null; then
    log_error "Git未安装，请先安装Git"
    exit 1
fi

# --- 显示欢迎信息 ---
log_info "========================================="
log_info "        Git 配置与仓库克隆工具        "
log_info "========================================="
echo

# --- 提示用户输入信息 ---
log_info "此脚本将帮助您配置Git并克隆仓库。"
read -p "请输入您的GitHub用户名：" GITHUB_USERNAME
read -p "请输入您的GitHub邮箱：" GITHUB_EMAIL
read -p "请输入要克隆的GitHub仓库URL：" REPO_URL

# --- 配置Git ---
echo
log_info "正在配置Git凭据..."
git config --global user.name "$GITHUB_USERNAME"
git config --global user.email "$GITHUB_EMAIL"
log_success "Git用户名和邮箱已全局设置完成。"

# --- 克隆仓库 ---
echo
log_info "正在从 $REPO_URL 克隆仓库..."
if git clone "$REPO_URL"; then
    log_success "仓库克隆成功。"
else
    log_error "仓库克隆失败。请检查URL和您的权限。"
    exit 1
fi

echo
echo "========================================="
echo "       所有任务已完成！      "
echo "========================================="