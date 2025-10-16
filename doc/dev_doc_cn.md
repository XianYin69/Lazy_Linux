# LL 工具开发指导
语言：[中文](./dev_guide_cn.md) | [English](./dev_guide_en.md)
---
## 你首先应该做的：
1.  了解Linux（不用熟练掌握）
2.  了解shelle和写过一个能运行shell脚本
---
## 目录
- [标准](#标准)   
    - [文件结构](#文件结构)
    - [代码结构](#代码结构)
    - [索引](#索引)  
        - [索引路径](#索引路径)   
        - [调用文件](#调用文件)
-   [后话](#后话)    
    -   [为何不使用C语言](#为何不使用c语言) 
    -   [为什么用这么狗屎的索引方式](#为何使用这么狗屎的索引方式)
---
## 标准
### 文件结构
-   Lazy_Linux(主目录)   
    -   lazy_linux.sh（主程序）    
    -   LICENSE（许可证）  
    -   README（说明）
    -   lib （“库”）
        - lib_name  （“库名”）
            - lib_main.sh （“库函数文件”）
            - sub-lib （“子库名”）
                -   sub-lib.sh （“子库函数文件”）
    -   sample（示例）
    -   src（资源）
        - source （资源名）
            -   source.xxx（资源文件）
    -   var（变量）
        -   variable  （变量名）
            -   variable.txt（变量文件）
---
### 代码结构
> 一部分包含在"/sample"里的示例文件中 

```bash
#================================================
#你及你的脚本的描述
#================================================

#定义子函数

函数名() {
    #文件索引
    INDEX

    #定义变量
    local <变量名>="<参数>"

    函数体
}

#主函数

main() {
    #文件索引
    INDEX

    #定义变量
    local <变量名>="<参数>"


    子函数
}

```

>如果你要在lazy_linux.sh的主菜单里直接运行你的脚本，请在lazy_linux.sh中你定义的函数里添加"main"

---
## 索引
### 索引路径    
> 我设计了一个精巧且愚蠢的索引方式，我会在3.0版使用不同的索引方式       

#### 关于“.index.sh”
        此文件是一个用于存储目录索引和该目录下文件索引（如果存在的话）的文件。
#### 关于路径
        此脚本使用相对路径来索引文件夹和文件。
#### 关于“.index.sh”中索引变量的命名
        命名格式是:<前缀>_<名称>_<属性>_<PATH>_<(INDEX)>=<路径>
##### 命名规范
    - 前缀：父级文件夹<<"SUP";
    - 名称：文件夹或文件的全称;
    - 属性：文件<<"FILE";子文件夹<<"FOLDER";主文件夹及父文件夹<<"HOME"
    - 路径：同一级或下一级路径（必须索引到下一级路径的.index.sh且包含"INDEX"）的相对路径

#### 示例：  
---
文件（部分）结构：
-   ROOT    
    -   PATH_1  
        -   .index.sh   
        -   script.sh   
    -   .index.sh

.index.sh(/.index.sh)部分代码：
```bash
    ROOT_HOME_PATH="./"

    PATH_1_FOLDER_PATH_INDEX="PATH_1/.index.sh"

    PATH_1_FOLDER_PATH="PATH_1/"
```

.index.sh(/PATH_1/.index.sh)部分代码：
```bash
    SUP_PATH_1_HOME_PATH="../"
    PATH_1_HOME_PATH="./"

    SCRIPT_SH_FILE_PATH="script.sh"
```

### 调用文件

---

> 由于使用相对路径，你需要非常清楚你在做什么

---

#### 调用下一级目录的内容
从 "source "./.index.sh""开始分步引用到目标目录的".index.sh"或目标文件所在目录的".index.sh"，后"local <目录名或文件名（不含后缀和文件拓展名）>_PATH="你的目标目录或文件的索引""。    

---

#### 调用不同目录下的内容
同上， "source"到主目录下再 "source"到你的目标文件或目标目录

---

#### 示例:

文件（部分）结构:
-   ROOT
    -   PATH_1
        - script1.sh
    -   PATH_2
        - script2.sh
    - main.sh
---

main.sh的部分代码：
```bash
    source "./.index.sh"
    source "$PATH_1_FOLDER_PATH_INDEX"
    local SCRIPT1_SH_PATH="$PATH_1_FOLDER_PATH$SCRIPT1_SH_FILE_PATH"
    local SCRIPT1_PATH="$PATH_1_FOLDER_PATH"

    cd "SCRIPT1_PATH"
    command "SCRIPT1_PATH"
    cd ".."

    cd "SCRIPT1_PATH"
    command #你在script1.sh中定义的行为
    cd ".."

    command #你在script1.sh中定义的行为
```

script1.sh的部分代码：
```bash
    #索引script2.sh
    source "./.index"
    source "$SUP_PATH_1_HOME_PATH".index.sh
    source "$SUP_PATH_1_HOME_PATH$PATH_2_FOLDER_PATH_INDEX"
    local SCRIPT2_PATH="$SUP_PATH_1_HOME_PATH$PATH_2_FOLDER_PATH"
    local SCRIPT2_SH_PATH

    cd "SCRIPT2_PATH"
    command "SCRIPT2_PATH"
    cd ".."

    cd "PATH_2_PATH"
    command #你在script1.sh中定义的行为
    cd ".."

    command #你在script1.sh中定义的行为
```

---
## 后话 
### 为何不使用C语言
    1.电脑不一定是x86_64架构
    2.不一定带了GNU提供的软件包
### 为何使用这么狗屎的索引方式
    我在终端使用相对路径用习惯了
---