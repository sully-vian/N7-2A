# HagiMule

## Idée

DownloadTask demande les hôtes et coupe le fichier en blocs de 1024 octets (ou plus) et répartit les requêtes de blocs entre les hôtes. On peut donc avoir plusieurs blocs demandés à un même hôte.

L'idéal serait que les fragments ne soient pas répartis initialement, mais qu'on les donne au fure et à mesure que lmes tâches se terminent.

Pour ce genre de concurrence, il faut utiliser un ThreadPoolExecutor.

## Idée 2

DownloadTask demande les hôtes et coupe le fichier en autant de blocs qu'il y a d'hôtes. Chaque bloc est demandé à un hôte différent.

Chaque DownloaderSlave est un thread qui demande le fragment par bouts de 1024 octets (ou plus).

## Ressources

[site Hagimont](https://sd-160040.dedibox.fr/hagimont/resources-N7/teaching-N7.html)

[sujet](doc/sujet.pdf)

## Utilisation

[`build.sh`](scripts/build.sh) : compile le projet dans le dossier [`bin`](bin).

[`clean.sh`](scripts/clean.sh) : supprime le contenu du dossier [`bin`](bin).

[`client.sh`](scripts/client.sh) : lance le client en mode srveur ou downloader en fonction de l'option 0 ou 1.

[`diary.sh`](scripts/diary.sh) : lance le serveur de l'annuaire.

[`gui.sh`](scripts/gui.sh) : lance l'interface graphique du client.

[`test.sh`](scripts/test.sh) : compile et lance la suite de tous les tests (trouvables dans [`src/fr/n7/hagimule/test`](src/fr/n7/hagimule/test)).
