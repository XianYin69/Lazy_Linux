#!/bin/bash

# =================================================================================================
# 脚本名称：   waydroid_installer_part2.sh
# 描述：       Waydroid(安卓模拟器)安装脚本 - 第2部分
#              完成Waydroid配置和初始化
# 作者：       XianYin_69
# 日期：       2025-08-19
# =================================================================================================

main() {
    #一些额外的配置
    WAYDROID_INSTALLER_PART_2_CONFIG_WAYDROID_INFO
    waydroid prop set persist.waydroid.multi_windows true
    waydroid prop set persist.waydroid.width "1366"
    waydroid prop set persist.waydroid.height "768"
    waydroid prop set persist.waydroid.cursor_on_subsurface true

    #克隆 Waydroid ARM 支持仓库
    clone_repo() {
        WAYDROID_INSTALLER_PART_2_FILES_STORE_INFO
        read -p "：" GIT_PATH
        cd "$GIT_PATH"
    }

    # 运行安装脚本
    run_python_script() {
        WAYDROID_INSTALLLER_PART_2_RUN_SCRIPT_INFO
        while true; do
            if [ -d waydroid_script ]; then
                    cd waydroid_script
                python3 -m venv venv
                ./venv/bin/pip install -r requirements.txt
                venv/bin/python3 main.py
                sudo venv/bin/python3 main.py install libhoudini
                sudo systemctl restart waydroid-container
                WAYDROID_INSTALLLER_PART_2_RUN_SCRIPT_SUCCESS
                break
            else
                git clone https://github.com/casualsnek/waydroid_script
                if [[ $? -ne 0 ]]; then
                    WAYDROID_INSTALLLER_PART_2_RUN_SCRIPT_ERROR
                    exit 1
                fi
            fi
        done
    }

    #git
    if ! command -v git &> /dev/null; then
        case $OS_TYPE in
        debian)
            apt install git lzip -y
        ;;
        fedora)
            dnf install git lzip -y
        ;;
        arch)
            pacman -S git lzip --noconfirm
        ;;
        esac
    else
        clone_repo
        run_python_script
    fi

    WAYDROID_INSTALLER_PART_2_END_INFO
}