$OUpath = 'OU=Sales,OU=Des Moines,OU=Thrasher,DC=TBS,DC=local'
$Team = 'T: SolutionView Software'

$TeamID = Get-Team -DisplayName $Team | Where {$_.DisplayName -match "$Team$"} | Select -expand GroupID
$Users = Get-ADUser -Filter * -Properties EmailAddress -SearchBase $OUpath | Select -expand EmailAddress

ForEach ($User in $Users) {
	Add-TeamUser -GroupId $TeamID -User $User
}