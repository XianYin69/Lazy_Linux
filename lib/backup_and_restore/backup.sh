#!/bin/bash
# =================================================================================================
# 脚本名称：backup.sh
# 描述：备份文件    
# 作者：XianYin69       
# 参考来源：none
# 日期：09-18-2025       
# =================================================================================================

main(){
    BACKUP_INFO
    BACKUP_PATH_INFO
    read -p ":" BACKUP_PATH
    BACKUP_STORE_INFO
    read -p ":" BACKUP_STORE_PATH

    mkdir -p $BACKUP_STORE_PATH/backup
    tar -czvf $BACKUP_STORE_PATH/backup/backup_$(date +%Y%m%d_%H%M%S).tar.gz $BACKUP_PATH
    touch $BACKUP_STORE_PATH/backup/backup_$(date +%Y%m%d_%H%M%S).txt
    echo "BACKUP_PATH=$BACKUP_PATH" >> $BACKUP_STORE_PATH/backup/backup_$(date +%Y%m%d_%H%M%S).txt
    echo "BACKUP_STORE_PATH=$BACKUP_STORE_PATH" >> $BACKUP_STORE_PATH/backup/backup_$(date +%Y%m%d_%H%M%S).txt

    if [ -f $BACKUP_STORE_PATH/backup/backup_*.tar.gz ] && [ -f $BACKUP_STORE_PATH/backup/backup_*.log ]; then
        BACKUP_SUCCESS_INFO
    else
        BACKUP_FAIL_INFO
    fi
} 