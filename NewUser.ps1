function Show-Menu
{
    param (
        [string]$Title = 'Create New User'
    )
    Clear-Host
    Write-Host "================ $Title ================"
    
    Write-Host "Select user type"
    Write-Host "`n"
    Write-Host "`n1. Microsoft 365 Business Basic    | Office users with a standalone Microsoft Office licenses (RARE), sales, or service members."
    Write-Host "2. Microsoft 365 Business Standard | Office users with a new computer or inheriting a newer PC"
    Write-Host "3. Exchange Online (Plan 1)        | Utility accounts, service accounts, etc."
    Write-Host "4. Office 365 F3                   | Crew members. (Exchange and Teams only) (do not add Azure license to Installers)"
    Write-Host "Q: Press 'Q' to skip licensing."
}

$LicenseSKU = ""

$email = Read-Host Enter email of new user

$TeamsToAdd = Read-Host "Enter list of teams to be added (one per line)"
$TeamsToAdd = $TeamsToAdd.Split([string[]]"`r`n", [StringSplitOptions]::None)

Show-Menu –Title 'License Selection'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
         $LicenseSKU = "thrashercompanies:O365_BUSINESS_ESSENTIALS"
     } '2' {
         $LicenseSKU = "thrashercompanies:O365_BUSINESS_PREMIUM"
     } '3' {
         $LicenseSKU = "thrashercompanies:EXCHANGESTANDARD"
     } '4' {
         $LicenseSKU = "thrashercompanies:DESKLESSPACK"
     } 'q' {
         return
     }
 }
 

# Adding M365 License

Connect-MsolService

Set-MsolUserLicense -UserPrincipalName $email -AddLicenses $LicenseSKU

# Adding to Teams

Connect-MicrosoftTeams

$TeamsIDs = ForEach ($Team in $TeamsToAdd) {
    $TeamID = Get-Team -DisplayName $Team | Where {$_.DisplayName -match "$Team$"} | Select -expand GroupID
    Add-TeamUser -GroupId $TeamID -User $email
}

# Mailbox Permissions

Connect-ExchangeOnline

Set-MailboxFolderPermission `
    ${email}:\Calendar `
    -user Default `
    -AccessRights Reviewer
        
Add-MailboxFolderPermission `
    ${email}:\Calendar `
    -user ThrasherDefaultAuthor@gothrasher.com `
    -AccessRights Reviewer