# 1.
Qu'est-ce qu'une instance Virtual Machine ?
Une machine virtuelle est une machine qui a les mêmes caractéristiques que une machine physique (processeur,ram,gpu...) mais fonctionnant sur l'environement d'une autre machine physique. 

# 2.
Qu'est-ce qu'un VNET ?
LE VNET est un réseau virtuel mis en place par Azure permet aux ressources de communiquer entre elles.

# 3.
A quoi sert un NSG ?
Le Network Security Group est un parefeu permettant de controler les connexions entrantes et sortantes des ressources Azure.

# 4.
Quelles sont les 5 propriétés désirables du cloud ?
-Libre service
-Elasticité rapide
-Service doit être meusurable
-Accés à partir du réseau internet
-Mutualisation des ressources

# 5.
Qu'est-ce que l'A/B Testing ?
L'A/B testing permet de faire tester à une certaines partie des utilisateurs une nouvelle fonctionnalité et d'en avoir les retours. La meilleure version est ensuite gardée.

# 6.
Comment programmer le cloud ?
On a 3 méthodes : 
-IaaS : Proposition de la location d'un serveur et de stockage
-Paas : Outils de construction des applications mis en place
-SaaS : Ici c'est le client qui utilise une application déjà crée

# 7.
Quelle est la technique pour faire un déploiement sans interruption de service ?
Zero Downtime Deployement

# 8.
Qu'est-ce que le Canary release ?
On deploye l'application et on la propose pour certains utilisateurs. On vérifie ensuite son état de santé avec des indicateurs.

# 9.
Comment changer de taille de machine virtuelle ?
Sur Azure, on se sert de du --size. Il existe plusieurs format différents en fonction des fournisseurs.

# 10.
Qu'est-ce que le Blue/Green deployment ?
Nous avons en place deux version, une utilisé et une nouvelle. le but est de faire tester progressivement aux utilisateurs la nouvelle d'en le but d'avoir des retours continu. Si cela se passe bien, au final la nouvelle version est accessible par tout les utlisateurs. L'ancienne version est la "blue" et la nouvelle est la "green".