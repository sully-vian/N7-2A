# HagiMule

[site Hagimont](https://sd-160040.dedibox.fr/hagimont/resources-N7/teaching-N7.html)

## Logique de l'application

### Client

Lancement client:

- Démarrage en mode serveur
- Démarrage en mode client

Client en mode serveur:

- Envoi à l'annuaire de la liste des fichiers disponibles
- Démarrage d'une écoute de requête de téléchargement de fichier par un autre client

Client en mode client:

- Requête à l'annuaire pour obtenir la liste des fichiers disponibles (avec les clients possédant le fichier)

### Annuaire

Lancement annuaire:

- démarrage écoute de requêtes (POST/GET)
- gestion des requêtes

Réception requête POST:

- Ajout du client à la liste des clients possédant le fichier

Réception de requête GET:

- Envoi de la liste des fichiers disponibles (avec les clients possédant le fichier)

## Interface

### Client

Mode Client:

- **Bouton "Recharger":** Recharge la liste des fichiers disponibles
- **Menu Déroulant "Fichier":** Permet de choisir le fichier à télécharger
- **Bouton "Télécharger":** Télécharge le fichier sélectionné
- **Bouton "Décompresser":** Décompresse le fichier sélectionné vers l'emplacement choisi

Mode Serveur:


- **Bouton Fichier "Ajouter":** Copie le fichier sélectionné et le compresse à la liste des fichiers servables
- **Menu Déroulant "Fichiers disponibles":** Liste des fichiers servables
- **Bouton Fichier "Supprimer":** supprime fichier servable et envoie requête à l'annuaire pour s'enlever de la liste des clients possédant le fichier

### Annuaire

pas d'interface
