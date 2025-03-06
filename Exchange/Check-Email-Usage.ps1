# Vul hier het te controleren e-mailadres in
$emailToCheck = "$EmailAddress"

# Verbinden met Exchange Online (indien nog niet verbonden)
if (!(Get-Command Get-Mailbox $UserName SilentlyContinue)) {
    Write-Host "Verbinding maken met Exchange Online..."
    Connect-ExchangeOnline -ShowProgress $true
}

# Controleer of het e-mailadres als primaire e-mail of alias bestaat
$found = $false

# Controleer bij gebruikers
$users = Get-Recipient -RecipientTypeDetails UserMailbox -Filter {EmailAddresses -like "*$emailToCheck*"}
if ($users) {
    Write-Host "E-mailadres gevonden bij gebruiker:" -ForegroundColor Green
    $users | Select-Object Name,PrimarySmtpAddress,EmailAddresses
    $found = $true
}

# Controleer bij gedeelde mailboxen
$sharedMailboxes = Get-Recipient -RecipientTypeDetails SharedMailbox -Filter {EmailAddresses -like "*$emailToCheck*"}
if ($sharedMailboxes) {
    Write-Host "E-mailadres gevonden bij een gedeelde mailbox:" -ForegroundColor Green
    $sharedMailboxes | Select-Object Name,PrimarySmtpAddress,EmailAddresses
    $found = $true
}

# Controleer bij distributiegroepen
$groups = Get-Recipient -RecipientTypeDetails MailUniversalDistributionGroup,MailUniversalSecurityGroup -Filter {EmailAddresses -like "*$emailToCheck*"}
if ($groups) {
    Write-Host "E-mailadres gevonden bij een distributiegroep:" -ForegroundColor Green
    $groups | Select-Object Name,PrimarySmtpAddress,EmailAddresses
    $found = $true
}

# Controleer bij contactpersonen
$contacts = Get-Recipient -RecipientTypeDetails MailContact -Filter {EmailAddresses -like "*$emailToCheck*"}
if ($contacts) {
    Write-Host "E-mailadres gevonden bij een contactpersoon:" -ForegroundColor Green
    $contacts | Select-Object Name,PrimarySmtpAddress,EmailAddresses
    $found = $true
}

# Als het e-mailadres nergens is gevonden
if (-not $found) {
    Write-Host "Het e-mailadres '$emailToCheck' is NIET in gebruik." -ForegroundColor Red
}

