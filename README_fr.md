<!--
Nota bene : ce README est automatiquement généré par <https://github.com/YunoHost/apps/tree/master/tools/readme_generator>
Il NE doit PAS être modifié à la main.
-->

# Jirafeau pour YunoHost

[![Niveau d’intégration](https://apps.yunohost.org/badge/integration/jirafeau)](https://ci-apps.yunohost.org/ci/apps/jirafeau/)
![Statut du fonctionnement](https://apps.yunohost.org/badge/state/jirafeau)
![Statut de maintenance](https://apps.yunohost.org/badge/maintained/jirafeau)

[![Installer Jirafeau avec YunoHost](https://install-app.yunohost.org/install-with-yunohost.svg)](https://install-app.yunohost.org/?app=jirafeau)

*[Lire le README dans d'autres langues.](./ALL_README.md)*

> *Ce package vous permet d’installer Jirafeau rapidement et simplement sur un serveur YunoHost.*  
> *Si vous n’avez pas YunoHost, consultez [ce guide](https://yunohost.org/install) pour savoir comment l’installer et en profiter.*

## Vue d’ensemble

Jirafeau offre la possibilité d'héberger et de partager vos fichiers, le tout en toute simplicité. Choisissez un fichier, Jirafeau vous fournira un lien avec beaucoup d'options. Il est possible de protéger vos liens avec mot de passe ainsi que de choisir la durée de rétention du fichier sur le serveur. Le fichier et le lien s'autodétruiront passé ce délai. Les téléchargements des fichiers transmis peuvent être limités à une certaine date, et chaque fichier peut s'autodétruire après le premier téléchargement. Jirafeau permet de configurer les temps maximum de rétention ainsi que la taille maximale par fichier. Le chiffrement est disponible en option.


**Version incluse :** 4.6.2~ynh1

**Démo :** <https://demo.yunohost.org/jirafeau/>

## Captures d’écran

![Capture d’écran de Jirafeau](./doc/screenshots/TPjh48P.png)

## Documentations et ressources

- Dépôt de code officiel de l’app : <https://gitlab.com/jirafeau/Jirafeau>
- YunoHost Store : <https://apps.yunohost.org/app/jirafeau>
- Signaler un bug : <https://github.com/YunoHost-Apps/jirafeau_ynh/issues>

## Informations pour les développeurs

Merci de faire vos pull request sur la [branche `testing`](https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing).

Pour essayer la branche `testing`, procédez comme suit :

```bash
sudo yunohost app install https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing --debug
ou
sudo yunohost app upgrade jirafeau -u https://github.com/YunoHost-Apps/jirafeau_ynh/tree/testing --debug
```

**Plus d’infos sur le packaging d’applications :** <https://yunohost.org/packaging_apps>
