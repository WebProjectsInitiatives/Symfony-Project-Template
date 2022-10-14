# Template de nouveau projet Symfony
Ce template de projet est basé uniquement sur Symfony et il a pour ambition de s'adapter aux besoins du plus grands nombre de projet.

Vous y retrouverez :
* Des containers (NginX, PHP-CLI et PHP-FPM) pour chaque environnements (Dev, QA et Prod)
* Des scripts permettant :
    - de créer les différents environnements 
    - de rentrer dans chaque conteneurs
    - d'utiliser différents analyseurs statiques
* Des git-hooks pour respecter les normes de codage et améliorer la qualité du code

## 🔔 Prérequis
Pour pouvoir utiliser ce projet, il vous suffira d'avoir ``Docker`` d'installer sur votre machine locale.

Attention, vérifier que votre docker est ``accès au disque dur`` dans ces Settings sinon les partages de fichiers et de dossiers avec vos conteneurs seront 
impossibles.

Pour vérifier que le partage du disque dur est bien activé, allez dans les ``Settings`` de Docker puis allez dans la section ``Shared Drives``. Vérifiez que le 
disque que vous voulez utiliser pour le partage de fichier / dossier est bien coché. Sinon cochez-le et appliquez les changements.

## 🔔 Installation
* **Avoir** un repository sur GitLab pour votre nouveau projet et le **cloner** sur votre machine local.
* **Télécharger** le zip du template de projet.
* **Extraire** le zip dans le dossier ou vous avez clonez votre projet (qui doit être vide).
* Faire un ``find & replace`` du nom du template par le nom de votre projet sur tout le template.
* **Modifier** le nom des trois fichiers de configuration d'NginX (un pour chaque environnement)

        [env].[nom du template].yourdomain.local.conf => [env].[nom de votre projet].yourdomain.local.conf

    Ces fichiers se trouvent dans ``docker-sources/containers-config/NginX/[env]-NginX``.
* **Ajouter** les lignes suivantes à votre fichier ``C:\Windows\System32\drivers\etc\hosts`` tout en les modifiants :

```
# Local URLs -- routed to respective environments
# "prod" environment on local devices
127.0.0.1 prod.[nom de votre projet].yourdomain.local
127.0.0.1 cdn.prod.[nom de votre projet].yourdomain.local
# "qa" environment on local devices
127.0.0.1 qa.[nom de votre projet].yourdomain.local
127.0.0.1 cdn.qa.[nom de votre projet].yourdomain.local
# "dev" environment on local devices
127.0.0.1 dev.[nom de votre projet].yourdomain.local
127.0.0.1 cdn.dev.[nom de votre projet].yourdomain.local
```

**Attention** : Pensez à modifier votre fichier en tant qu'administrateur grâce à NodePad++ pour pouvoir sauvegarder

* Pour finir, il ne vous restera plus qu'à **exécuter** les scripts suivants : ``init-project.bat``, ``bin\build-all-docker-containers.bat``.

Attention, il se peut que vous rencontriez des erreurs dû aux téléchargements de différents packages venant d'aptitude lors de la création des différents 
conteneurs. Dans ce cas, il n'y a pas de solution, juste relancer le script jusqu'à ce que les conteneurs soit prêt.

* Il ne vous reste plus qu'à consulter le résultat sur les adresses suivantes:
    - qa.[nom de votre projet].yourdomain.local:10111
    - prod.[nom de votre projet].yourdomain.local:10101
    - dev.[nom de votre projet].yourdomain.local:10121

## Structure du template
Vous retrouverez la structure du template qui a été séparé en deux parties. Les fichiers et dossiers générés par Symfony et les autres fichiers créés à la main.
Cette structure sera certainement amené à être modifié ou à evoluer donc pensez à la mettre à jour ^^.

