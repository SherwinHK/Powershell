# SharePoint Online Management Script
# Dit script biedt een menu waarmee je eenvoudig taken in SharePoint Online kunt uitvoeren.
# Zorg ervoor dat je het SharePoint Online Management Shell-module hebt geïnstalleerd.

# Functie: Verbinden met de SharePoint Online Admin-site
function Connect-SPOService {
    param (
        [string]$AdminUrl
    )

    Write-Host "Verbinding maken met SharePoint Online Admin Center..." -ForegroundColor Cyan
    try {
        Connect-SPOService -Url $AdminUrl
        Write-Host "Succesvol verbonden met $AdminUrl" -ForegroundColor Green
    } catch {
        Write-Host "Er is een fout opgetreden bij het verbinden: $_" -ForegroundColor Red
    }
}

# Functie: Lijst van redirect-sites ophalen
function Get-RedirectSites {
    Write-Host "Ophalen van alle redirect-sites..." -ForegroundColor Cyan
    try {
        $redirectSites = Get-SPOSite -Template REDIRECTSITE#0
        $redirectSites | ForEach-Object { $_.Url }
    } catch {
        Write-Host "Er is een fout opgetreden bij het ophalen van redirect-sites: $_" -ForegroundColor Red
    }
}

# Functie: Verwijder een oude SharePoint-site
function Remove-Site {
    param (
        [string]$SiteUrl
    )

    Write-Host "Verwijderen van site: $SiteUrl..." -ForegroundColor Cyan
    try {
        Remove-SPOSite -Identity $SiteUrl -Confirm:$false
        Write-Host "Site $SiteUrl is succesvol verwijderd." -ForegroundColor Green
    } catch {
        Write-Host "Er is een fout opgetreden bij het verwijderen: $_" -ForegroundColor Red
    }
}

# Functie: Hernoem een SharePoint-site
function Rename-Site {
    param (
        [string]$OldUrl,
        [string]$NewUrl
    )

    Write-Host "Hernoemen van site van $OldUrl naar $NewUrl..." -ForegroundColor Cyan
    try {
        Start-SPOSiteRename -Identity $OldUrl -NewSiteUrl $NewUrl
        Write-Host "Site is succesvol hernoemd naar $NewUrl." -ForegroundColor Green
    } catch {
        Write-Host "Er is een fout opgetreden bij het hernoemen: $_" -ForegroundColor Red
    }
}

# Hoofdmenu
function Show-Menu {
    Write-Host "--------------------------" -ForegroundColor Yellow
    Write-Host " SharePoint Online Tools " -ForegroundColor Yellow
    Write-Host "--------------------------" -ForegroundColor Yellow
    Write-Host "1. Verbinden met SPO Admin Center"
    Write-Host "2. Lijst van redirect-sites ophalen"
    Write-Host "3. Oude site verwijderen"
    Write-Host "4. Site hernoemen"
    Write-Host "5. Afsluiten"
}

# Hoofdprogramma
while ($true) {
    Show-Menu
    $choice = Read-Host "Kies een optie"

    switch ($choice) {
        "1" {
            $adminUrl = Read-Host "Voer de Admin Center URL in (bijv. https://contoso-admin.sharepoint.com)"
            Connect-SPOService -AdminUrl $adminUrl
        }
        "2" {
            Get-RedirectSites
        }
        "3" {
            $siteUrl = Read-Host "Voer de URL van de site in die je wilt verwijderen"
            Remove-Site -SiteUrl $siteUrl
        }
        "4" {
            $oldUrl = Read-Host "Voer de huidige URL van de site in"
            $newUrl = Read-Host "Voer de nieuwe URL van de site in"
            Rename-Site -OldUrl $oldUrl -NewUrl $newUrl
        }
        "5" {
            Write-Host "Afsluiten..." -ForegroundColor Cyan
            break
        }
        default {
            Write-Host "Ongeldige keuze. Probeer opnieuw." -ForegroundColor Red
        }
    }
}
