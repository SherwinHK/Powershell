# Pad voor export
$outputFile = "C:\Temp\Distributiegroepen_Export.csv"

# Lijst om gegevens op te slaan
$results = @()

# Haal alle distributiegroepen op
$groups = Get-DistributionGroup

foreach ($group in $groups) {
    Write-Host "Verwerken van groep: $($group.DisplayName)"

    # Haal leden van de groep op
    $members = Get-DistributionGroupMember -Identity $group.Identity

    foreach ($member in $members) {
        $results += [PSCustomObject]@{
            GroepNaam  = $group.DisplayName
            LidNaam    = $member.Name
            LidType    = $member.RecipientType
            LidEmail   = $member.PrimarySmtpAddress
        }
    }
}

# Exporteer gegevens naar een CSV-bestand
$results | Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

Write-Host "Export voltooid! Resultaten opgeslagen in: $outputFile"
