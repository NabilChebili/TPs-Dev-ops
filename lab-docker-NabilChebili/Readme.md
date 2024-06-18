# TP 3 : Docker

## Instructions
Les réponses aux questions posées dans cet énoncé doivent être soumises sous forme de fichiers nommés en fonction du numéro de la question au sein de votre repository, dans le dossier `answers`. 
Chaque réponse fera l'objet d'une nouveau fichier dans votre repo. 
> Les questions requérant une réponse sous forme de fichier seront taggées par l'icone suivante: ⚠️  Ces fichiers sont corrigés automatiquement par Github Autograde

> Les commits ne sont pas facultatifs. **Commitez au minimum dès que l'énoncé vous le demande**.

Le TP doit être rendu individuellement et se basera sur les réponses présentes dans les fichiers du dossier `answers`, ainsi que sur le code présent dans vos repositories personnels.

## Rappels
### Docker
* Concepts
  * Build
  * Ship
  * Run
  * Pull
  * Push
* [Docker doc reference](https://docs.docker.com/reference/)
  * [Dockerfile](https://docs.docker.com/engine/reference/builder/)
  * [docker-compose.yml](https://docs.docker.com/compose/compose-file/)
* [Play with Docker](https://labs.play-with-docker.com/)

---
---
---

## 0 : Description du projet
Tout au lond de ce tp, nous allons nous baser sur le projet situé dans le répertoire app de ce repo. Cette application est composée d'un front html qui appelle une api rest (back) qui lui renvoie des informations.

L'application renvoie différentes informations sur:
* l'heure d'appel
* l'environnement dans lequel le backend à été déployée (nom de l'environnement)
* l'URL appelée
* le hostname du backend

Le service backend peut être requêtée sur :
* un path commançant par /get/{something} (ex: http://localhost:8080/get/toto)
* ou sur le path /write/{something_to_write} (ex: http://localhost:8081/write/something_to_write)

Un appel sur le path /write du backend, engendrera une écriture de l'argument passé en paramètre dans un fichier de log situé dans le container back.

## 1 : Docker
Cette première partie est à réaliser individuellement.

### 1.0 : Installer Docker
Pour le TP suivant, vous utiliserez [Play with Docker](https://labs.play-with-docker.com/) qui est un site vous permettant d'obtenir une machine virtuelle gratuite dans le cloud. Cette machine reste disponible pendant 4h puis est détruite. Pensez donc bien commiter et pusher tous vos changements régulièrement.

Pour les prochains TP, afin de faciliter la création d'images Docker, je vous invite à installer Doker sur votre poste. Pour cela, suivez [la doc officielle](https://docs.docker.com/get-docker/)

### 1.1 : Comprendre l'app
Inspectez les fichiers contenus dans le repertoire **app** pour comprendre la structure du projet.

### 1.2 : Let's Build it
Dans le répertoire app/back, créez un fichier **Dockerfile** capable de builder une image python contenant notre code back.

Help:
* Consultez la [Dockerfile reference documentation](https://docs.docker.com/engine/reference/builder/)
* Se baser sur une image python présente dans Docker Hub [Docker Hub](https://hub.docker.com/)
* Python utilise des libraires à installer sur un host avant de pouvoir démarrer le programme. Pour installer ces libraires, exécuter la commande suivante (dans le Dockerfile)
```bash
pip install -r requirements.txt
```
* Suite à l'installation des librairies Python, la commande à lancer dans l'image Docker est
```bash
python3 -m flask run --host=0.0.0.0
```
* la commande **WORKDIR** peut aider

### 1.3 : Un premier lancement pas très concluant
Lancez un container à partir de l'image Docker que vous venez de créer.

> ⚠️  **ANSWER**: Créez un fichier s'intitulant `1.3` ayant pour contenu les commandes que vous avez effectué pour lancer le container.

### 1.4 : Accéder au service
Essayez d'accéder à l'application sur l'URL indiquée par les logs. (:warning:) A votre avis, pourquoi, cette adresse ne répond pas ? 

Redémarrez le container en ouvrant les ports nécessaires pour accéder au service.
> ⚠️  **ANSWER**: Créez un fichier s'intitulant `1.4` ayant pour contenu les commandes que vous avez effectué pour démarrer le container avec les ports ouverts.

### 1.5 : Env var
Essayez d'accéder à l'application sur l'URL indiquée par les logs. Retournez dans votre terminal, vous êtes gratifiés par une belle stacktrace d'erreur. Cette erreur survient car le programme s'attend à trouver la variable d'environnement **ENVIRONMENT** présente dans le container.

Redémarrez le container en ajoutant la variable d'environnement manquante pour que le service réponde correctement (vous pouvez mettre la valeur que vous préférez).

> ⚠️  **ANSWER**: Créez un fichier s'intitulant `1.5` ayant pour contenu la commande que vous avez effectué pour démarrer le container avec la variable d'environnement et les ports ouverts.

L'application démarre correctement et vous pouvez y accéder en suivant l'URL affichée par les logs.

### 1.6 : Let's Ship it
Afin de partager votre nouvelle création fantastique avec le monde, nous allons pousser l'image sur la registry officielle Docker appelée Docker Hub (ou Docker Store)

Pour cela: 
* Créez vous un compte sur [Docker Hub](https://hub.docker.com/)
* Créez vous un nouveau repository rattaché à votre compte
* Puis, pousser votre image fraichement créée sur votre repository

Votre image ne peut pas être poussée telle qu'elle est. (:warning:) Pourquoi ? Modifiez le nom de votre image et poussez la à nouveau sur votre repository Docker Hub.

> ⚠️  **ANSWER**: Créez un fichier s'intitulant `1.6` ayant pour contenu les commandes que vous avez effectué pour les commandes que vous avez effectué pour pousser votre image sur Docker Hub.

### 1.7 : Faire table rase
Maintenant votre image partagée avec le monde, vous pouvez la puller depuis n'importe quelle machine sur laquelle Docker est installé.

Supprimez toutes vos images créée depuis le début du tp sur votre machine.

> ⚠️  **ANSWER**: Créez un fichier s'intitulant `1.7` ayant pour contenu les commandes que vous avez effectué pour supprimer toutes les images créée depuis le début du tp.

### 1.8 : Let's Run it
Relancez maintenant un container en vous basant sur l'image que vous venez de pousser dans votre repository Docker Hub. (:warning:) Que se passe t'il avant que l'image démarre ?

Votre container fonctionne comme espéré mais si vous fermez votre terminal, celui-ci se stoppe. Relancez le container en mode détaché et vérifiez que le container est accessible via son interface web.

> ⚠️  **ANSWER**: Créez un fichier s'intitulant `1.8` ayant pour contenu les commandes que vous avez effectué pour lancer le container en mode détaché.

### 1.9 : Le naming, c'est important
Votre container semble être démarré. En mode détaché, quelle commande vous permet d'observer que le container est bien démarré ? (:warning:) Quel est le nom de votre container ?.

> ⚠️  **ANSWER**: Créez un fichier s'intitulant `1.9.1` ayant pour contenu les commandes que vous avez effectué pour observer l'état du container.

Redémarrez votre container en le renommant avec un nom ayant du sens.

> ⚠️  **ANSWER**: Créez un fichier s'intitulant `1.9.2` ayant pour contenu les commandes que vous avez effectué pour nommer votre container.


### 1.10 : Go inside
Votre container back à présent démarré, ouvrir une session interactive pour observer les fichiers à l'interieur du container. Après avoir ouvert une session interactive, exécuter la commande suivante permettant de récupérer des infos sur l'OS utilisé dans le container:
```bash
cat /etc/*release
```
(:warning:) Quel est l'OS utilisé dans le container ?

> ⚠️  **ANSWER**: Créez un fichier s'intitulant `1.10` ayant pour contenu les commandes que vous avez effectué pour démarrer une session interactive.

### 1.11 : Do it again (comme dirait Steely [BP])
Placez vous dans le répertoire app/front et réalisez toutes les étapes de la partie 1.2 à 1.10 pour créer l'image front de notre application.

> :warning: **WARNING**: Ne pas créer de fichier réponse pour la partie front. Le but de cette question est d'avoir un container front fonctionnel prêt à s'intégrer avec le back de notre application.

> :warning: **WARNING**: Le frontend est une simple page html. Vous devez donc partir d'une autre image de base.

Help: 
* Vous devez utiliser une autre image de base (nginx par exemple)
* Faites bien attention, vous devez utiliser un entrypoint présent dans le répertoire front. Voir la doc https://docs.docker.com/engine/reference/builder/#exec-form-entrypoint-example
* Les variables d'environnement à setter sont : **WS_BACK_URL**
* Si les deux services sont démarrés, attention à l'exposition des ports pour ne pas être en conflit1

> N'oubliez pas de pusher votre image sur votre registry docker hub

### 1.12 : C'est mieux à deux
Lancez votre container back en même temps que votre container front et modifier les variables d'environnement du front pour intégrer les deux (indice: ça devrait se passer au niveau du WS_BACK_URL).

> ⚠️  **ANSWER**: Créez un fichier s'intitulant `1.12` ayant pour contenu les commandes que vous avez effectué pour démarrer un container front pointant sur le container back.

### 1.13 : Test des urls de write
Utilisez le path `/write` de l'URL du backend pour écrire dans le fichier log du container back.
Vérifiez le contenu du fichier log en se connectant en mode interactif au container back.

### 1.14 : Clean-up
Stoppez tous les containers et supprimez toutes les images locales que vous avez créé jusqu'ici.

> ⚠️  **ANSWER**: Créez un fichier s'intitulant `1.14` ayant pour contenu les commandes que vous avez effectué pour stopper tous les containers.

---
---
---

## 2 : Docker Compose
Dans cette partie, nous allons utiliser docker-compose pour automatiser le déploiement des containers que nous avons lancés dans la partie 1 du tp.

### 2.0 : Télécharger docker-compose
Docker est disponible dans Play with Docker.

Cependant, si vous avez installé Docker sur votre poste et que vous voulez installer docker-compose aussi, allez sur [le site officiel](https://docs.docker.com/compose/install/) et suivez les instructions officielles

---

> Attention: Vérifier que vous avez bien stoppé tous vos containers avant de démarrer cette partie.

### 2.1 : Création du docker compose
A la racine du répertoire app, créez un ficher docker-compose.yml contenant le code suivant:
```yaml
version: '3'
services:
  mon-service:
    image: mon-image
```

Editez le fichier pour pointer sur votre image back et renommez le service comme vous le souhaitez. Puis, démarrez le service back à l'aide des commandes **docker-compose** 

> Documentation disponible sur [le site officiel](https://docs.docker.com/compose/reference/)

> ⚠️  **ANSWER**: Créez un fichier s'intitulant `2.1` ayant pour contenu les commandes que vous avez effectué pour démarrer le service back via docker-compose. 

### 2.2 : Ports
Modifiez le docker-compose.yml pour ajouter un montage sur le port accessible du service back.

Relancez le container et tester la solution.

### 2.3 : Env var
Modifiez le docker-compose.yml pour ajouter la variable d'environnement nécessaire à l'utilisation du service back.

Relancez le container et tester la solution.

### 2.4 : A deux c'est mieux
Modifiez le docker-compose.yml pour ajouter le service front. Ne pas oublier de renseigner les ports et variables d'environnement.

Relancez les container et tester la solution.

### 2.5 : Détachez le !
Relancez l'ensemble des services en mode détaché.

> ⚠️  **ANSWER**: Créez un fichier s'intitulant `2.6.1` ayant pour contenu les commandes que vous avez effectué pour lancer l'ensemble des services en mode détaché.

Visualisez les logs des différents services en même temps.

> ⚠️  **ANSWER**: Créez un fichier s'intitulant `2.6.2` ayant pour contenu les commandes que vous avez effectué pour visualiser tous les logs des différentes services en même temps.

### 2.6 : Persistence
Les services sont maintenant lancés correctement via docker-compose. Cependant, à chaque redémarrage, les données sont flushées.

Modifiez le docker-compose.yml pour ajouter un montage de volume afin de persister les données sur le disque entre les redémarrages.

> Attention: Après cette étape, commenter les lignes relatives au montage de volume dans le docker-compose.yml

### 2.7 : Upgrade
A tout moment, lorsque vous avez lancé vos services en mode detaché, vous pouvez recharger une nouvelle version en exécutant la ligne ci-dessous à nouveau:
```bash
docker-compose up -d
```

### 2.8 : Scaling de l'espace
Les services doivent être démarrés en mode détaché. Essayer de scaler le webservice back en triplant le nombre de container back démarrés.

> ⚠️  **ANSWER**: Créez un fichier s'intitulant `2.8` ayant pour contenu les commandes que vous avez effectué pour scaler le webservice back.

Vérifier que les hostnames changent dans la UI.

Et c'est tout bon !
