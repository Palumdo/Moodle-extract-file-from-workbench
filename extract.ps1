# Charger le fichier XML des fichiers
[xml]$fileData = Get-Content -Path 'files.xml' -Encoding UTF8

# Charger le fichier XML des utilisateurs
[xml]$userData = Get-Content -Path 'users.xml' -Encoding UTF8

# Créer le répertoire '_devoir' s'il n'existe pas déjà
$homeworkDir = Join-Path -Path 'files' -ChildPath '_devoir'
if (!(Test-Path -Path $homeworkDir)) {
    New-Item -ItemType Directory -Path $homeworkDir
}

# Parcourir chaque élément 'file' dans le fichier XML des fichiers
foreach ($file in $fileData.files.file) {
    # Vérifier si le composant est 'mod_workshop'
    if ($file.component -eq 'mod_workshop') {
        # Récupérer l'ID de l'utilisateur
        $userId = $file.userid

        # Rechercher l'utilisateur correspondant dans le fichier XML des utilisateurs
        $user = $userData.users.user | Where-Object { $_.id -eq $userId }

        # Si l'utilisateur est trouvé
        if ($user) {
            # Récupérer le nom d'utilisateur
            $username = $user.username

            # Créer un sous-répertoire pour l'utilisateur s'il n'existe pas déjà
            $userDir = Join-Path -Path $homeworkDir -ChildPath $username
            if (!(Test-Path -Path $userDir)) {
                New-Item -ItemType Directory -Path $userDir
            }

            # Construire le chemin du fichier source
            $sourcePath = Join-Path -Path 'files' -ChildPath $file.contenthash.Substring(0, 2)
            $sourcePath = Join-Path -Path $sourcePath -ChildPath $file.contenthash

            # Vérifier si le fichier source existe
            if (Test-Path -Path $sourcePath) {
                # Construire le chemin du fichier de destination
                $destinationPath = Join-Path -Path $userDir -ChildPath $file.source

                # Déplacer le fichier
                Move-Item -Path $sourcePath -Destination $destinationPath

                # Lire le contenu du fichier en UTF-8
                $content = Get-Content -Path $destinationPath -Encoding UTF8

                # Écrire le contenu du fichier en UTF-8
                $content | Set-Content -Path $destinationPath -Encoding UTF8
            }
        }
    }
}
pause