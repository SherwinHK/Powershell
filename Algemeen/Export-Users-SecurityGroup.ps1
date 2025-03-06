# Definieer de groepsnaam
$GroepNaam = "groepnaam"

# Haal alle leden van de opgegeven groep op
$members = Get-ADGroupMember -Identity $GroepNaam -Recursive | Where-Object { $_.objectClass -eq 'user' }

# Creëer een lege array om de resultaten op te slaan
$userInfo = @()

# Itereer door elk lid en haal de naam, e-mailadres, voornaam, achternaam en UPN op
foreach ($member in $members) {
    # Haal gebruikersinformatie op
    $user = Get-ADUser -Identity $member.SamAccountName -Properties DisplayName, EmailAddress, GivenName, Surname, UserPrincipalName

    # Splits eventuele tussenvoegsels van de achternaam
    $tussenvoegsel = ""
    $achternaam = $user.Surname
    if ($user.Surname -match '\s') {
        $achternaamParts = $user.Surname -split '\s'
        $tussenvoegsel = $achternaamParts[0]
        $achternaam = $achternaamParts[1]
    }

    # Voeg de gebruikersinformatie toe aan de array
    $userInfo += [PSCustomObject]@{
        Voornaam       = $user.GivenName
        Tussenvoegsel  = $tussenvoegsel
        Achternaam     = $achternaam
        EmailAdres     = $user.EmailAddress
        UPN            = $user.UserPrincipalName
    }
}

# Exporteer de resultaten naar een CSV-bestand
$userInfo | Export-Csv -Path "C:\temp\Gebruikers_Export.csv" -NoTypeInformation -Encoding UTF8

# Geef een bericht weer dat de export is voltooid
Write-Output "De gebruikersinformatie is succesvol geëxporteerd naar C:\temp\Gebruikers_Export.csv"
