# Parameters
param(
  [switch]$FirstRun
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
  'Spotify.Spotify', # Can't be installed as admin
  'EpicGames.EpicGamesLauncher',
  'AntibodySoftware.WizTree',
  'Notepad++.Notepad++',
  'FxSoundLLC.FxSound',
  'Git.Git',
  'Discord.Discord',
  'Nvidia.GeForceExperience',
  'Ubisoft.Connect',
  'ZeroTier.ZeroTierOne',
  'ElectronicArts.EADesktop'
)
$CurrentDateTime = Get-Date -Format "yyyy-MM-dd-HH-mm-ss"
$logFile = "C:\temp\winget-$($CurrentDateTime).log"

# Debloat Windows 11
$debloat_parameters = @{
  RemoveApps        = $true
  RemoveW11Outlook  = $true
  DisableDVR        = $true
  RemoveDevApps     = $true
  DisableTelemetry  = $true
  ShowHiddenFolders = $true
  ShowKnownFileExt  = $true
  ShowSearchLabelTb = $true
  HideTaskview      = $true
  HideChat          = $true
  DisableWidgets    = $true
  DisableCopilot    = $true
  HideOnedrive      = $true
  Hide3dObjects     = $true
}

if ($FirstRun) {
  $debloat_parameters.ClearStart = $true
}
& ([scriptblock]::Create((Invoke-RestMethod "https://raw.githubusercontent.com/Raphire/Win11Debloat/master/Get.ps1"))) -Silent @debloat_parameters

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