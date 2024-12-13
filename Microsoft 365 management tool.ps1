# Combined PowerShell Script for Various Administrative Tasks
# This script consolidates functionalities from multiple scripts and provides an interactive menu.

# Menu Display
function Show-Menu {
    Write-Host "---------------------------------------------" -ForegroundColor Yellow
    Write-Host " PowerShell Administrative Tool " -ForegroundColor Yellow
    Write-Host "---------------------------------------------" -ForegroundColor Yellow
    Write-Host "1. Export Azure AD Group Memberships"
    Write-Host "2. Export Exchange Online Distribution Groups"
    Write-Host "3. Enable Saving Sent Items in Shared Mailboxes"
    Write-Host "4. Find Mailbox Access by User"
    Write-Host "5. Export AD User Group Memberships"
    Write-Host "6. Exit"
}

# Main Program
while ($true) {
    Show-Menu
    $choice = Read-Host "Choose an option"

    switch ($choice) {
        "1" {
            Export-AzureADGroupMemberships
        }
        "2" {
            Export-ExchangeOnlineDistributionGroups
        }
        "3" {
            Save-SentItemsSharedMailbox
        }
        "4" {
            Find-MailboxAccessByUser
        }
        "5" {
            Export-ADUserGroupMembership
        }
        "6" {
            Write-Host "Exiting..." -ForegroundColor Cyan
            break
        }
        default {
            Write-Host "Invalid choice. Please try again." -ForegroundColor Red
        }
    }
}