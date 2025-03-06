# PowerShell Scripts voor Azure, SharePoint en Exchange Online

Dit GitHub-project bevat een verzameling PowerShell-scripts voor het beheren van Azure AD, SharePoint Online en Exchange Online. De scripts zijn geoptimaliseerd voor consistentie, herbruikbaarheid en best practices.

## 📂 Overzicht van de scripts

| Scriptnaam | Beschrijving |
|------------|-------------|
| **Export-Exchange-DistGroups.ps1** | Exporteert leden van alle distributiegroepen in Exchange Online naar een CSV-bestand. |
| **Save-Sent-Items-SharedMailbox.ps1** | Zorgt ervoor dat verzonden e-mails van een gedeelde mailbox worden opgeslagen in de "Verzonden items". |
| **Find-User-Mailbox-Permissions.ps1** | Zoekt alle mailboxen waarvoor een gebruiker rechten heeft, inclusief Full Access, Send As en Send on Behalf. |
| **Check-Email-Usage.ps1** | Controleert of een e-mailadres in gebruik is binnen de organisatie (gebruikers, gedeelde mailboxen, distributiegroepen, contactpersonen). |
| **Export-AAD-Group-Memberships.ps1** | Exporteert Azure AD-groepslidmaatschappen van een specifieke groep naar een CSV-bestand. |
| **Manage-SharePoint-Online.ps1** | Bevat verschillende SharePoint Online-beheerfuncties, zoals het verbinden met SPO, het ophalen van redirect-sites en het verwijderen of hernoemen van sites. |
| **Export-Hub-Site-URLs.ps1** | Exporteert alle sites die gekoppeld zijn aan een hubsite in SharePoint Online. |
| **Change-SharePoint-Homepage.ps1** | Wijzigt de hoofdpagina van een SharePoint-site. |
| **Export-Users-SecurityGroup.ps1** | Exporteert gebruikers van een opgegeven beveiligingsgroep naar een CSV-bestand. |
| **AD-User-Group-Membership.ps1** | Haalt de groepslidmaatschappen van Active Directory-gebruikers op uit een CSV-bestand en exporteert de resultaten. |

## 🔧 Installatie en Vereisten

- PowerShell 7+ wordt aanbevolen.
- Vereiste modules moeten geïnstalleerd zijn:
  - **AzureAD**: `Install-Module AzureAD -Scope CurrentUser`
  - **ExchangeOnlineManagement**: `Install-Module ExchangeOnlineManagement -Scope CurrentUser`
  - **Microsoft.Online.SharePoint.PowerShell**: `Install-Module Microsoft.Online.SharePoint.PowerShell -Scope CurrentUser`
  - **PnP.PowerShell**: `Install-Module PnP.PowerShell -Scope CurrentUser`
  - **ActiveDirectory** (voor on-prem AD-scripts): `Install-WindowsFeature RSAT-AD-PowerShell`

## 🚀 Gebruik

Voer de scripts uit in een PowerShell-venster met de juiste rechten:

```powershell
# Voor het uitvoeren van een script
.\.\Export-Exchange-DistGroups.ps1
```

Voor scripts die inloggen bij een service, zoals Azure AD of Exchange Online, moet je eerst verbinding maken:

```powershell
Connect-AzureAD
Connect-ExchangeOnline -UserPrincipalName admin@domain.com
```

## 📌 Belangrijke Opmerkingen

- E-mailadressen en gebruikersnamen zijn vervangen door variabelen (`$EmailAddress`, `$UserName`, etc.) voor herbruikbaarheid.
- Zorg ervoor dat je over de juiste rechten beschikt om deze scripts uit te voeren.
- Sommige scripts schrijven gegevens weg naar `C:\Temp\`, zorg dat deze map bestaat of pas het pad aan.

## 🛠 Contributie

Wil je verbeteringen aanbrengen? Volg deze stappen:
1. Fork de repository
2. Maak een nieuwe branch
3. Implementeer je wijzigingen
4. Dien een merge request in 🎉

## 📞 Support

Heb je vragen of loop je ergens tegenaan? Open een issue of neem contact op met de beheerder van deze repository.

---
🚀 **Veel succes met automatiseren!** 🚀

