# Lab Terraform

## Instructions
Durant ce TP, nous allons mettre en oeuvre Terraform comme vu durant le cours. Le principe de ce TP sera de déployer Petclinic sur l'infrastructure que propose Azure (IaaS) en n'utilisant uniquement que Terraform. Chaque réponse sera à rendre sous forme de **Pull Request** dans le repository. Chaque étudiant devra alors commiter les fichiers Terraform nécessaire à la création des environnements.

Un bref rappel de l'architecture de l'application
![Architecture](https://spring-petclinic.github.io/images/petclinic-microservices-architecture.png "Architecture")

Le TP est découpé en deux parties : le fichier `README.md` suivant, ainsi qu'un dossier `answer` qui contiendra la totalité des fichiers Terraform à rendre pour ce TP.

## 1 : Git
### 1.0 : Forker le repo du lab
Suivre le lien présent au tableau pour forker ce repository dans votre repository personnel GitHub Classroom. Si vous avez accès au repository, cela veut dire que la manipulation a bien fonctionné.

### 1.1 : Cloner le repository
Clonez le repo nouvellement copié sur votre ordinateur 
> A partir de maintenant, **vous ne travaillerez plus que dans votre copie**. Vous n'avez plus à revenir sur [le projet parent](https://github.com/devops-cloud-courses/lab-terraform).

Pour des questions de simplicité, les fichiers `main.tf` et `provider.tf` sont fournis.

## 2 : Terraform
### 2.0 : Installation de Terraform
Afin de pouvoir effectuer ce TP, il est nécessaire d'installer **Terraform**. La page d'installation de Terraform est disponible à l'adresse suivante : https://www.terraform.io/downloads.html

### 2.1 : Accès à votre compte Azure
Pour pouvoir déployer des ressources sur Azure, il est nécessaire de s'authentifier auprès d'Azure. Pour se faire, vous devriez avoir accès à un fichier `password.txt` qui contient vos logins et mot de passe pour Azure. Ce fichier est découpé par bloc. Votre login et mot de passe se trouve dans le bloc ou `displayName` contient votre `prenom.nom`.

Il est nécessaire de faire un export de deux variables d'environnements pour que Terraform puisse créer des ressources sur Azure. Ces deux variables sont `ARM_CLIENT_ID` qui sera la valeur `appId` du bloc, et `ARM_CLIENT_SECRET` qui sera la valeur `password` du bloc.
```
$ export ARM_CLIENT_ID="appId"
$ export ARM_CLIENT_SECRET="password"
$ terraform init
```

## 3 : IaaS
### 3.0 : Installation de PetClinic
Le principe de ce TP est de créer le(s) fichier(s) nécessaire(s) pour la création d'une machine virtuelle contenant PetClinic. PetClinic est une application Java disponible à l'adresse suivante : https://github.com/spring-projects/spring-petclinic/.

Des fichiers sont déjà présent dans le dossier `answer`, notamment la `datasource` de votre `resource-group`. Il faut donc au préalable remplir le fichier `variables.tf` avec votre nom de compte Azure.

Pour ce TP, il est nécessaire de créer les objets suivants sur Azure :
- [azurerm_linux_virtual_machine](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine)
- [azurerm_virtual_network](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)
- [azurerm_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet)
- [azurerm_network_interface](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface)
- [azurerm_network_security_group](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group)
- [azurerm_public_ip](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip)
- [azurerm_network_interface_security_group_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface_security_group_association)


Afin de pouvoir interragir avec la machine virtuelle nouvellement créée, il sera nécessaire de passer par un provisionner de type [`remote-exec`](https://www.terraform.io/docs/provisioners/remote-exec.html).

Pour compiler PetClinic, il est nécessaire d'installer `OpenJDK 8` sur la machine, puis de lancer la commande `./mvnw package`

> ⚠️  **WARNING**: Penser à bien commiter les fichiers dans le dossier correspondant

> ⚠️  **WARNING**: Une fois les fichiers créés et commités, penser à bien détruire les ressources Azure créées avec la commande `terraform destroy`
