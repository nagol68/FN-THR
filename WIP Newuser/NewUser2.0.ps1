#
##
###
####
##### Run On SERVER-O365
####
###
#

#
# Menu Formats
#

function Command-Menu
{
    
    Write-Host "`nDo services need to be reconnected?"
    Write-Host "`n"
    Write-Host "`n1. Yes."
    Write-Host "2. No."
}

function Copy-User-Menu
{
    
    Write-Host "`nIs there a user that can be copied?"
    Write-Host "`n"
    Write-Host "`n1. Yes."
    Write-Host "2. No."
}

function Company-Menu
{
	Write-Host "`nWhich company is the hire for?"
    Write-Host "`n"
    Write-Host "`n1. Thrasher."
    Write-Host "2. Supportworks."
}

function THR-Location-Menu
{
    
    Write-Host "`nSelect Location"
    Write-Host "`n"
    Write-Host "`n1. Des Moines."
    Write-Host "2. Grand Island."
	Write-Host "3. Kansas City."
	Write-Host "4. Omaha."
	Write-Host "5. Sioux City."
	Write-Host "6. Springfield."
	Write-Host "7. Wichita"
}

function THR-Department-Menu
{
    
    Write-Host "`nSelect Department"
    Write-Host "`n"
    Write-Host "`n1. Production."
    Write-Host "2. Service."
	Write-Host "3. Sales."
	Write-Host "4. Office."
	Write-Host "5. Other."
}

function THR-Office-Menu
{
    
    Write-Host "`nSelect an Office Department"
    Write-Host "`n"
    Write-Host "`n1. Customer Care - Production."
    Write-Host "2. Customer Care - Sales & Service."
	Write-Host "3. Executive."
	Write-Host "4. Finance."
	Write-Host "5. HR."
	Write-Host "6. Legal."
	Write-Host "7. Marketing."
	Write-Host "8. Other."
}

function THR-Production-Menu
{
    
    Write-Host "`nSelect Job Title"
    Write-Host "`n"
    Write-Host "`n1. Installer."
    Write-Host "2. Lead Installer."
	Write-Host "3. Team Leader."
	Write-Host "4. Sr. Team Leader."
	Write-Host "5. Other."
}

function THR-Marketing-Menu
{
    
    Write-Host "`nSelect Job Title"
    Write-Host "`n"
    Write-Host "`n1. Brand Ambassador."
	Write-Host "2. Other."
}

function Title-Menu
{
	Write-Host "`nIs the above title correct for $fullName"
    Write-Host "`n"
    Write-Host "`n1. Yes."
    Write-Host "2. No."
}

#
# Variables
# 
$licenseSKU = ""
$company = ""
$location = ""

#Start-ADSyncSyncCycle -PolicyType Delta

Clear-host

Command-Menu
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

Write-Host "`nAll fields must be filled out unless specified`n`n--Paste each field directly from ticket--"

$fullName = Read-Host "`nEnter full name of new user" #Gets full name from input
$firstName = $fullName -replace (" (.*)","") #Remove everything after the space
$lastName = $fullName -replace ("(.*) ","") #Remove everything before the space
$SAMName = $firstName+"."+$lastName #Formats name into first.last
#
#    THIS NEEDS UPDATED TO WORK FOR SUPPORTWORKS
#    DO THIS!!!!!!!!!!!!!!!!!!!!!!!!!
#    IMPORTANT!!!!!!!!!!!!!!!!!!!!!!!
#


$password = Read-Host "`nEnter a password for the new user" #Gets password from input



Copy-User-Menu
 $selection = Read-Host "Please make a selection"
 switch ($selection)
 {
     '1' {
		#
        # Copying User
		#
        $copiedUser = Read-Host "`nPlease enter the username of the user to be copied" #Gets user based on input
		$copiedAttributes = Get-ADUser -Identity $copiedUser -Properties Office,Department,Manager,Title,Company #Gets attributes
        $OU = ($copiedAttributes).DistinguishedName.split(",",2)[1] #Gets OU
		
        #Creating new user
		New-ADUser `
            -Name $fullName -GivenName $firstName -Surname $lastName -SAMAccountName $SAMName -DisplayName $fullName `
			-Path $OU `
			-Manager $copiedAttributes.Manager -Office $copiedAttributes.Office -Department $copiedAttributes.Department -Company $copiedAttributes.Company `
			-AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -ChangePasswordAtLogon $false `
			-Enabled $true

        #Menu to check if title is the same as copied user
        Write-Host "`nTitle: "+$copiedAttributes.Title
        Title-Menu
        $selection = Read-Host "Please make a selection"
         switch ($selection)
         {
            '1' {
                #Sets title the same as copied user
                $title = $copiedAttributes.Title
            } '2' {
                #Sets new title based on user input
                $title = Read-Host "`nPlease enter $fullName's title"
            }
        }

        #Sets title
        Set-ADUser -Identity $SAMName -Title $title 

        #Copies membership
        $copiedMembership = Get-ADUser $copiedUser -prop MemberOf
        $newMembership = Get-ADUser $SAMName -prop MemberOf
        $copiedMembership.MemberOf | Where{$newMembership.MemberOf -notcontains $_} |  Add-ADGroupMember -Member $newMembership

		
     } '2' {
		#
        # Net-New User
        #



     }
 }