Clear-Host

$Source = Read-Host "Enter user logon name to copy from"
$Target = Read-Host "Enter user logon name to copy to"

$CopyFromUser = Get-ADUser $Source -prop MemberOf 
$CopyToUser = Get-ADUser $Target -prop MemberOf 
$CopyFromUser.MemberOf | Where{$CopyToUser.MemberOf -notcontains $_} | Add-ADGroupMember -Members $CopyToUser