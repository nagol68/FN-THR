#
##
###
####
##### Run On SERVER-O365
####
###

#
##
### Call the Following if Connection has not Already been Established
##
#
#    Connect-MsolService
#    Connect-ExchangeOnline
#    Connect-MicrosoftTeams
#


#
# Start of Process
#

Clear-host

Write-Host "NOTICE: Please be sure that the email has already been created and licensed via M365 before using this script.`n"

 
 $email = Read-Host "`nEnter email of newly created user" #Gets email from input
 $username = $email -replace ("@(.*)","") #Remove @ and everything after
 $domain = $email -replace ("(.*)@","") #Remove @ and everything before
 
 $TeamsToAdd = Read-Host "`nEnter list of teams to be added (one per line)"
 $TeamsToAdd = $TeamsToAdd.Split([string[]]"`r`n", [StringSplitOptions]::None) #Split multi-lined string into list
 
  $TeamsIDs = ForEach ($Team in $TeamsToAdd) {
    $TeamID = Get-Team -DisplayName $Team | Where {$_.DisplayName -match "$Team$"} | Select -expand GroupID
    Add-TeamUser -GroupId $TeamID -User $email
 }
 
 if($domain -eq "gothrasher.com"){
 
        Set-MailboxFolderPermission $email`:\Calendar -user Default -AccessRights Reviewer
		Add-MailboxFolderPermission $email`:\Calendar -user ThrasherDefaultAuthor@gothrasher.com -AccessRights Reviewer
		
		
    }elseif($domain -eq "midwestfr.com"){
	
        Set-MailboxFolderPermission $email`:\Calendar -user Default -AccessRights Reviewer
		Add-MailboxFolderPermission $email`:\Calendar -user ThrasherDefaultAuthor@gothrasher.com -AccessRights Reviewer
		
		
    }elseif($domain -eq "supportworks.com"){
	
		Set-MailboxFolderPermission $email`:\Calendar -user Default -AccessRights Reviewer
		Add-MailboxFolderPermission $email`:\Calendar -user SupportworksDefaultAuthor@supportworks.com -AccessRights Author
		
	}elseif($domain -eq "hellogaragehq.com"){
	
		Set-MailboxFolderPermission $email`:\Calendar -user Default -AccessRights Reviewer
		Add-MailboxFolderPermission $email`:\Calendar -user SupportworksDefaultAuthor@supportworks.com -AccessRights Author
}
 