### Openwrt x86精简版：
1. 参考[P3TERX](https://github.com/P3TERX/Actions-OpenWrt)的自动编译，使用[Lean]（https://github.com/coolsnowwolf/lede）最新源码
2. x86 64bit 精简版，默认管理地址:192.168.1.1 用户名:root 密码:password
2. 精简版比较适合vm下使用，仅支持常见软路由功能。
3. 与另一自动编译项目的精简版固件一致 :https://github.com/ardanzhu/lede-openwrt-ci
4. 下载见[OpenWrt x86](https://github.com/ardanzhu/Opwrt_Actions/releases/tag/x64-slim)

### NanoPi R2S说明
1. 完全跟进[Klever1988](https://github.com/klever1988/nanopi-openwrt)的方式编译R2S固件，按个人使用重新筛选应用分成两版本，Web管理主题改成清爽的opentomcat
2. 默认管理地址:192.168.2.1  用户名:root  密码:password
3. 下载见[R2S定制](https://github.com/ardanzhu/Opwrt_Actions/releases/tag/R2S)
4. 精简版支持SSRP、Passwall、diskman、samba4、frpc/frps、ttyd，去掉全部广告拦截及openvpn，详细见[r2s.config]( ./r2s.config)
5. 定制版在精简版基础上增加广告拦截、docker、openvpn、transmission、openvpn等，详细见:[r2s_opt.config]( ./r2s_opt.config)
6. 感谢gary lau的在线更新脚本，可保持配置在线更新，并支持互刷，通过web管理页面的TTYD或SSH到R2S后执行如下命令：<br> 
* 精简版保持配置在线更新命令：
```
wget -qO- https://github.com/ardanzhu/Opwrt_Actions/raw/master/r2s/autoupdate-slim.sh | sh
```
* 定制版保持配置在线更新命令：
```
wget -qO- https://github.com/ardanzhu/Opwrt_Actions/raw/master/r2s/autoupdate-opt.sh | sh
```
7. 不保持配置的刷机方法：
通过web管理页的文件传输，把R2S*.zip(无需解压)上传到R2S的/tmp/upload文件夹，再通过web管理页面的TTYD或SSH到R2S后执行如下命令：
```
wget -qO- https://github.com/ardanzhu/Opwrt_Actions/raw/master/r2s/freshupdate.sh | sh
```
8. 保持常用配置刷机方法：
通过web管理页的文件传输，把R2S*.zip(无需解压)上传到R2S的/tmp/upload文件夹，再通过web管理页面的TTYD或SSH到R2S后执行如下命令：
```
wget -qO- https://github.com/ardanzhu/Opwrt_Actions/raw/master/r2s/keep_update.sh | sh
```
### 感谢
- [Lean]（https://github.com/coolsnowwolf/lede）
- [Klever1988](https://github.com/klever1988/nanopi-openwrt)
- [P3TERX](https://github.com/P3TERX/Actions-OpenWrt)
- [Read the details in my blog (in Chinese) | 中文教程](https://p3terx.com/archives/build-openwrt-with-github-actions.html)

#### License
[MIT]


#### 系统界面部分截图：
![freshupdate](pic/freshupdate.jpg)
![onlineupdate](pic/R2S_autoupdate.jpg)
![diskman](pic/diskman.jpg)
![dockerman](pic/docker.jpg)
![transmission](pic/transmission.jpg)
![opentomcat](pic/opentomcat.png)
