#!/bin/bash
# =================================================================================================
# 脚本名称：   Chinese.sh
# 描述：       A Chinesization script 
# 作者：       XianYin_69
# 参考来源：   
# 日期：       9-2-2025
# =================================================================================================
 
main() {
    #输入法
    ##输入法选择
    input_method_selection() {
        while :
        do
            CHINESIZATION_INPUT_METHOD_INFO
            read -p ":" input_method_choice
            if [ "$input_method_choice" == "1" ]; then
                INPUT_METHOD="fcitx5"
                CHINESIZATION_INPUT_METHOD_FCITX_5_SELECT_INFO
                break
            elif [ "$input_method_choice" == "2" ]; then
                INPUT_METHOD="ibus"
                CHINESIZATION_INPUT_METHOD_IBUS_SELECT_INFO
                break
            else
                CHINESIZATION_INPUT_METHOD_CHOICE_ERROR
            fi
        done
    }
    ##输入法配置
    environment_init() {
        local DE
        local choice
        while :
        do
            CHINESIZATION_ENVIRONMENT_INIT_INFO
            read -p ":" choice
            if [[ "$choice" -eq 1 ]]; then
                if [ "$INPUT_METHOD" == "fcitx5" ]; then
                    CHINESIZATION_ADD_PROFILE_FCITX_5_INFO
                    #设置环境变量
                    sudo echo "XMODIFIERS=@im=fcitx5" >> /etc/environment
                    sudo echo "GTK_IM_MODULE=fcitx5" >> /etc/environment
                    sudo echo "QT_IM_MODULE=fcitx5" >> /etc/environment
                    sudo echo "SDL_IM_MODULE=fcitx5" >> /etc/environment
                    sudo echo "GLFW_IM_MODULE=ibus" >> /etc/environment
                    source /etc/profile.d/fcitx5.sh
                    CHINESIZATION_ADD_PROFILE_FCITX_5_SUCCESS
                elif [ "$INPUT_METHOD" == "ibus" ]; then
                    CHINESIZATION_ADD_PROFILE_IBUS_INFO
                    #设置环境变量
                    sudo echo "export XMODIFIERS=@im=ibus" >> $HOME/.bashrc
                    sudo echo "export GTK_IM_MODULE=ibus" >> $HOME/.bashrc
                    sudo echo "export QT_IM_MODULE=ibus" >> $HOME/.bashrc
                    source /etc/profile.d/ibus.sh
                    CHINESIZATION_ADD_PROFILE_IBUS_SUCCESS
                fi
                break
            elif [[ "$choice" -eq 2 ]]; then
                while :
                do
                    CHINESIZATION_DESKTOP_ENVIRONMENT_INFO
                    read -p ":" DE
                    if [[ "$DE" -eq 1 ]]; then
                        #kde
                        if [ "$INPUT_METHOD" == "fcitx5" ]; then
                            CHINESIZATION_ADD_PROFILE_FCITX_5_INFO
                            #设置环境变量
                            sudo echo "XMODIFIERS=@im=fcitx5" >> /etc/environment
                            sudo echo "SDL_IM_MODULE=fcitx5" >> /etc/environment
                            sudo echo "GLFW_IM_MODULE=ibus" >> /etc/environment
                            source /etc/profile.d/fcitx5.sh
                            CHINESIZATION_ADD_PROFILE_FCITX_5_SUCCESS
                        elif [ "$INPUT_METHOD" == "ibus" ]; then
                            CHINESIZATION_ADD_PROFILE_IBUS_INFO
                            #设置环境变量
                            sudo echo "export XMODIFIERS=@im=ibus" >> $HOME/.bashrc
                            sudo echo "export GTK_IM_MODULE=ibus" >> $HOME/.bashrc
                            sudo echo "export QT_IM_MODULE=ibus" >> $HOME/.bashrc
                            source /etc/profile.d/ibus.sh
                            CHINESIZATION_ADD_PROFILE_IBUS_SUCCESS
                        fi
                        break
                    elif [[ "$DE" -eq 2 ]]; then
                        #gnome
                        if [ "$INPUT_METHOD" == "fcitx5" ]; then
                            CHINESIZATION_ADD_PROFILE_FCITX_5_INFO
                            #设置环境变量
                            sudo echo "XMODIFIERS=@im=fcitx5" >> /etc/environment
                            sudo echo "GTK_IM_MODULE=fcitx5" >> /etc/environment
                            sduo echo "QT_IM_MODULE=fcitx5" >> /etc/environment
                            sudo echo "SDL_IM_MODULE=fcitx5" >> /etc/environment
                            sudo echo "GLFW_IM_MODULE=ibus" >> /etc/environment
                            source /etc/profile.d/fcitx5.sh
                            CHINESIZATION_ADD_PROFILE_FCITX_5_SUCCESS
                        elif [ "$INPUT_METHOD" == "ibus" ]; then
                            CHINESIZATION_ADD_PROFILE_IBUS_INFO
                            #设置环境变量
                            sudo echo "export XMODIFIERS=@im=ibus" >> $HOME/.bashrc
                            sudo echo "export GTK_IM_MODULE=ibus" >> $HOME/.bashrc
                            sudo echo "export QT_IM_MODULE=ibus" >> $HOME/.bashrc
                            source /etc/profile.d/ibus.sh
                            CHINESIZATION_ADD_PROFILE_IBUS_SUCCESS
                        fi
                        break
                    else
                        CHINESIZATION_DESKTOP_ENVIRONMENT_ERROR
                    fi
                done
                break
            else
                CHINESIZATION_ENVIRONMENT_INIT_ERROR           
            fi
        done
    }

    input_method_config() {
        local choice
        if [[ -s "/etc/environment" ]]; then
            CHINESIZATION_INPUT_METHOD_CONFIG_INFO
            read -p ":" choice
            if [[ "$choice" =~ ^[Yy]$ ]]; then
                >/etc/environment
                environment_init
            else
                CHINESIZATION_INPUT_METHOD_CONFIG_ERROR
            fi
        else
            environment_init
        fi

    }

    #Ubuntu安装函数
    ubuntu_install() {
        CHINESIZATION_INSTALL_UBUNTU_INFO
        #更新软件源
        sudo apt upgrade -y
        #安装输入法
        if [ "$INPUT_METHOD" == "fcitx5" ]; then
            sudo apt install fcitx5-* -y
        else
            sudo apt install ibus-* -y
        fi
        #配置输入法
        input_method_config
        CHINESIZATION_INSTALL_UBUNTU_SUCCESS
    }

    #fedora安装函数
    fedora_install() {
        CHINESIZATION_INSTALL_FEDORA_INFO
        #更新软件源
        sudo dnf upgrade -y
        #安装输入法
        if [ "$INPUT_METHOD" == "fcitx5" ]; then
            sudo dnf install fcitx5-* -y
        else
            sudo dnf install ibus-* -y
        fi
        #配置输入法
        input_method_config
        CHINESIZATION_INSTALL_FEDORA_SUCCESS
    }

    #arch安装函数
    ARCH_INSTALL() {
        CHINESIZATION_INSTALL_ARCH_INFO
        #更新软件源
        sudo pacman -Syu --noconfirm
        #安装输入法
        if [ "$INPUT_METHOD" == "fcitx5" ]; then
            sudo pacman -S --needed fcitx5
        else
            sudo pacman -S --needed ibus
        fi
        #配置输入法
        input_method_config
        CHINESIZATION_INSTALL_ARCH_SUCCESS
    }

    #修改locale
    modify_locale() {
        CHINESIZATION_MODIFY_LOCALE_INFO
        if [ -f /etc/locale.conf ]; then
            locale_file="/etc/locale.conf"
        elif [ -f /etc/default/locale ]; then
            locale_file="/etc/default/locale"
        elif [ -f /etc/locale ]; then
            locale_file="/etc/locale"
        elif [ -f /etc/locale.gen ]; then
            locale_file="/etc/locale.gen"
        elif [ -d /etc/locale.gen.d/ ]; then
            locale_file="/etc/locale.gen.d/zh_CN.conf"
        else
            CHINESIZATION_MODIFY_LOCALE_ERROR
            sleep 5
            exit 1
        fi
        
        # 备份当前locale文件
        sudo cp "$locale_file" "${locale_file}.bak_$(date +%Y%m%d_%H%M%S)"
        
        # 修改locale文件
        sudo echo "LANG=zh_CN.UTF-8" > "$locale_file"
        
        # 重新生成locale
        if [ -f /etc/locale.gen ]; then
            sudo sed -i 's/^# *\(zh_CN.UTF-8 UTF-8\)/\1/' /etc/locale.gen
            sudo locale-gen
        elif [ -f /etc/locale.gen.d/ ]; then
            sudo echo "zh_CN.UTF-8 UTF-8" > /etc/locale.gen.d/zh_CN.conf
            sudo locale-gen
        elif [ -f /etc/default/locale ]; then
            sudo echo "LANG=zh_CN.UTF-8" > /etc/default/locale
            sudo locale-gen
        elif [ -f /etc/locale.conf ]; then
            
        else
            CHINESIZATION_REBUILD_LOCALE_ERROR
            sleep 5
            exit 1
        fi
        
        # 应用新的locale设置
        source "$locale_file"
        
        CHINRSIZATION_MODIFY_LOCALE_SUCCESS
    }


    # --- 主程序 ---
    #选择输入法
    input_method_selection
    #检测系统类型
    ##根据系统类型调用相应的安装函数
    case $OS_TYPE in
        fedora)
            fedora_install
            ;;
        debian)
            ubuntu_install
            ;;
        arch)
            arch_install
            ;;
        *)
            CHINESIZATION_OS_TYPE_ERROR
            sleep 5
            exit 1
            ;;
    esac
    #修改locale
    modify_locale
    #提示
    while :
    do
        CHINESIZATION_REBOOT_INFO
        read -p ": " restart_choice
        if [[ "$restart_choice" =~ ^[Yy]$ ]]; then
            reboot
        else
            CHINESIZATION_REBOOT_CANCEL_INFO
            sleep 5
            exit 0
        fi
    done
}