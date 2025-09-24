#!/bin/bash
# =================================================================================================
# 脚本名称：Selector.sh
# 描述：语言选择       
# 作者：XianYin69       
# 参考来源：None   
# 日期：9-23-2025       
# =================================================================================================

#语言选择
select_launcher_language() {
    source ./.index.sh
    source "./$SUP_LANG_HOME_PATH".index.sh
    source "./$SUP_LANG_HOME_PATH$SUP_LIB_HOME_PATH".index.sh
    source "./$SUP_LANG_HOME_PATH$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH_INDEX"
    source "./$SUP_LANG_HOME_PATH$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH$STATE_FOLDER_PATH_INDEX"
    source "./$SUP_LANG_HOME_PATH$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"
    local STATE_SH_PATH="./$SUP_LANG_HOME_PATH$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"

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
    source ./.index.sh
    source "./$SUP_LANG_HOME_PATH".index.sh
    source "./$SUP_LANG_HOME_PATH$SUP_LIB_HOME_PATH".index.sh
    source "./$SUP_LANG_HOME_PATH$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH_INDEX"
    source "./$SUP_LANG_HOME_PATH$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH$STATE_FOLDER_PATH_INDEX"
    source "./$SUP_LANG_HOME_PATH$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"
    local STATE_SH_PATH="./$SUP_LANG_HOME_PATH$SUP_LIB_HOME_PATH$VAR_FOLDER_PATH$STATE_FOLDER_PATH$STATE_SH_FILE_PATH"

    source "$STATE_SH_PATH"
    if [[ "$TTY_MODE" == "Y" || "$SESSION_TYPE" == "tty" ]]; then
        # TTY模式下每次都选择语言
        select_launcher_language
    else
        # 非TTY模式下仅STATE_LANG为空时选择语言
        if [[ -z "$STATE_LANG" ]]; then
            select_launcher_language
        fi
    fi
}