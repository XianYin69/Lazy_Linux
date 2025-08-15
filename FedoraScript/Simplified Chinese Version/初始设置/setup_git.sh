#!/bin/bash

# =================================================================================================
# 脚本名称：   setup_git.sh
# 描述：       此脚本用于自动配置Git并克隆仓库。
#              它会提示用户输入GitHub用户名、邮箱和仓库URL，
#              设置全局Git配置，并克隆指定的仓库。
# 作者：       Kilo Code
# 日期：       2025-08-10
# =================================================================================================

# --- 横幅 ---
echo "========================================="
echo "        Git 配置与仓库克隆工具        "
echo "========================================="
echo

# --- 提示用户输入信息 ---
echo "此脚本将帮助您配置Git并克隆仓库。"
read -p "请输入您的GitHub用户名：" GITHUB_USERNAME
read -p "请输入您的GitHub邮箱：" GITHUB_EMAIL
read -p "请输入要克隆的GitHub仓库URL：" REPO_URL

# --- 配置Git ---
echo
echo "正在配置Git凭据..."
git config --global user.name "$GITHUB_USERNAME"
git config --global user.email "$GITHUB_EMAIL"
echo " Git用户名和邮箱已全局设置完成。"

# --- 克隆仓库 ---
echo
echo "正在从 $REPO_URL 克隆仓库..."
if git clone "$REPO_URL"; then
    echo " 仓库克隆成功。"
else
    echo " 错误：仓库克隆失败。请检查URL和您的权限。" >&2
    exit 1
fi

echo
echo "========================================="
echo "       所有任务已完成！      "
echo "========================================="