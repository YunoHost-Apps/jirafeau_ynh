<!--
N.B.: README ini dibuat secara otomatis oleh <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Ini TIDAK boleh diedit dengan tangan.
-->

# Jirafeau untuk YunoHost

[![Tingkat integrasi](https://dash.yunohost.org/integration/jirafeau.svg)](https://ci-apps.yunohost.org/ci/apps/jirafeau/) ![Status kerja](https://ci-apps.yunohost.org/ci/badges/jirafeau.status.svg) ![Status pemeliharaan](https://ci-apps.yunohost.org/ci/badges/jirafeau.maintain.svg)

[![Pasang Jirafeau dengan YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=jirafeau)

*[Baca README ini dengan bahasa yang lain.](./ALL_README.md)*

> *Paket ini memperbolehkan Anda untuk memasang Jirafeau secara cepat dan mudah pada server YunoHost.*  
> *Bila Anda tidak mempunyai YunoHost, silakan berkonsultasi dengan [panduan](https://yunohost.org/install) untuk mempelajari bagaimana untuk memasangnya.*

## Ringkasan

Jirafeau offers the possibility to host and share your files with ease. Choose a file, Jirafeau will provide you with a link with many options. It is possible to protect your links with a password as well as to choose how long the file will be kept on the server. The file and the link will self-destruct after this time. Downloads of transmitted files can be limited to a certain date, and each file can self-destruct after the first download. Jirafeau allows you to configure maximum retention times and maximum size per file. Encryption is available as an option.


**Versi terkirim:** 4.5.0~ynh3

**Demo:** <https://demo.yunohost.org/jirafeau/>

## Tangkapan Layar

![Tangkapan Layar pada Jirafeau](./doc/screenshots/TPjh48P.png)

## Dokumentasi dan sumber daya

- Website aplikasi resmi: <https://gitlab.com/mojo42/Jirafeau>
- Depot kode aplikasi hulu: <https://gitlab.com/mojo42/Jirafeau>
- Gudang YunoHost: <https://apps.yunohost.org/app/jirafeau>
- Laporkan bug: <https://github.com/YunoHost-Apps/jirafeau_ynh/issues>

## Info developer

Silakan kirim pull request ke [`testing` branch](https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing).

Untuk mencoba branch `testing`, silakan dilanjutkan seperti:

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing --debug
atau
sudo yunohost app upgrade jirafeau -u https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing --debug
```

**Info lebih lanjut mengenai pemaketan aplikasi:** <https://yunohost.org/packaging_apps>
