<!--
Важно: этот README был автоматически сгенерирован <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Он НЕ ДОЛЖЕН редактироваться вручную.
-->

# Jirafeau для YunoHost

[![Уровень интеграции](https://apps.yunohost.org/badge/integration/jirafeau)](https://ci-apps.yunohost.org/ci/apps/jirafeau/)
![Состояние работы](https://apps.yunohost.org/badge/state/jirafeau)
![Состояние сопровождения](https://apps.yunohost.org/badge/maintained/jirafeau)

[![Установите Jirafeau с YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=jirafeau)

*[Прочтите этот README на других языках.](./ALL_README.md)*

> *Этот пакет позволяет Вам установить Jirafeau быстро и просто на YunoHost-сервер.*  
> *Если у Вас нет YunoHost, пожалуйста, посмотрите [инструкцию](https://yunohost.org/install), чтобы узнать, как установить его.*

## Обзор

Jirafeau offers the possibility to host and share your files with ease. Choose a file, Jirafeau will provide you with a link with many options. It is possible to protect your links with a password as well as to choose how long the file will be kept on the server. The file and the link will self-destruct after this time. Downloads of transmitted files can be limited to a certain date, and each file can self-destruct after the first download. Jirafeau allows you to configure maximum retention times and maximum size per file. Encryption is available as an option.


**Поставляемая версия:** 4.6.2~ynh1

**Демо-версия:** <https://demo.yunohost.org/jirafeau/>

## Снимки экрана

![Снимок экрана Jirafeau](./doc/screenshots/TPjh48P.png)

## Документация и ресурсы

- Репозиторий кода главной ветки приложения: <https://gitlab.com/jirafeau/Jirafeau>
- Магазин YunoHost: <https://apps.yunohost.org/app/jirafeau>
- Сообщите об ошибке: <https://github.com/YunoHost-Apps/jirafeau_ynh/issues>

## Информация для разработчиков

Пришлите Ваш запрос на слияние в [ветку `testing`](https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing).

Чтобы попробовать ветку `testing`, пожалуйста, сделайте что-то вроде этого:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing --debug
или
sudo yunohost app upgrade jirafeau -u https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing --debug
```

**Больше информации о пакетировании приложений:** <https://yunohost.org/packaging_apps>
