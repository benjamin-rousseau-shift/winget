# Variables
$Apps = @(
  'jazzdelightsme.WingetPathUpdater',
  '7zip.7zip',
  'Brave.Brave',
  'GOG.Galaxy',
  'Plex.Plex',
  'ShareX.ShareX',
  'Valve.Steam',
  'VideoLAN.VLC',
  'Microsoft.VisualStudioCode',
  'MOTU.MSeries',
  'Spotify.Spotify',
  'EpicGames.EpicGamesLauncher',
  'AntibodySoftware.WizTree',
  'Notepad++.Notepad++',
  'FxSoundLLC.FxSound',
  'Git.Git',
  'Discord.Discord'
)
$CurrentDateTime = Get-Date -Format "yyyy-MM-dd-HH-mm-ss"
$logFile = "C:\temp\winget-$($CurrentDateTime).log"

# Debloat Windows
& ([scriptblock]::Create((Invoke-RestMethod "https://raw.githubusercontent.com/Raphire/Win11Debloat/master/Get.ps1"))) -RunDefaults -Silent

# Install wsl
try {
  wsl --install
}
catch {
  Write-Output "WSL already Installed"
}

# Create temp directory
if (-not (Test-Path "C:\temp")) {
  New-Item -ItemType Directory -Path "C:\temp"
}

# For each app in the list, install it using winget
foreach ($App in $Apps) {
  Write-Output "Installing $App"
  winget install -e --id $App --silent --accept-package-agreements --accept-source-agreements --log $logFile
}