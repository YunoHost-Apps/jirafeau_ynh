<!--
NB: Deze README is automatisch gegenereerd door <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Hij mag NIET handmatig aangepast worden.
-->

# Jirafeau voor Yunohost

[![Integratieniveau](https://apps.yunohost.org/badge/integration/jirafeau)](https://ci-apps.yunohost.org/ci/apps/jirafeau/)
![Mate van functioneren](https://apps.yunohost.org/badge/state/jirafeau)
![Onderhoudsstatus](https://apps.yunohost.org/badge/maintained/jirafeau)

[![Jirafeau met Yunohost installeren](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=jirafeau)

*[Deze README in een andere taal lezen.](./ALL_README.md)*

> *Met dit pakket kun je Jirafeau snel en eenvoudig op een YunoHost-server installeren.*  
> *Als je nog geen YunoHost hebt, lees dan [de installatiehandleiding](https://yunohost.org/install), om te zien hoe je 'm installeert.*

## Overzicht

Jirafeau offers the possibility to host and share your files with ease. Choose a file, Jirafeau will provide you with a link with many options. It is possible to protect your links with a password as well as to choose how long the file will be kept on the server. The file and the link will self-destruct after this time. Downloads of transmitted files can be limited to a certain date, and each file can self-destruct after the first download. Jirafeau allows you to configure maximum retention times and maximum size per file. Encryption is available as an option.


**Geleverde versie:** 4.6.2~ynh1

**Demo:** <https://demo.yunohost.org/jirafeau/>

## Schermafdrukken

![Schermafdrukken van Jirafeau](./doc/screenshots/TPjh48P.png)

## Documentatie en bronnen

- Upstream app codedepot: <https://gitlab.com/jirafeau/Jirafeau>
- YunoHost-store: <https://apps.yunohost.org/app/jirafeau>
- Meld een bug: <https://github.com/YunoHost-Apps/jirafeau_ynh/issues>

## Ontwikkelaarsinformatie

Stuur je pull request alsjeblieft naar de [`testing`-branch](https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing).

Om de `testing`-branch uit te proberen, ga als volgt te werk:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing --debug
of
sudo yunohost app upgrade jirafeau -u https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing --debug
```

**Verdere informatie over app-packaging:** <https://yunohost.org/packaging_apps>
