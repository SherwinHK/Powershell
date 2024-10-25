# Vervang 'user@domain.com' door het e-mailadres van de gebruiker die je wilt controleren
$User = 'user@contoso.com'

# Zoek alle mailboxen waar de gebruiker Full Access-rechten op heeft
$fullAccess = Get-Mailbox -ResultSize Unlimited | Get-MailboxPermission | Where-Object { $_.User -like $User -and $_.AccessRights -contains 'FullAccess' }

# Zoek alle mailboxen waar de gebruiker Send As-rechten op heeft
$sendAs = Get-Mailbox -ResultSize Unlimited | Get-RecipientPermission | Where-Object { $_.Trustee -like $User -and $_.AccessRights -contains 'SendAs' }

# Zoek alle mailboxen waar de gebruiker Send On Behalf-rechten op heeft
$sendOnBehalf = Get-Mailbox -ResultSize Unlimited | Get-Mailbox | Where-Object { $_.GrantSendOnBehalfTo -like "*$User*" }

# Toon de resultaten
$fullAccess | Select-Object Identity, User, AccessRights
$sendAs | Select-Object Identity, Trustee, AccessRights
$sendOnBehalf | Select-Object DisplayName, GrantSendOnBehalfTo
