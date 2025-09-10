source "../state/STATE.txt"

if  $EUID -nq 0 || TIME -nq 0
then
    FIRST_RUN_SH_ROOT_ERROR
    exit 0
else
    chmod +x ../*
fi