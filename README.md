# LL(Lazy_Linux, 慵懒Linux)

LL(Lazy_Linux， 慵懒Linux！) 是一个用于偷懒的Linux工具集，旨在缩短前期配置系统和折腾系统的时间。

---

## 包含的工具

- 备份和恢复你需要的文件
   - backup.sh    
   - restore.sh   
- 初期配置你的系统
   - chinesization.sh   
   - init_git.sh     
- 配置你的系统 
   - super_clean_old_kernel.sh(Only on fedora)    
   - nvidia_driver_installer(Only on fedora)    
- 软件一键安装
   - software_installer.sh 
- 安卓模拟器配置
   - waydroid_installer 
   - apk_installer.sh
---

## 语言支持
-  简体中文 
-  英文

---

## 注意事项
> 仅支持主流发行版（Debian,Arch linux,Cent OS及他们的衍生物）和 主流包管理器（apt,dnf,pacman,snap及flatpak）   

> 我无法保证这些脚本在非x86的设备上顺利运行
---

## 使用方法
1. 克隆此仓库：
   ```bash
   git clone https://github.com/XianYin69/Lazy_Linux.git
   ```
2. 使用脚本 :
   ```bash
   chomod +x PATH/*
   bash ./*.sh
---

## 许可证
本项目基于 MIT 许可证开源，详情请参阅 [LICENSE](./LICENSE)。

---

## 贡献者
<a herf="https://github.com/XianYin69/Lazy_Linux/graphs/contributors">
   <img img src="https://contrib.rocks/image?repo=XianYin69/Lazy_Linux" />
</a>