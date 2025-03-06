# Specificeer de URL van je hubsite
$hubSiteUrl = "https://jouw-tenant.sharepoint.com/sites/Home"

# Verbind met de hubsite
Connect-PnPOnline -Url $hubSiteUrl -Interactive -ClientId $clientID -LaunchBrowser

# Haal de ID van de hubsite op
$hubSite = Get-PnPHubSite -Identity $hubSiteUrl

# Controleer of de hubsite correct is opgehaald
if ($null -eq $hubSite) {
    Write-Host "Hubsite niet gevonden. Controleer de URL." -ForegroundColor Red
    exit
}

# Haal alle sites op in de tenant
$sites = Get-PnPTenantSite

# Filter de sites die gekoppeld zijn aan de hubsite
$associatedSites = $sites | Where-Object { $_.HubSiteId -eq $hubSite.ID }

# Creëer een lijst om de URLs op te slaan
$siteUrls = @()

# Voeg de URLs van de gekoppelde sites toe aan de lijst
foreach ($site in $associatedSites) {
    $siteUrls += [pscustomobject]@{ URL = $site.Url }
}

# Exporteer de lijst naar een CSV-bestand
$siteUrls | Export-Csv -Path "C:\temp\hubsite-associated-sites.csv" -NoTypeInformation

Write-Host "De URLs van de gekoppelde sites zijn geëxporteerd naar C:\temp\hubsite-associated-sites.csv"
