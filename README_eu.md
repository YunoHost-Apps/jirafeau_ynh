<!--
Ohart ongi: README hau automatikoki sortu da <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>ri esker
EZ editatu eskuz.
-->

# Jirafeau YunoHost-erako

[![Integrazio maila](https://dash.yunohost.org/integration/jirafeau.svg)](https://ci-apps.yunohost.org/ci/apps/jirafeau/) ![Funtzionamendu egoera](https://ci-apps.yunohost.org/ci/badges/jirafeau.status.svg) ![Mantentze egoera](https://ci-apps.yunohost.org/ci/badges/jirafeau.maintain.svg)

[![Instalatu Jirafeau YunoHost-ekin](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=jirafeau)

*[Irakurri README hau beste hizkuntzatan.](./ALL_README.md)*

> *Pakete honek Jirafeau YunoHost zerbitzari batean azkar eta zailtasunik gabe instalatzea ahalbidetzen dizu.*  
> *YunoHost ez baduzu, kontsultatu [gida](https://yunohost.org/install) nola instalatu ikasteko.*

## Aurreikuspena

Jirafeau offers the possibility to host and share your files with ease. Choose a file, Jirafeau will provide you with a link with many options. It is possible to protect your links with a password as well as to choose how long the file will be kept on the server. The file and the link will self-destruct after this time. Downloads of transmitted files can be limited to a certain date, and each file can self-destruct after the first download. Jirafeau allows you to configure maximum retention times and maximum size per file. Encryption is available as an option.


**Paketatutako bertsioa:** 4.5.0~ynh2

**Demoa:** <https://demo.yunohost.org/jirafeau/>

## Pantaila-argazkiak

![Jirafeau(r)en pantaila-argazkia](./doc/screenshots/TPjh48P.png)

## Dokumentazioa eta baliabideak

- Aplikazioaren webgune ofiziala: <https://gitlab.com/mojo42/Jirafeau>
- Jatorrizko aplikazioaren kode-gordailua: <https://gitlab.com/mojo42/Jirafeau>
- YunoHost Denda: <https://apps.yunohost.org/app/jirafeau>
- Eman errore baten berri: <https://github.com/YunoHost-Apps/jirafeau_ynh/issues>

## Garatzaileentzako informazioa

Bidali `pull request`a [`testing` abarrera](https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing).

`testing` abarra probatzeko, ondorengoa egin:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing --debug
edo
sudo yunohost app upgrade jirafeau -u https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing --debug
```

**Informazio gehiago aplikazioaren paketatzeari buruz:** <https://yunohost.org/packaging_apps>
