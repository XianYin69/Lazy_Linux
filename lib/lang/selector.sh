#!/bin/bash
# =================================================================================================
# 脚本名称：Selector.sh
# 描述：语言选择       
# 作者：XianYin69       
# 参考来源：None   
# 日期：9-23-2025       
# =================================================================================================

#定义变量
source ./.index.sh

source "./$SUP_LANG_HOME_PATH".index.sh
source "./$SUP_LANG_HOME_PATH$SUP_LIB_HOME_PATH".index.sh
source "./$SUP_LANG_HOME_PATH$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH$STATE_FOLDER_PATH_INDEX"
source "./$SUP_LANG_HOME_PATH$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"
STATE_SH_PATH="./$SUP_LANG_HOME_PATH$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"

#主函数
#语言选择
select_launcher_language() {
    while :
    do
        echo  "Please choose your language:"
        echo  "1.中文"
        echo  "2.English"
        read -p ":" LAUNCHER_LANGUAGE
        if [ "$LAUNCHER_LANGUAGE" -eq 1 ]; 
        then
            sed -i "s/STATE_LANG=.*/STATE_LANG=ch/g" $STATE_SH_PATH
            break
        elif [ "$LAUNCHER_LANGUAGE" -eq 2 ]; 
        then
            sed -i "s/STATE_LANG=.*/STATE_LANG=en/g" $STATE_SH_PATH
            break
        else
            echo "You must select one!"
        fi
    done
}

#语言初始化
language_choose() {
    while :
    do
        source $STATE_SH_PATH
        if [ "$TTY_MODE" = "N" ]
        then
            if [ "$STATE_LANG" = "ch" ]; then
                source "./$LANG_LIB_FOLDER_PATH_INDEX"
                source "./$LANG_LIB_FOLDER_PATH$ZH_CN_SH_FILE_PATH"
                break
            elif [ "$STATE_LANG" = "en" ]; then
                source "./$LANG_LIB_FOLDER_PATH_INDEX"
                source "./$LANG_LIB_FOLDER_PATH$EN_US_SH_FILE_PATH"
                break
            elif [ "$STATE_LANG" = "initing" ]; then
                select_launcher_language
            else
                source "./$LANG_LIB_FOLDER_PATH_INDEX"
                source "./$LANG_LIB_FOLDER_PATH$EN_US_SH_FILE_PATH"
                break
            fi
        else
                select_launcher_language
        fi
    done
}