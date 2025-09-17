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

## 注意事项
> 由于本人精力有限且主力系统是Fedora,故只开发了用于Fedora的脚本（部分脚本可以用于其他发行版）。  

> 由于本人是计算机相关专业的大学生（一个初学者），请见谅。  

> 虽然这些工具已经过我的测试，但是这个工具集里面的工具我无法保证在您的电脑上能完美运行。
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