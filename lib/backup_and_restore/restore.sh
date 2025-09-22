#!/bin/bash
# =================================================================================================
# 脚本名称：名字
# 描述：这个脚本是做什么的       
# 作者：你的名字       
# 参考来源：如果参考网上教程请标注   
# 日期：月-日-年       
# =================================================================================================

source "../../var/state/STATE.sh"
source "../../var/index/filepath.sh"
 
RESTORE_INFO
RESTORE_PATH_INFO
read -p ":" RESTORE_STORE_PATH

uncompress() {
    tar -xzvf $RESTORE_STORE_PATH/backup/backup_*.tar.gz -C / $1
}

if [ -f $RESTORE_STORE_PATH/backup/backup_*.tar.gz ] && [ -f $RESTORE_STORE_PATH/backup/backup_*.log ]; then
    source "$RESTORE_STORE_PATH/backup/backup_*.log"
    uncompress "$BACKUP_PATH"
    if [ -f $BACKUP_PATH ]; then
        RESTORE_SUCCESS_INFO
    else
        RESTORE_FAIL_INFO
    fi
else
    RESTORE_FAIL_INFO
fi