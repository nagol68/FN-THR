$Mailbox = Read-Host "Enter User to check"
$UserId = (Get-Mailbox -Identity $Mailbox).ExternalDirectoryObjectId
$Teams = Get-Team
ForEach ($T in $Teams) {
    $TeamUsers = (Get-TeamUser -GroupId $T.GroupId | Select UserId) 
    If ($TeamUsers -Match $UserId) {
        Write-Host $Mailbox "found in" $T.DisplayName}
}