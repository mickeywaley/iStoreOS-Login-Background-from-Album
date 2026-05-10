无聊

给 istoreos 路由器固件

在系统菜单下加管理菜单

----



「登入背景相册管理」菜单与页面添加 完整教程

（适用于 iStoreOS/OpenWrt 带 Argon 主题固件，小白友好，全程复制粘贴即可）

一、前期准备：备份系统菜单与主题文件（必做！）

先备份文件，防止改错后无法恢复，所有操作都在路由器的 SSH 终端中执行。

1. 备份系统菜单目录
 
```bash
# 备份整个菜单配置目录，出错可一键还原
cp -r /usr/share/luci/menu.d /usr/share/luci/menu.d.bak
```

2. 备份 Argon 主题核心文件
```bash
# 备份主题模板文件，防止修改后网页无法打开
cp /usr/lib/lua/luci/view/themes/argon/header.htm /usr/lib/lua/luci/view/themes/argon/header.htm.bak
```














``` 

```








1；新建正确菜单（复制直接运行）

``` 
cat > /usr/share/luci/menu.d/argon-theme-album.json << EOF
{
        "admin/system/argon-theme-album": {
                "title": "登入背景相册管理",
                "action": [
                        "/cgi-bin/luci/admin/system/argon-theme-album"
                ],
                "target": "_blank"
        }
}
EOF
```


----

2；清理缓存生效（必须运行）

``` 
rm -rf /tmp/luci-*
/etc/init.d/uhttpd restart
```
