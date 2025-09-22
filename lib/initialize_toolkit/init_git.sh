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

source "../../var/state/STATE.sh"
source "../../var/index/filepath.sh"
 

# 定义变量
INIT_GIT_RETRY=N

# 安装函数
git_installer() {
    case $OS_TYPE in
        "debian"|"ubuntu"|"linuxmint"|"popos"|"kali"|"deepin")
            sudo apt update
            sudo apt install -y git
            ;;
        "fedora"|"centos"|"rhel")
            sudo dnf install -y git
            ;;
        "arch"|"manjaro"|"endeavouros")
            sudo pacman -Syu --noconfirm git
            ;;
        "opensuse")
            sudo zypper install -y git
            ;;
        *)
            INIT_GIT_GIT_INSTALL_ERROR
            sleep 5
            exit 1
            ;;
    esac
}

# 检查git是否安装
check_git() {
    if ! command -v git &> /dev/null; then
        INIT_GIT_GIT_ERROR
        git_installer
    fi
}

# --- 提示用户输入信息 ---
config_infomation_of_git() {
    INIT_GIT_INIT_INFO
    while :
    do
        INIT_GIT_INIT_USERNAME_INFO
        read -p "：" GITHUB_USERNAME
        if [ -z "$GITHUB_USERNAME" ]; then
            INIT_GIT_USERNAME_ERROR
        else
            break
        fi
    done

    while :
    do
        INIT_GIT_INIT_EMAIL_INFO
        read -p "：" GITHUB_EMAIL
        if [ -z "$GITHUB_EMAIL" ]; then
            INIT_GIT_EMAIL_ERROR
        else
            break
        fi
    done

    while :
    do
        INIT_GIT_URL_INFO
        read -p "：" REPO_URL
        if [ -z "$REPO_URL" ]; then
            INIT_GIT_URL_ERROR
        else
            break
        fi
    done
}

# --- 配置Git ---
configure_git() {
    INIT_GIT_CONFIG_INFO
    git config --global user.name "$GITHUB_USERNAME"
    git config --global user.email "$GITHUB_EMAIL"
    INIT_GIT_CONFIG_SUCCESS
}

# --- 克隆仓库 ---
clone_respository() {
    INIT_GIT_CLONE_INFO
    if git clone "$REPO_URL"; then
        INIT_GIT_CLONE_SUCCESS
        INIT_GIT_RETRY=N
    else
        INIT_GIT_CLONE_ERROR
        INIT_GIT_RETRY=Y
    fi
}

#主函数
check_git
INIT_GIT_WELCOME_INFO
config_infomation_of_git
configure_git
while :
do
    clone_respository
    if [ "$INIT_GIT_RETRY" = "N" ]; then
        break
    fi
done