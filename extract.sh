#!/bin/bash

# Charger le fichier XML des fichiers
fileData="files.xml"

# Charger le fichier XML des utilisateurs
userData="users.xml"

# Créer le répertoire '_devoir' s'il n'existe pas déjà
homeworkDir="files/_devoir"
mkdir -p "$homeworkDir"

# Parcourir chaque élément 'file' dans le fichier XML des fichiers
xmlstarlet sel -t -m "//file[component='mod_workshop']" -v "concat(contenthash,' ',userid,' ',source)" -n $fileData | while read contenthash userid source; do
    # Récupérer le nom d'utilisateur
    username=$(xmlstarlet sel -t -m "//user[@id='$userid']" -v "username" -n $userData)

    # Si l'utilisateur est trouvé
    if [ ! -z "$username" ]; then
        # Créer un sous-répertoire pour l'utilisateur s'il n'existe pas déjà
        userDir="$homeworkDir/$username"
        mkdir -p "$userDir"

        # Construire le chemin du fichier source
        sourcePath="files/${contenthash:0:2}/$contenthash"

        # Vérifier si le fichier source existe
        if [ -f "$sourcePath" ]; then
            # Construire le chemin du fichier de destination
            destinationPath="$userDir/$source"

            # Déplacer le fichier
            mv "$sourcePath" "$destinationPath"
        fi
    fi
done
