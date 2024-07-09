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
$WindowsBloatwares = @(
  'Clipchamp.Clipchamp',
  'Microsoft.3DBuilder',
  'Microsoft.549981C3F5F10', #Cortana app
  'Microsoft.BingFinance',
  'Microsoft.BingFoodAndDrink',            
  'Microsoft.BingHealthAndFitness',        
  'Microsoft.BingNews',
  'Microsoft.BingSports',
  'Microsoft.BingTranslator',
  'Microsoft.BingTravel',
  'Microsoft.BingWeather',
  'Microsoft.Getstarted', # Cannot be uninstalled in Windows 11
  'Microsoft.Messaging',
  'Microsoft.Microsoft3DViewer',
  'Microsoft.MicrosoftJournal',
  'Microsoft.MicrosoftOfficeHub',
  'Microsoft.MicrosoftPowerBIForWindows',
  'Microsoft.MicrosoftSolitaireCollection',
  'Microsoft.MicrosoftStickyNotes',
  'Microsoft.MixedReality.Portal',
  'Microsoft.NetworkSpeedTest',
  'Microsoft.News',
  'Microsoft.Office.OneNote',
  'Microsoft.Office.Sway',
  'Microsoft.OneConnect',
  'Microsoft.Print3D',
  'Microsoft.SkypeApp',
  'Microsoft.Todos',
  'Microsoft.WindowsAlarms',
  'Microsoft.WindowsFeedbackHub',
  'Microsoft.WindowsMaps',
  'Microsoft.WindowsSoundRecorder',
  'Microsoft.XboxApp', # Old Xbox Console Companion App, no longer supported
  'Microsoft.ZuneVideo',
  'MicrosoftCorporationII.MicrosoftFamily', # Family Safety App
  'MicrosoftCorporationII.QuickAssist',
  'MicrosoftTeams', # Old MS Teams personal (MS Store)
  'MSTeams'   # New MS Teams app
)
$CurrentDateTime = Get-Date -Format "yyyy-MM-dd-HH-mm-ss"
$logFile = "C:\temp\winget-$($CurrentDateTime).log"

# We Uninstall Windows Bloatwares
foreach ($App in $WindowsBloatwares) {
  Write-Output "Uninstalling $App"
  Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -AllUsers
}

# Install wsl
wsl --install

# Create temp directory
if (-not (Test-Path "C:\temp")) {
  New-Item -ItemType Directory -Path "C:\temp"
}

# For each app in the list, install it using winget
foreach ($App in $Apps) {
  Write-Output "Installing $App"
  winget install -e --id $App --silent --accept-package-agreements --accept-source-agreements --log $logFile
}