```
+ [Nom du project]
|
|   Dossiers et fichiers généré/utilisé par Symfony
|---+ \bin
|   |
|   +--- les scripts que vous utiliserez tout au long de votre projet ;)
|   
|---+ \config
|   |
|   +--- Différents fichiers et/ou dossiers de configurations de Symfony
|
|---+ \environment-files
|   |
|   +--- .env
|   +--- .env.[environment].local-dist  un fichier contenant l'example des variables qu'une personne arrivant sur le projet devra modifier
|   +--- .env.dev
|   +--- .env.qa
|   +--- .env.prod
|
|---+ \public
|   |
|   +--- index.php
|   +--- Autres fichiers générés par des Assets
|
|---+ \src Les sources du projet
|
|---+ \templates Généré par Twig
|   |
|   +--- Tous les fichiers html que Symfony utilisera 
|
+--- composer.json
+--- composer.lock
+--- composer.phar
+--- symfony.lock
```

### Dossiers et fichiers DevOps
```
|---+ \devops-sources
|   |
|   +--- Differents fichiers et dossiers utile à l'utilisation de plugin (analyse, reformatage ...)
|   +--- ...
|
|---+ \docker-sources
|   |
|   +---+ \containers-config
|   |   |
|   |   +---+ \technologie
|   |   |   |
|   |   |   +---+ \dev-technologie
|   |   |   |   |
|   |   |   |   +--- dev-technologies-config.docker
|   |   |   |   +--- les autres fichiers de configuration utile à la construction de l'image de l'environnement de development
|   |   |   |
|   |   |   +---+ \qa-technologie
|   |   |   |   |
|   |   |   |   +--- qa-technologies-config.docker
|   |   |   |   +--- les autres fichiers de configuration utile à la construction de l'image de l'environnement de qa
|   |   |   |
|   |   |   +---+ \prod-technologie
|   |   |       |
|   |   |       +--- prod-technologies-config.docker
|   |   |       +--- les autres fichiers de configuration utile à la construction de l'image de l'environnement de prod
|   |   |   
|   |   +---+ \[autre technologie]   
|   |       +--- ...    
|   |
|   +--- dev-docker-compose.yaml
|   +--- global-docker-compose.yaml
|
|---+ \git-hooks-sources
|   |
|   +--- commit-msg 
|   +--- commit-msg.bat
|   +--- pre-commit
|   +--- pre-commit.bat
|   +--- pre-push
|   +--- pre-push.bat
|
|---+ \php-sources Dossier permettant d'utiliser php dans les scripts (*.bat)
|   |
|   +--- php-win64.zip
|   +--- php.ini
|
|---+ \readme-sources
|   |
|   +--- fichier besoin lors de la lecture du README.md
|
+--- init-project.bat   fichier d'initialiasation du projet
+--- .gitignore
+--- .dockerignore
+--- README.md
```

## Git-Hooks
Les git-hooks sont de simple **script** qui sont appelé par Git lors de l'**execution de différentes commandes git** tel git commit ou git push.

De base, lors de l'initialisation du template, il y aura **3 git-hooks** d'installer que vous pourrez retrouver et modifier dans le dossier 
``git-hooks-sources``.

**Attention** :  Les scripts à modifier ne sont que les scripts *.sh sauf cas particulier. Les scripts sans extension ne servent qu'à appeler les *.sh. Si vous
deviez faire une modification sur les scripts sans extension. Pensez à relancer le script d'initialisation du template pour qu'ils les recopient dans le dossier 
spécialement conçu par Git pour les git-hooks qui se trouve dans le dossier invisible à la racine du projet ``.git/hooks/``

### Pre-commit
Comme son nom l'indique le fichier pre-commit va s'exécuter juste **avant le commit**. Il servira à **appliquer les normes** de codages de Symfony (PSR-4) en 
utilisant **<a href="https://github.com/FriendsOfPHP/PHP-CS-Fixer">PHP CS-Fixer</a>**. 
### Commit-msg
Le git-hook commit-msg va s'executer **avant la fin d'un git commit**. Il va **vérifier la syntaxe du message du commit**. Dans notre cas, ce git-hooks est 
**bloquant** si la syntaxe n'est pas respectée.
### Pre-push
Le pre-push est utilisé juste **avant le push**. Nous avons fait en sorte que **PHP-Stan** analyse seulement les **fichiers qui ont été modifié**. Ce git-hook 
**n'est pas bloquant** mais il vous demandera de confirmer s'il le push si PHP-Stan a détecté des erreurs.

