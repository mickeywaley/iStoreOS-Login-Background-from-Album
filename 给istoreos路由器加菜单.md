无聊

给 istoreos 路由器固件

在系统菜单下加管理菜单

----


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
