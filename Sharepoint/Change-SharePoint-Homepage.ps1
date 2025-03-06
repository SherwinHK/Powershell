Install-Module -Name Microsoft.Online.SharePoint.PowerShell -Force -AllowClobber
Connect-SPOService -Url $Sharepoint_AdminCenterURL
Invoke-SPOSiteSwap -SourceUrl "$NewSite" `
                   -TargetUrl "$SharepointURL" `
                   -ArchiveUrl "$OldSite"