## Les analyseurs statiques
En plus des différents git-hooks installés, différents analyseurs statiques ont été installé. Ces différents analyseurs ont tous un script associé que l'on peut
retrouvé dans le dossier bin. Les scripts feront une analyse global du projet en enlevant les dossiers inutiles liés au devops.

La liste des différents analyseurs : 
* <a href="https://github.com/nunomaduro/phpinsights">PHP Insights</a>
* <a href="https://github.com/phpmd/phpmd">PHP Mess Detector</a>
* <a href="https://github.com/phpstan/phpstan">PHP Stan</a>
* <a href="https://github.com/squizlabs/PHP_CodeSniffer">Code Sniffer</a>

## Symfony
Nous avons installé symfony/skeleton et nous avons modifié le fichier bootstrap.php qui se trouve dans le dossier ``config`` pour qu'il cherche les différends 
.env dans le dossier environment-files.

De plus, nous avons installé quelques packages tel que : ``maker-bundle``, ``twig``, ``Doctrine annotations`` et ``ORM``.

## 🐳 Docker
Dans ce template vous retrouverez un conteneur NginX, PHP-Cli et PHP-FPM pour chaque environnements qui sont au nombre de trois (Dev, QA et Prod).
Vous retrouvez de nombreux scripts dans le dossier ``bin`` dont 3 scripts pour lancer les conteneurs de chaque environnement qui sont nommés de cette façon :
``build-[environnements]-docker-containers.bat``.

Il existe aussi des scripts pour rentrer dans chaque conteneur qui se nomme de cette façon : ``de[techno][env]``.

Ce petit tableau représente tous les dossiers que vous pourriez rencontrer lors du projet et où ils peuvent apparaître (Conteneurs / GIT / Votre machine local) 
et de quel manière ils arrivent dans les conteneurs (Volumes / Copy / Loaded).

Pensez à le mettre à jour !

**Volumes** : signifie qu'il a été monté par docker. Il y a un partage de fichier entre la machine local et le conteneur.

**Copy** : il signifie qu'une modification dans le conteneur n'entraîne pas de modification sur la machine locale et inversement.

**Loaded** peut signifier qu'il est généré par :️
* des Assets, Docker ...
* l'utilisateur de la machine locale

### Mise à disposition des dossiers / fichiers selon l'environnements
<table>
    <tr>
        <th rowspan="3">Dossier</th>
        <th rowspan="3">GIT</th>
        <th rowspan="3">Machine Locale (Dev)</th>
        <th colspan="9">Containers</th>
    </tr>
    <tr>
        <th colspan="3">NginX</th>
        <th colspan="3">PHP-FPM</th>
        <th colspan="3">PHP-CLI</th>
    </tr>
    <tr>
        <th>Dev</th>
        <th>QA</th>
        <th>Prod</th>
        <th>Dev</th>
        <th>QA</th>
        <th>Prod</th>
        <th>Dev</th>
        <th>QA</th>
        <th>Prod</th>
    </tr>
    <tr>
        <td>/git-hooks-sources</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
    </tr>
    <tr>
        <td>/devops-sources</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
    </tr>
    <tr>
        <td>/environment-files</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
    </tr>
    <tr>
        <td>/environment-files/.env.*.local</td>
        <td>❌️</td>
        <td>❌️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
    </tr>
    <tr>
        <td>/jenkins-jobs</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
    </tr>
    <tr>
        <td>/php-sources</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
    </tr>
    <tr>
        <td>/readme-sources</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
    </tr>
    <tr>
        <td>.dockerignore</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
    </tr>
    <tr>
        <td>.gitignore</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
    </tr>
    <tr>
        <td>README.md</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
    </tr>
    <tr>
        <td>*.bat</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
    </tr>
    <tr>
        <td>.editorconfig</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
    </tr>
    <tr>
        <td>/src</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
    </tr>
    <tr>
        <td>/templates</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
    </tr>
    <tr>
        <td>/public</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Volume</td>
        <td>Volume</td>
        <td>Volume</td>
        <td>Volume</td>
        <td>Volume</td>
        <td>Volume</td>
        <td>Volume</td>
        <td>Volume</td>
        <td>Volume</td>
    </tr>
    <tr>
        <td>/public/auto-généré</td>
        <td>❌️</td>
        <td>❌️</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
    </tr>
    <tr>
        <td>/config</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
    </tr>
    <tr>
        <td>/assets</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
    </tr>
    <tr>
        <td>/tests</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
    </tr>
    <tr>
        <td>/vendor</td>
        <td>❌️</td>
        <td>❌️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
    </tr>
    <tr>
        <td>/var</td>
        <td>❌️</td>
        <td>❌️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
        <td>Loaded</td>
    </tr>
    <tr>
        <td>/bin</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
    </tr>
    <tr>
        <td>/composer.phar</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
    </tr>
    <tr>
        <td>/composer.lock</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
    </tr>
    <tr>
        <td>/composer.json</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
    </tr>
    <tr>
        <td>/symfony.lock</td>
        <td>✔️</td>
        <td>✔️</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Ø</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
        <td>Volume</td>
        <td>Copy</td>
        <td>Copy</td>
    </tr>
