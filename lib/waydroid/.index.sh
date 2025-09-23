#目录索引
SUP_VAR_HOME_PATH=".."
VAR_HOME_PATH="."

#文件索引
STATE_FOLDER_PATH="$VAR_HOME_PATH/state/.index.sh"

#索引行为
source_sup_path() {
    cd "$SUP_HOME_PATH"
    source "./.index.sh"
}