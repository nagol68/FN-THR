#Get the email of the user
$employee = get-mailbox -identity shannon.lewis@gothrasher.com  -ResultSize unlimited | select primarysmtpaddress
 
#Remove from Teams
Foreach ($user in $employee) {
 
    If ((Get-Team -User $user.primarysmtpaddress) -ne $null) {
        $teams = Get-Team -User $user.primarysmtpaddress
            foreach ($team in $teams){
                Remove-TeamUser -GroupId $team.GroupId -User $user.PrimarySmtpAddress
                Write-Output "$($user.PrimarySmtpAddress) is removed from team $($team.DisplayName)"
                }
        Write-Output "$($user.PrimarySmtpAddress) has been removed from $($teams.Count) teams"}
    else {
        Write-Output "$($bu.PrimarySmtpAddress) is not member of a team"
        }
    }