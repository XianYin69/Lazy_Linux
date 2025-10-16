# LL Tool Development Guidance 
Language：[中文](./dev_guide_cn.md) | [English](./dev_guide_en.md)
---
## First Step：
1.  Learn Linux knowledge（Can commanded your pc by CLI）
2.  Learn Shell and make a Shell Scripts at least
---
## Catalog
- [Standard](#standard)   
    - [File Structure](#file-structure)
    - [Code Structure](#code-structure)
- [Index](#index)
    - [Index a path](#index-a-path)
    - [Call](#call)
-   [Afterwords](#afterwords)    
    -   [Why programmed by shell not C](#why-programmed-by-shell-not-c)
    -   [Why I index file or path accrodiong a shit method](#why-i-index-file-or-path-accrodiong-a-shit-method)
---
## Standard
### File Structure
-   Lazy_Linux(Main dictory)   
    -   lazy_linux.sh（Main program）    
    -   LICENSE  
    -   README（illustration）
    -   lib （“liberay”）
        - lib_name  （“liberay_name”）
            - lib_main.sh （“lib”）
            - sub-lib （“sub-liberay name”）
                -   sub-lib.sh （“sub-liberay”）
    -   sample（demo）
    -   src（source）
        - source （source_name）
            -   source.xxx（source_file）
    -   var（variable）
        -   variabale  （varible）
            -   variblae.txt（variable file）
---
### Code Structure
> Something in "/Sample" 

```bash
#================================================
#Your and script's description
#================================================

#define sub_function

function_name() {
    #index file
    INDEX

    #define variable
    local <var_name>="<parameter>"

    code
}

#define main_function

main() {
    #index file
    INDEX

    #define variable
    local <var_name>="<parameter>"
    
    sub_function
}

```

> You need add "main" to your defined script functionin lazy_linux if you want to open your script in main menu.

---
## Index
### Index a path    
>I design a delicate index method, I may replace it after ver.3.0 update      

#### About ".index.sh"  
        A file to store paths and files(if existed) index function
#### About path
        This projrct index paths and files(if existed) accroding to index relative path
#### About the index variable name of ".index.sh"
        Name foormat:<prefix>_<name>_<attribute>_<PATH>_<(INDEX)>=<path>
##### Name's structure
    - Prefix：sup_folder<<"SUP";
    - Name：The full name of folder or file;
    - Attribute：file<<"FILE";sub_folder<<"FOLDER";main folder and sup_folder<<"HOME"
    - path：The relative path of Same level and lower level path(must index lower level path's".index.sh" and include "INDEX")

#### Demo：  
---
File Structure(portion)：
-   ROOT    
    -   PATH_1  
        -   .index.sh   
        -   script.sh   
    -   .index.sh

".index.sh(/.index.sh)"'s code(portion)：
```bash
    ROOT_HOME_PATH="./"

    PATH_1_FOLDER_PATH_INDEX="PATH_1/.index.sh"

    PATH_1_FOLDER_PATH="PATH_1/"
```

".index.sh(/PATH_1/.index.sh)"'s code(portion)：
```bash
    SUP_PATH_1_HOME_PATH="../"
    PATH_1_HOME_PATH="./"

    SCRIPT_SH_FILE_PATH="script.sh"
```

### Call

---

> Due to index file and folder accroding to relative path, you should know what you did.

---

#### Call the content of lower_path
"Step by step sourcing goal path's ".index.sh" or the path of goal file 's ".index.sh" from "sourcing "./.index.sh"，Then "local <Path_name or file_name(Not include suffix and file extension name)>_PATH="The path of index goal"。    

---

#### Call different path
Same, "source" to root then "source" to your goal file or path

---

#### Demo:

File Structure(portion):
-   ROOT
    -   PATH_1
        - script1.sh
    -   PATH_2
        - script2.sh
    - main.sh
---

"main.sh"'s code(portion)：
```bash
    source "./.index.sh"
    source "$PATH_1_FOLDER_PATH_INDEX"
    local SCRIPT1_SH_PATH="$PATH_1_FOLDER_PATH$SCRIPT1_SH_FILE_PATH"
    local SCRIPT1_PATH="$PATH_1_FOLDER_PATH"

    cd "SCRIPT1_PATH"
    command "SCRIPT1_PATH"
    cd ".."

    cd "SCRIPT1_PATH"
    command #You defined behavior in script1.sh
    cd ".."

    command #You defined behavior in script1.sh
```

"script1.sh"'s code(portion)：
```bash
    #call script2.sh
    source "./.index"
    source "$SUP_PATH_1_HOME_PATH".index.sh
    source "$SUP_PATH_1_HOME_PATH$PATH_2_FOLDER_PATH_INDEX"
    local SCRIPT2_PATH="$SUP_PATH_1_HOME_PATH$PATH_2_FOLDER_PATH"
    local SCRIPT2_SH_PATH

    cd "SCRIPT2_PATH"
    command "SCRIPT2_PATH"
    cd ".."

    cd "PATH_2_PATH"
    command #You defined behavior in script1.sh
    cd ".."

    command #You defined behavior in script1.sh
```

---
## Afterwords
### Why programmed by shell not C
    1.Other PC maybe non-x86_64 framework
    2.Other PC isn't installed all of GNU packages
### Why I index file or path accrodiong a shit method
    I already used to use relative path in terminal
---