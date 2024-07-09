# Parameters
param(
  [switch]$FirstRun = $true
)

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
$debloat_argument_list = @(
  '-RemoveApps',
  '-RemoveW11Outlook',
  '-DisableDVR',
  '-RemoveDevApps',
  '-DisableTelemetry',
  '-ShowHiddenFolders',
  '-ShowKnownFileExt',
  '-ShowSearchLabelTb',
  '-HideTaskview',
  '-HideChat',
  '-DisableWidgets',
  '-DisableCopilot',
  '-HideOnedrive',
  '-Hide3dObjects'
)
if ($FirstRun) {
  $debloat_argument_list += '-ClearStart'
}
& ([scriptblock]::Create((Invoke-RestMethod "https://raw.githubusercontent.com/Raphire/Win11Debloat/master/Get.ps1"))) -Silent $debloat_argument_list.Join(' ')

# If wsl not installed, install it
$wsl_install = wsl --list --quiet
if (-not $wsl_install) {
  Write-Output "Installing WSL"
  wsl --install
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