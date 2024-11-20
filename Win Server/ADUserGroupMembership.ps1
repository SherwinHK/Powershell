# Pad naar je CSV-bestand
$csvPath = "C:\temp\gebruikerslijst.csv"

# Controleer of Active Directory module geladen is
if (-not (Get-Module -ListAvailable -Name ActiveDirectory)) {
    Write-Error "Active Directory-module is niet beschikbaar. Zorg dat deze geïnstalleerd is."
    exit
}

# Importeer de CSV
try {
    $users = Import-Csv -Path $csvPath
} catch {
    Write-Error "Kan CSV-bestand niet laden. Controleer het pad: $csvPath"
    exit
}

# Resultaatbestand
$outputFile = "C:\temp\gebruikersgroepen.csv"
$result = @()

# Itereer door gebruikers en haal groepslidmaatschap op
foreach ($user in $users) {
    $samAccountName = $user.SamAccountName

    if ([string]::IsNullOrWhiteSpace($samAccountName)) {
        Write-Warning "Lege gebruikersnaam gevonden, overslaan."
        continue
    }

    try {
        # Groepen ophalen
        $groups = Get-ADUser -Identity $samAccountName -Properties MemberOf | Select-Object -ExpandProperty MemberOf

        if ($groups) {
            foreach ($group in $groups) {
                # Groepnaam ophalen
                $groupName = (Get-ADGroup -Identity $group).Name
                $result += [PSCustomObject]@{
                    UserName = $samAccountName
                    GroupName = $groupName
                }
            }
        } else {
            $result += [PSCustomObject]@{
                UserName = $samAccountName
                GroupName = "Geen groepen"
            }
        }
    } catch {
        Write-Warning "Kon groepen niet ophalen voor gebruiker $samAccountName $_"
    }
}

# Schrijf resultaat naar CSV
$result | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

Write-Output "Groepen van gebruikers zijn opgeslagen in: $outputFile"