</table>

### Les containeurs
Tous les conteneurs sont accessibles via un script qui se trouve dans le dossier ``bin``. Le nom des script ont été abrégé, il se nomme de cette manière :
``de[première lettre du nom de la technologie][première lettre de l'environnement]``

*Exemple : ``decp`` pour rentrer dans le conteneur php-cli de l'environnement de prod (``de`` fait référence à la commande ``docker exec`` qui permet de rentrer 
dans un conteneur).*

### .dockerignore
Nous avons créé le fichier ``.dockerignore`` de la manière suivante. On a d'abord enlevé tous les fichiers et dossiers que nous pouvons retrouver dans le 
template puis nous avons rajouté tous les fichiers qui sont utilisés dans les ``docker-compose`` ou ``dockerfile``.

## Les montées en version
### Symfony
Pour mettre à jour le template, il vous suffit de modifier le composer.json qui se trouve à la racine en changeant la version de Symfony si vous n'avez pas
encore commencé le projet.
Si vous avez commencé le projet je vous invite à regarder la documentation de Symfony (<a href="https://symfony.com/doc/current/setup/upgrade_major.html">Major
version</a> / <a href="https://symfony.com/doc/current/setup/upgrade_minor.html">Minor version</a>).
Pensez à changer la version de PHP si besoin comme indiqué ci-dessous.

### 🐘 PHP
* Remplacer ``7.2.*`` dans les composer.json (à la racine et dans devops-sources)
* Il suffit de remplacer :

    ``7.2-fpm`` par ``7.X-fpm`` ou par la **version** que vous avez choisi sur <a href="https://hub.docker.com/_/php">Docker Hub</a>
    
    ``7.2-cli`` par ``7.X-cli`` ou par la **version** que vous avez choisi sur <a href="https://hub.docker.com/_/php">Docker Hub</a>  
        
* Remplacer le zip dans php-sources par la version que vous voulez en gardant toujours la même convention de nommage.
* Rechercher les versions compatibles des plugins qui sont déjà installer tel que **php-cs-fixer**, **php-insights**, **php-stan**, **php-mess-detector**, 
**php-code-sniffer** et modifier le composer.json qui se trouve dans devops-sources.

**Attention** : vous aurez certainement des modifications à apporter suite aux changements de version.

### NginX
Il faut juste changer la version de NginX dans chaque dockerfile qui se trouve dans le dossier ``docker-sources/containers-config/NginX/[env]-NginX``.

**Attention** : il peut aussi avoir des changements de configuration de NginX du aux dernières mises à jour.
