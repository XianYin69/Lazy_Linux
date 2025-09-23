# LL Tool Development Guidance 
Language：[中文](./dev_guide_cn.md) | [English](./dev_guide_en.md)
---
## Catalog
- [Standard](#标准)   
    - [File Structure](#文件结构)
    - [Code Structure](#代码结构)
-   [Afterwords](#后话)    
    -   [Why programmed by shell not C](#为何不使用c语言)
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
#You and you declare or decribe your script
#================================================

source "../../state/STATE.sh"
source "../../index/filepath.sh"

#define variable

#define sub function

#main function
```
---
## Afterwords
### Why programmed by shell not C
    1.Other PC maybe non-x86_64 framework
    2.Other PC isn't installed all of GNU packages
---