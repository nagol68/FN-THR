#
# !!!Must call Connect-MicrosoftTeams before running!!!
#
# Paste entire list of users between single set of quotes
#

$TeamToAdd = "TEAM"

$Users = "USERS"

$Users = $Users.Split([string[]]"`r`n", [StringSplitOptions]::None)

$TeamID = Get-Team -DisplayName $TeamToAdd | Where {$_.DisplayName -match "$TeamToAdd$"} | Select -expand GroupID

ForEach ($User in $Users) {
    $User = $User + "@supportworks.com"
    Add-TeamUser -GroupId $TeamID -User $User
}