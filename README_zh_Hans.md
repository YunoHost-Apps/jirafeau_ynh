<!--
注意：此 README 由 <https://github.com/YunoHost/apps/tree/master/tools/readme_generator> 自动生成
请勿手动编辑。
-->

# YunoHost 上的 Jirafeau

[![集成程度](https://apps.yunohost.org/badge/integration/jirafeau)](https://ci-apps.yunohost.org/ci/apps/jirafeau/)
![工作状态](https://apps.yunohost.org/badge/state/jirafeau)
![维护状态](https://apps.yunohost.org/badge/maintained/jirafeau)

[![使用 YunoHost 安装 Jirafeau](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=jirafeau)

*[阅读此 README 的其它语言版本。](./ALL_README.md)*

> *通过此软件包，您可以在 YunoHost 服务器上快速、简单地安装 Jirafeau。*  
> *如果您还没有 YunoHost，请参阅[指南](https://yunohost.org/install)了解如何安装它。*

## 概况

Jirafeau offers the possibility to host and share your files with ease. Choose a file, Jirafeau will provide you with a link with many options. It is possible to protect your links with a password as well as to choose how long the file will be kept on the server. The file and the link will self-destruct after this time. Downloads of transmitted files can be limited to a certain date, and each file can self-destruct after the first download. Jirafeau allows you to configure maximum retention times and maximum size per file. Encryption is available as an option.


**分发版本：** 4.6.0~ynh1

**演示：** <https://demo.yunohost.org/jirafeau/>

## 截图

![Jirafeau 的截图](./doc/screenshots/TPjh48P.png)

## 文档与资源

- 上游应用代码库： <https://gitlab.com/jirafeau/Jirafeau>
- YunoHost 商店： <https://apps.yunohost.org/app/jirafeau>
- 报告 bug： <https://github.com/YunoHost-Apps/jirafeau_ynh/issues>

## 开发者信息

请向 [`testing` 分支](https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing) 发送拉取请求。

如要尝试 `testing` 分支，请这样操作：

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing --debug
或
sudo yunohost app upgrade jirafeau -u https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing --debug
```

**有关应用打包的更多信息：** <https://yunohost.org/packaging_apps>
