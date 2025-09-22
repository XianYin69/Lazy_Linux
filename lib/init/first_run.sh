source "../../var/state/STATE.sh"
source "../../var/index/filepath.sh"
 

if  [[ $EUID -ne 0 ]];
then
    FIRST_RUN_SH_ROOT_ERROR
    exit 0
else
    if [[ $TIME -eq 0 ]];
    then
        chmod +x ../../*.sh
    else
        bash ../../lazy_linux.sh
    fi
fi