#
# !!!Must call Connect-MicrosoftTeams before running!!!
#
# Paste entire list of Teams between single set of quotes
#

$TeamsToAdd = "TEAMS"

$User = "EMAIL"

$TeamsToAdd = $TeamsToAdd.Split([string[]]"`r`n", [StringSplitOptions]::None)

$TeamsIDs = ForEach ($Team in $TeamsToAdd) {
    $TeamID = Get-Team -DisplayName $Team | Where {$_.DisplayName -match "$Team$"} | Select -expand GroupID
    Add-TeamUser -GroupId $TeamID -User $User
}

