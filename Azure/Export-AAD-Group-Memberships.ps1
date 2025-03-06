# Variabelen
$GroupName = "Groepnaam"
$OutputFile = "C:\temp\UserGroupMemberships.csv"

# Haal de groep op
$Group = Get-AzureADGroup -Filter "DisplayName eq '$GroupName'"

if ($Group -eq $null) {
    Write-Host "Groep $GroupName niet gevonden." -ForegroundColor Red
    exit
}

# Haal leden van de groep op
$GroupMembers = Get-AzureADGroupMember -ObjectId $Group.ObjectId -All $true

# Controleer lidmaatschap in andere groepen
$Results = @()

foreach ($Member in $GroupMembers) {
    # Haal alle groepen op waarvan de gebruiker lid is
    $UserGroups = Get-AzureADUserMembership -ObjectId $Member.ObjectId

    foreach ($Group in $UserGroups) {
        $Results += [PSCustomObject]@{
            UserPrincipalName = $Member.UserPrincipalName
            DisplayName       = $Member.DisplayName
            GroupName         = $Group.DisplayName
        }
    }
}

# Exporteer resultaten naar CSV
$Results | Export-Csv -Path $OutputFile -NoTypeInformation -Encoding UTF8

Write-Host "De groepslidmaatschappen zijn geëxporteerd naar $OutputFile" -ForegroundColor Green
