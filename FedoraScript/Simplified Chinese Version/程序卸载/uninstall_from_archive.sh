#!/bin/bash

# 定义颜色代码
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检测Linux发行版
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
else
    echo -e "${RED}错误:${NC} 无法检测Linux发行版"
    exit 1
fi

# 提示用户输入要卸载的程序名
echo -e "${YELLOW}请输入要卸载的程序名称：${NC}"
read -e PROGRAM_NAME

# 如果用户输入为空，退出脚本
if [ -z "$PROGRAM_NAME" ]; then
    echo -e "${RED}错误:${NC} 未输入程序名称"
    exit 1
fi

# 查找可能的安装位置
INSTALL_LOCATIONS=(
    "/usr/local/bin/$PROGRAM_NAME"
    "/usr/bin/$PROGRAM_NAME"
    "$HOME/bin/$PROGRAM_NAME"
)

PROGRAM_FOUND=false
PROGRAM_PATH=""

# 检查程序是否存在
for loc in "${INSTALL_LOCATIONS[@]}"; do
    if [ -f "$loc" ]; then
        PROGRAM_FOUND=true
        PROGRAM_PATH="$loc"
        break
    fi
done

if [ "$PROGRAM_FOUND" = false ]; then
    echo -e "${RED}错误:${NC} 未找到程序 '${YELLOW}$PROGRAM_NAME${NC}'"
    exit 1
fi

echo -e "${GREEN}[✓]${NC} 找到程序: ${BLUE}$PROGRAM_PATH${NC}"

# 获取程序的依赖库列表
echo -e "${YELLOW}[*]${NC} 分析程序依赖..."
LIBS=()
while IFS= read -r line; do
    if [[ $line =~ .+\ =\>\ /(.+) ]]; then
        lib_path="${BASH_REMATCH[1]}"
        if [[ $lib_path == usr/local/lib* ]]; then
            LIBS+=("/$lib_path")
        elif [[ $lib_path == home* ]]; then
            LIBS+=("/$lib_path")
        fi
    fi
done < <(ldd "$PROGRAM_PATH" 2>/dev/null)

# 确认卸载
echo -e "\n${YELLOW}将卸载以下内容：${NC}"
echo -e "程序: ${BLUE}$PROGRAM_PATH${NC}"
if [ ${#LIBS[@]} -gt 0 ]; then
    echo -e "相关库文件:"
    printf "  ${BLUE}%s${NC}\n" "${LIBS[@]}"
fi

read -p "确定要卸载吗？[y/N] " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${YELLOW}取消卸载${NC}"
    exit 1
fi

# 卸载程序
echo -e "${YELLOW}[*]${NC} 卸载程序..."

# 删除主程序
if [[ $PROGRAM_PATH == /usr/* ]]; then
    sudo rm -f "$PROGRAM_PATH"
else
    rm -f "$PROGRAM_PATH"
fi

# 删除库文件
if [ ${#LIBS[@]} -gt 0 ]; then
    echo -e "${YELLOW}[*]${NC} 删除相关库文件..."
    for lib in "${LIBS[@]}"; do
        if [[ $lib == /usr/* ]]; then
            sudo rm -f "$lib"
        else
            rm -f "$lib"
        fi
    done
fi

# 更新系统库缓存
if [[ $PROGRAM_PATH == /usr/* ]]; then
    echo -e "${YELLOW}[*]${NC} 更新系统库缓存..."
    sudo ldconfig
fi

# 清理包管理器缓存（如果有）
echo -e "${YELLOW}[*]${NC} 清理系统缓存..."
case $DISTRO in
    "ubuntu"|"debian")
        if [ -f /var/lib/dpkg/info/${PROGRAM_NAME}.list ]; then
            sudo dpkg --purge "$PROGRAM_NAME" 2>/dev/null
        fi
        ;;
    "fedora"|"centos"|"rhel")
        if rpm -q "$PROGRAM_NAME" &>/dev/null; then
            sudo rpm -e "$PROGRAM_NAME" 2>/dev/null
        fi
        ;;
    "opensuse"|"suse")
        if rpm -q "$PROGRAM_NAME" &>/dev/null; then
            sudo zypper remove -y "$PROGRAM_NAME" 2>/dev/null
        fi
        ;;
    "arch")
        if pacman -Q "$PROGRAM_NAME" &>/dev/null; then
            sudo pacman -R --noconfirm "$PROGRAM_NAME" 2>/dev/null
        fi
        ;;
esac

# 清理用户配置（可选）
if [ -d "$HOME/.config/$PROGRAM_NAME" ]; then
    echo -e "\n${YELLOW}发现用户配置文件：${NC}"
    echo -e "${BLUE}$HOME/.config/$PROGRAM_NAME${NC}"
    read -p "是否也删除配置文件？[y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$HOME/.config/$PROGRAM_NAME"
        echo -e "${GREEN}[✓]${NC} 已删除配置文件"
    fi
fi

# 清理用户缓存（可选）
if [ -d "$HOME/.cache/$PROGRAM_NAME" ]; then
    echo -e "\n${YELLOW}发现缓存文件：${NC}"
    echo -e "${BLUE}$HOME/.cache/$PROGRAM_NAME${NC}"
    read -p "是否也删除缓存文件？[y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf "$HOME/.cache/$PROGRAM_NAME"
        echo -e "${GREEN}[✓]${NC} 已删除缓存文件"
    fi
fi

echo -e "\n${GREEN}[✓]${NC} 卸载完成！"
