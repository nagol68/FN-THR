#
##
###
####
##### Run On SERVER-O365
####
###
#

function Show-Menu
{
    param (
        [string]$Title = 'Create New User'
    )
    Write-Host "`n================ $Title ================"
    
    Write-Host "Select user type"
    Write-Host "`n"
    Write-Host "`n1. Microsoft 365 Business Basic    | Office users with a standalone Microsoft Office licenses (RARE), sales, or service members."
    Write-Host "2. Microsoft 365 Business Standard | Office users with a new computer or inheriting a newer PC"
    Write-Host "3. Exchange Online (Plan 1)        | Utility accounts, service accounts, etc."
    Write-Host "4. Office 365 F3                   | Crew members. (Exchange and Teams only) (do not add Azure license to Installers)"
}

function First-Menu
{
    
    Write-Host "First user setup within the hour?"
    Write-Host "`n"
    Write-Host "`n1. Yes."
    Write-Host "2. No"
}

$LicenseSKU = ""

#Start-ADSyncSyncCycle -PolicyType Delta

Clear-host

First-Menu
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
         Connect-MsolService
         Connect-ExchangeOnline
         Connect-MicrosoftTeams
     } '2' {

     }
 }

Clear-host

Write-Host "`nAll fields must be filled out unless specified`n`nPaste each field directly from ticket"

$email = Read-Host "`nEnter email of new user"
$username = $email -replace ("@(.*)","") #Remove @ and everything after
$domain = $email -replace ("(.*)@","") #Remove @ and everything before

$mobile = Read-Host "`nEnter mobile number"
$mobile = $mobile -replace '\.','-'

$rc = Read-Host "`nEnter RC number (if applicable)"

$job = Read-Host "`nEnter job title"

$department = Read-Host "`nEnter department"

$location = Read-Host "`nEnter location"

$manager = Read-Host "`nEnter manager's username"

$TeamsToAdd = Read-Host "`nEnter list of teams to be added (one per line)"
$TeamsToAdd = $TeamsToAdd.Split([string[]]"`r`n", [StringSplitOptions]::None) #Split multi-lined string into list 

$Thrasher = $TRUE
if($domain -ne "thrasher.com")
{
    $Thrasher = $FALSE
}

Show-Menu –Title 'License Selection'
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
         $LicenseSKU = "thrashercompanies:O365_BUSINESS_ESSENTIALS","thrashercompanies:RIGHTSMANAGEMENT"
     } '2' {
         $LicenseSKU = "thrashercompanies:O365_BUSINESS_PREMIUM","thrashercompanies:RIGHTSMANAGEMENT"
     } '3' {
         $LicenseSKU = "thrashercompanies:EXCHANGESTANDARD"
     } '4' {
         $LicenseSKU = "thrashercompanies:DESKLESSPACK"
     }
 }
 
Write-Host "`nPlease wait..."

# Filling in AD attributes

Set-ADUser -Identity $username -Description $job -Office $location -MobilePhone $mobile -Department $department -Title $job -Manager $manager -PasswordNeverExpires $true -Email $email -EmailAddress "SMTP:$email"


if($rc){
	$rc = $rc -replace '\.','-'
    Set-ADUser -Identity $username -OfficePhone $rc
    }
    else{
    Set-ADUser -Identity $username -OfficePhone $mobile
}

if($domain -eq "gothrasher.com"){
    Set-ADUser -Identity $username -Company "Thrasher, Inc."
    }elseif($domain -eq "midwestfr.com"){
    Set-ADUser -Identity $username -Company "Midwest Foundation Repair"
    }elseif($domain -eq "supportworks.com"){
    Set-ADUser -Identity $username -Company "Supportworks, Inc."
}


# Adding M365 License

Set-Msoluser -UserPrincipalName $email -UsageLocation "US"
Set-MsolUserLicense -UserPrincipalName $email -AddLicenses $LicenseSKU

# Adding to Teams

$TeamsID = ForEach ($Team in $TeamsToAdd) {
    $TeamID = Get-Team -DisplayName $Team | Where {$_.DisplayName -match "$Team$"} | Select -expand GroupID
    Add-TeamUser -GroupId $TeamID -User $email
}

# Mailbox Permissions

if($Thrasher){
    Set-MailboxFolderPermission `
        ${email}:\Calendar `
        -user Default `
        -AccessRights Reviewer
        
    Add-MailboxFolderPermission `
        ${email}:\Calendar `
        -user ThrasherDefaultAuthor@gothrasher.com `
        -AccessRights Reviewer
}else{
    Set-MailboxFolderPermission `
        ${email}:\Calendar `
        -user Default `
        -AccessRights Reviewer
        
    Add-MailboxFolderPermission `
        ${email}:\Calendar `
        -user SupportworksDefaultAuthor@supportworks.com `
        -AccessRights Author
}

Write-host "`nUser Setup is Complete!"