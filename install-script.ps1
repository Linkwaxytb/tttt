# Script d'installation pour l'application

$ErrorActionPreference = "Stop"

# Afficher un message de bienvenue
Write-Host "Bienvenue dans le programme d'installation de l'application 'NomDeTonApp'!" -ForegroundColor Green

# Définir le répertoire d'installation (par exemple dans le dossier "Program Files" ou un répertoire dédié)
$installDir = "C:\Program Files\NomDeTonApp"
if (-Not (Test-Path $installDir)) {
    Write-Host "Création du répertoire d'installation..." -ForegroundColor Yellow
    New-Item -Path $installDir -ItemType Directory
}

# Télécharger le fichier d'application (par exemple un exécutable ou des fichiers nécessaires)
$downloadUrl = "https://github.com/Linkwaxytb/tttt/releases/download/v1.0/MonApp.exe"
$destination = "$installDir\MonApp.exe"

Write-Host "Téléchargement de l'application depuis $downloadUrl..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $downloadUrl -OutFile $destination

# Vérifier si le téléchargement a réussi
if (Test-Path $destination) {
    Write-Host "Application téléchargée avec succès à $destination" -ForegroundColor Green
} else {
    Write-Host "Erreur lors du téléchargement de l'application." -ForegroundColor Red
    exit 1
}

# Créer un raccourci sur le bureau pour l'utilisateur
$desktop = [System.Environment]::GetFolderPath('Desktop')
$shortcutPath = "$desktop\NomDeTonApp.lnk"

Write-Host "Création du raccourci sur le bureau..." -ForegroundColor Yellow

$wsh = New-Object -ComObject WScript.Shell
$shortcut = $wsh.CreateShortcut($shortcutPath)
$shortcut.TargetPath = $destination
$shortcut.IconLocation = $destination
$shortcut.Save()

Write-Host "Installation terminée avec succès!" -ForegroundColor Green
Write-Host "Raccourci créé sur le bureau." -ForegroundColor Green
Write-Host "Appuyez sur une touche pour quitter..." -ForegroundColor Green

# Attendre que l'utilisateur appuie sur une touche
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
